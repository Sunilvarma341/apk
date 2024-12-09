require_relative "boot"

require "rails/all"
require_relative '../app/middleware/request_timer_middleware'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Apk
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    # config.autoload_paths += %W(#{config.root}/app/lib)
    config.autoload_paths += %W(
      #{config.root}/app/middleware
      #{config.root}/app/lib
    )
#############################
      #  eager loads means fetching the data at one egar methods it having 
      config.eager_load = true
      config.eager_load_paths +=   %W(#{config.root}/app/middleware/request_timer_middleware.rb)
      #  puts "Loaded classes: #{Rails.application.eager_load_namespaces}"   

      
      
      
      # cross origin resourese sharing 
      config.middleware.insert_before 0, Rack::Cors do
        allow do
          origins 'localhost:3000', /https*:\/\/.*?bloopist\.com/
          resource '*', :headers => :any, :methods => :any
        end
      end
      
      config.middleware.use RequestTimerMiddleware

    # config.middleware.insert_before 0, RequestTimerMiddleware

    # config.middleware.insert_after Rails::Rack::Logger, RequestTimerMiddleware


    # below code is used for  end points for websockets 
    # config.action_cable.mount_path = "/cable"  # this is the  one way to create single end point 
    # multiple end point 
      

###############################
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
