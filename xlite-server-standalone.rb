$: << File.dirname(__FILE__) + '/lib/eventmachine/lib'
require 'eventmachine'

class XliteServer
  HOST = 'localhost'          # running on localhost
  
  def initialize(console1)
    @console = console1
    @console.puts 'starting XLITESERVER....'
  end
    # Create a channel to push data
    EventChannel = EM::Channel.new
     class BroadcastServer < EM::Connection
       def self.start(host = '', port = 8484)
         EM.start_server(host, port, self)
       end
   
       def post_init
        STDOUT.puts 'client connected to broadcaster'
         send_data "Welcome to XenonLite"
   
         # send_chunk "<html><body>";
   
         @sid = EventChannel.subscribe do |m|
          # send_chunk "#{m.strip}<br />"
           send_data "#{m}"
         end
       end
   
       def send_chunk c
         send_data (c.length.to_s(16)+"\r\n"+c+"\r\n")
       end
   
       def unbind
         EventChannel.unsubscribe @sid
       end
     end

 # This server recieves events to broadcast to channel subscribers
     class EventListener < EM::Connection
       def self.start(host = '', port = 8485)
         EM.start_server(host, port, self)
       end
       def post_init
        STDOUT.puts 'client connected to sender'
        send_data "Welcome to XenonLite"
       end  


       def receive_data(data)
         EventChannel << data
       end
       def unbind
         STDOUT.puts 'client disconnected connected to sender'
       end       
     end     
        
  def start()
    @console.puts 'starting event machine....' 
     
    EM.run do
      EM.epoll

      BroadcastServer.start
   
      EventListener.start
    end
    end
             

end
server = XliteServer.new(STDOUT)
server.start