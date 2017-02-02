require 'sinatra'
require 'net/http'

get '/' do
  File.read(File.join('public', 'index.html'))
end

not_found do
  File.read(File.join('public', '404.html'))
end