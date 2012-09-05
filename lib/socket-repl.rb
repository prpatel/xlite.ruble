# require 'xlite-server'
$: << File.dirname(__FILE__) + '/../lib/eventmachine/lib'
require 'eventmachine'

class SocketRepl
  attr_reader :remote_connection
    def initialize(console)
     # console.puts 'NOT creating SocketRepl, start one from command line'
     console.puts 'NOT creating SocketRepl, start xlite-server-standalone.rb manually'
   #  @remote_connection = XliteServer.new(console)
   #  @remote_connection.start()   
    @connection = nil 
    end
  EventChannel = EM::Channel.new
  
  class XliteClient < EventMachine::Connection
      def initialize(*args)
        super
        @client = args.last
        @disconnected = false
      end

      def disconnected?
        @disconnected
      end
          
    def receive_data(data)
      #  console.puts data
    end
  
    def unbind
       @disconnected = true
      console.puts ' client connection totally closed'
    end
  end

  def openConnection    
    Thread.start {
      EventMachine.run { 
        @connection =  EventMachine.connect '127.0.0.1', 8485, XliteClient, self 
      }    
    }
    sleep 1
  end

  def sendJS(jsString)
    begin
     # @remote_connection.sendJS(jsString)
        openConnection if @connection.nil? || @connection.disconnected?
     #      EventMachine.run { 
     #         @connection =  EventMachine.connect '127.0.0.1', 8485, XliteClient, self
     #         @connection.send_data(jsString) 
     #       } 
     #   sleep 1
        @connection.send_data(jsString) 
    rescue Exception => e  
      CONSOLE.puts e.message       
      CONSOLE.puts 'error sending'
    end

    CONSOLE.puts "sent following to running Titanium App : #{jsString}\n"

  end
end