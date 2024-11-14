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

      config.middleware.use RequestTimerMiddleware  

    # config.middleware.insert_before 0, RequestTimerMiddleware

    # config.middleware.insert_after Rails::Rack::Logger, RequestTimerMiddleware

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
