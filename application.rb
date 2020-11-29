require 'sinatra'
require 'json'
require_relative 'services/diffcheker'

get '/' do
  erb :index
end

post "/?" do
  content_type :json
  ::Services::DiffChecker.new(params[:left], params[:right]).call
end
