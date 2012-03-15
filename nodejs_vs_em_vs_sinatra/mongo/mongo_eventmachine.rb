require 'rubygems'
require 'eventmachine'
require 'evma_httpserver'
require 'em-mongo'

class Handler < EventMachine::Connection
  include EventMachine::HttpServer

  def process_http_request
    resp = EventMachine::DelegatedHttpResponse.new( self )
    CONN.insert( { :eventmachine => "test" } )

    resp.status = 200
    resp.content = "Hello World\n"
    resp.send_response
  end
end

EventMachine::run {
  DB = EM::Mongo::Connection.new('localhost').db('test')
  CONN = DB.collection('em')

  EventMachine.epoll
  EventMachine::start_server("0.0.0.0", 3000, Handler)
  puts "Listening..."
}
