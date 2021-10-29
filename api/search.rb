# frozen_string_literal: true

require 'json'
require 'cgi'
require 'uri'
require 'net/http'

Handler = proc do |req, res|
  search_query = CGI.parse(req.query_string).transform_values(&:first)['query']

  uri = URI('https://readcomicsonline.ru/search')
  params = { query: search_query }
  uri.query = URI.encode_www_form(params)

  response = Net::HTTP.get_response(uri)

  res.status = 200
  res['Content-Type'] = 'application/json; charset=utf-8'
  res.body = JSON.parse(response.body)['suggestions'].to_json
end
