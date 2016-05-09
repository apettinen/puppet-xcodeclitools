#!/usr/bin/env ruby
# xcode_installed.rb
# This Facter custom fact returns true/false if xcode is/is not installed
# Currently supports only Xcode installed in default dir (/Application/Xcode)
# Additionally, the checking is a bit stupid
# Parsing could also be done with CFPropertyList gem
# Antti Pettinen
# Copyright: Tampere University of Technology
require 'facter'
#require 'CFPropertyList'
Facter.add(:xcode_installed) do
  confine :kernel => 'Darwin'
  setcode do
    if Facter.value(:xcode_version)
      'true'
    else
      'false'
    end
end
