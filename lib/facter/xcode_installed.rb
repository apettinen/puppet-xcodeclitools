#!/usr/bin/env ruby
# xcode_installed.rb
# This Facter custom fact returns true if xcode is installed
# Antti Pettinen
# Copyright: Tampere University of Technology
require 'facter'
Facter.add(:xcode_installed) do
  confine :kernel => "Darwin"
  setcode do
    
end
