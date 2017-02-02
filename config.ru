require './server'
require 'rack-zippy'

class CorsMiddleware
  def initialize app
    @app = app
  end

  def call env
    status, headers, body = @app.call env

    headers['Cache-Control'] = 'public, max-age=0, no-transform'

    [status, headers, body]
  end
end

`bundle exec middleman build`

use CorsMiddleware
use Rack::Zippy::AssetServer, 'public'
run Sinatra::Application
