# PasteRunner built by Tejas Manohar
# Released under the MIT License (mit-license.org)
# Open source on GitHub: http://github.com/tejasmanohar/pasterunner


# Gems
require 'faraday'
require 'json'
require 'sinatra'

configure do
  enable :protection
end


# Views
get '/' do
  erb :home
end

not_found do
  erb :not_found
end


# API
post '/exec' do
  id = params[:url].split('/')[-1]
  p id
  res = Faraday.get('https://api.github.com/gists/' + id)
  data = JSON.parse(res.body)
  code = data['files'].values.map { |h| h['content'] }

  content_type :json
  { code: code }.to_json
end
