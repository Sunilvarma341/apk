

class RequestTimerMiddleware 
  
  REQUEST_ID = "X-Request-Id"


  def initialize(app) 
   @app =  app 
  end

  def call(env)
   start_time =   Time.now 
  # Handle preflight OPTIONS request
   cors_headers
   Rails.logger.info  "request took  rails start  #{@app}"

  request_id = generate_request_id(env)
  @app.call(env).tap do |_status, headers, _body| 
    headers[REQUEST_ID] = request_id
  end

  status, headers, response = @app.call(env)


   duration = Time.now - start_time
  #  Rails.logger.info  "request took  #{duration} ///////// #{status} ===  #{headers}"
   [status ,  headers  ,  response]
  end


  private 

  def generate_request_id(env)
    ####### env means it environment hash that contains information about the current HTTP request.
    res =  ActionDispatch::Request.new  env 

    request_id =  res.headers[REQUEST_ID]

    if request_id.presence
      request_id.gsub(/[^\w\-@]/, "").first(255)
    else 
      build_request_id
    end
  end

  def build_request_id 
    SecureRandom.uuid
  end

  def cors_headers
    {
      "Access-Control-Allow-Origin" => "http://localhost:3000",
      "Access-Control-Allow-Methods" => "GET, POST, PUT, PATCH, DELETE, OPTIONS, HEAD",
      "Access-Control-Allow-Headers" => "Content-Type, Authorization",
      "Access-Control-Allow-Credentials" => "true",
    }
  end
end
