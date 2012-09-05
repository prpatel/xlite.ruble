require 'ruble'

bundle do |bundle|
  bundle.display_name = 'xlite.ruble'
  bundle.author = 'Pratik Patel'
  bundle.copyright = <<END
(c) Copyright 2012 mypatelspace.com
Distributed proprietary license.
END

bundle.description = <<END
This Ruble is to be used in Titanium Studio. The purpose of this Ruble is to 
make developing Titanium Mobile applications faster. This package offers several functions:
1) A REPL for a running Titanium iOS simulator or Android emulator.
2) Dynamic code update or insertion
3) Code completions and accelerators for a single-context Titanium Mobile project
END

  # uncomment with the url to the git repo if one exists
# bundle.repository = 'git@github.com:prpatel/xlite.ruble.git'

  # Use Commands > Bundle Development > Insert Bundle Section > Menu
  # to easily add new sections
  bundle.menu 'xlite.ruble' do |menu|
    menu.command 'Start Server'
    menu.command 'Send Code'
    menu.command 'Run Last'
    menu.command 'Invoke REPL'
    menu.command 'Run test'
    menu.command 'Mark test'    
    menu.separator
    menu.menu 'Configure xlite' do |sub_menu|
        sub_menu.command 'Set'
    end
  end
end