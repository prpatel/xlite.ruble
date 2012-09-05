require 'ruble'
require 'socket-repl'
    
@last_invoked_js = ''
# @repl = nil;

command "Start Server" do |cmd|
  cmd.key_binding = 'SHIFT+CTRL+S' # uncomment for a key binding      
      cmd.invoke do |context|  
      #  if !@repl 
          CONSOLE.puts 'creating new SocketRepl'
          @repl = SocketRepl.new(CONSOLE)
          @repl.openConnection
      #  end
        end    
end


command "Send Code" do |cmd|
    cmd.key_binding = 'SHIFT+CTRL+A' # uncomment for a key binding
    
    cmd.invoke do |context|

    if  @repl.nil?
      
    end      
      #Ruble::UI.alert(:info, 'Title', 'Message')
      #result =  Ruble::UI.request_string()
      #require('multi_line_editor')
      help_text = 'Enter in JavaScript to execute in the simulator/emulator'
      doc = context.editor.document.get
      # CONSOLE.puts selectedText
      # dialog = MultiInputDialog.new(org.eclipse.swt.widgets.Display.current.active_shell, 'Titanium REPL', help_text, selectedText.text, nil)
      # return_value = dialog.value if dialog.open == org.eclipse.jface.window.Window::OK
      # if return_value != ''
        @last_invoked_js = doc
        @repl.sendJS(doc)
        CONSOLE.puts 'SENT ' 
        # CONSOLE.puts (return_value)
        
  end
end

command "Run test" do |cmd|
    cmd.key_binding = 'SHIFT+CTRL+T' # uncomment for a key binding
    cmd.invoke do |context|
      #Ruble::UI.alert(:info, 'Title', 'Message')
      #result =  Ruble::UI.request_string()
      # require('multi_line_editor')
      help_text = 'Enter in JavaScript to execute in the simulator/emulator'
      if @last_invoked_test == '' || @last_invoked_test.nil?
        @last_invoked_test = context.editor.document.get
      end
        @repl.sendJS(@last_invoked_test)
        CONSOLE.puts 'SENT TEST' 
  end
end

command "Mark test" do |cmd|
    cmd.key_binding = 'SHIFT+CTRL+Y' # uncomment for a key binding
    cmd.invoke do |context|
      help_text = 'Enter in JavaScript to execute in the simulator/emulator'
        @last_invoked_test = context.editor.document.get
        CONSOLE.puts 'Marked test as current file' 
  end
end

command 'Invoke REPL' do |cmd|
    cmd.key_binding = 'SHIFT+CTRL+Z' # uncomment for a key binding  
    cmd.invoke do |context|
      #Ruble::UI.alert(:info, 'Title', 'Message')
      #result =  Ruble::UI.request_string()
      require('multi_line_editor')
      help_text = 'Enter in JavaScript to execute in the simulator/emulator'
      selectedText = context.editor.selection
      CONSOLE.puts selectedText
      dialog = MultiInputDialog.new(org.eclipse.swt.widgets.Display.current.active_shell, 'Titanium REPL', help_text, selectedText.text, nil)
      return_value = dialog.value if dialog.open == org.eclipse.jface.window.Window::OK
      if return_value != ''
        @last_invoked_js_repl = return_value
        context.exit_show_tool_tip('Result: ' + @repl.sendJS(return_value))
        # CONSOLE.puts (return_value)
      end
    end
end

command "Run Last" do |cmd|

    cmd.invoke do |context|
      #Ruble::UI.alert(:info, 'Title', 'Message')
      #result =  Ruble::UI.request_string()
      return_value = @last_invoked_js_repl
      CONSOLE.puts return_value
      if return_value != ''
        context.exit_show_tool_tip('Result: ' + @repl.sendJS(return_value))
        # CONSOLE.puts (return_value)
      else
        context.exit_show_tool_tip('No last REPL command to run')
      end
  end
end



# Use Commands > Bundle Development > Insert Bundle Section > Command
# to easily add new commands