#!/usr/bin/env ruby

# CREDIT:
# https://milesalan.com/notes/naming-workspaces-in-i3/

require 'json'
JSON.parse(%x[i3-msg -t get_workspaces]).each do |workspace|
    if (workspace['focused']) then
        number = workspace['name'].split(/:/)[0]
        newName = "#{number}: #{ARGV[0].chomp}"
        %x[i3-msg 'rename workspace "#{workspace['name']}" to "#{newName}"']
        %x[i3-msg 'bindsym Mod4+#{number} workspace "#{newName}"']
    end
end
