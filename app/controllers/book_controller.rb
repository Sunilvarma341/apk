class BookController < ApplicationController

  # this api  for skip  and limit 
  def getBooks 
    offset =  params.fetch(:offset,  0 ).to_i
    render json: {status: true} 
  end

end
