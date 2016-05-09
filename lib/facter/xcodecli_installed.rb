#!/usr/bin/env ruby
# xcode_cli_installed.rb
# This Facter custom fact returns true if Xcode CLI Tools is installed
# Copyright: Tampere University of Technology
require 'facter'
Facter.add(:xcode_cli_installed) do
  confine :kernel => "Darwin"
  setcode do
end
