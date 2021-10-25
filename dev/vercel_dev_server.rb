# frozen_string_literal: true

require 'webrick'
# HEYDEV! require your functions here
require_relative '../api/date'

# puts `pwd`
# Dir['./api'].each do |file_path|
#   handler_content = File.read(file_path)
# end

module WEBrick
  module HTTPServlet
    class FileHandler
      alias do_POST do_GET
    end
  end
end

root = File.expand_path '.'
server = WEBrick::HTTPServer.new Port: 8000, DocumentRoot: root

# Define endpoints
# HEYDEV! use yours here
server.mount '/api/date', TestWR::Handler

# Start the server
trap 'INT' do server.shutdown end

server.start
