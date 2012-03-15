require 'rubygems'
require 'eventmachine'
require 'evma_httpserver'


class Handler < EventMachine::Connection
  include EventMachine::HttpServer

  def process_http_request
    resp = EventMachine::DelegatedHttpResponse.new( self )
    resp.status = 200
    resp.content = "Hello World\n"
    resp.send_response
  end
end

EventMachine::run {
  EventMachine.epoll
  EventMachine::start_server("0.0.0.0", 3000, Handler)
  puts "Listening... 3000"
}
