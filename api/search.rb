require 'json'
require 'cgi'

Handler = Proc.new do |req, res|
  query_string = CGI.parse(req.query_string).transform_values(&:first)
  res.status = 200
  res['Content-Type'] = 'application/json; charset=utf-8'
  res.body = query_string.to_json
end
