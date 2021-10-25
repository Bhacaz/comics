# Handler = Proc.new do |req, res|
#   res.status = 200
#   res['Content-Type'] = 'text/text; charset=utf-8'
#   res.body = "Current Time: #{Time.new}"
# end


require 'webrick'
require 'json'

# HEYDEV! Edit module name and action_on() body in order to write your own function
module TestWR
  class Handler < WEBrick::HTTPServlet::AbstractServlet
    def do_GET req, res
      status, content_type, body = self.class.action_on req

      res.status = 200
      res['Content-Type'] = 'application/json; charset=utf-8'
      res.body = { current_time: Time.now }.to_json
    end

    def self.action_on _req
      {status: 200, "Content-Type": 'text/plain', body: 'you got a page' }
    end
  end
end

# Avoids name conflicts when multiple functions are present in the /api folder
Handler = Proc.new do |req, res|
  return TestWR::Handler # HEYDEV! Refer to your custom module
end
