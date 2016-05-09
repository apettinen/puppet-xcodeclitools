#!/usr/bin/env ruby
# xcode_cli_installed.rb
# This Facter custom fact returns true if Xcode CLI Tools is installed
# either with Xcode or as separate bundle
# Antti Pettinen
# Copyright: Tampere University of Technology
require 'facter'
Facter.add(:xcode_cli_installed) do
  confine :kernel => 'Darwin'
  setcode do
    clitools_receipt = Facter::Util::Resolution.exec('/usr/sbin/pkgutil --pkgs=com.apple.pkg.CLTools_Executables 2>/dev/null')
    if Facter.value(:xcode_installed) == 'true'
      'true'
    elsif clitools_receipt == 'com.apple.pkg.CLTools_Executables'
      'true'
    else
      'false'
    end
  end
end
