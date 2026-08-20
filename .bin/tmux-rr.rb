#!/usr/bin/env ruby

require 'shellwords'
require 'open3'

SESSIONS_FORMAT = '#{session_name}'

def save
  out, status = Open3.capture2e("tmux", "list-sessions" , '-F', '#{session_name}')
  sessions = `tmux list-sessions -F '\#{session_name}'`.lines(chomp: true)
  for session_name in sessions do
    windows = `tmux list-windows -t '#{session_name}' -F '\#{window_name}'`
    p session_name
  end
end

def restore
end

save
