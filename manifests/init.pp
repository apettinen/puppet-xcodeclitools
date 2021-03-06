# Class: xcodeclitools
# ===========================
#
# Install XCode Command Line Tools. Compatible with OS X versions 10.9 - 10.11
# Utilizes the Apple SUS to install the tools; configure SUS according to
# your environment.
#
# Parameters
# ----------
#
# * `xcode_install_script_dir`
#  sets the directory where Xcode install script is temporarily stored.
# Defaults to /tmp, could also be /usr/local/
#
# Examples
# --------
#
# @example
#    class { 'xcodeclitools':
#
#    }
#
# Authors
# -------
#
# Antti Pettinen <antti.pettinen@tut.fi>
#
# Copyright
# ---------
#
# Copyright 2016 Tampere University of Technology
#

class xcodeclitools (
  String $xcode_install_script_dir = '/tmp'
  ) {
  validate_string($xcode_install_script_dir)

  if $::operatingsystem != 'Darwin' {
    fail('This module is only for OS X machines')
  }
  elsif $::operatingsystemmajrelease >= '15' and $::xcode_cli_installed == false {
  #if $::xcode_cli_installed == false {
    # installing Xcode Command Line Tools from SUS specified source
    file { 'set_installondemand':
      ensure => present,
      path   =>
      '/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress',
      mode   => '0644',
      owner  => 'root',
      group  => 'wheel',
      before => Exec['install_Xcode_CLI_Tools'],
    }

    file { 'xcode_cli_install_script':
      ensure => file,
      source => 'puppet:///modules/xcodeclitools/install_xcode_cli_tools.sh',
      path   => "${xcode_install_script_dir}/install_xcode_cli_tools.sh",
      mode   => '0700',
      owner  => 'root',
      group  => 'wheel',
      before => Exec['install_Xcode_CLI_Tools'],
    }

    exec { 'install_Xcode_CLI_Tools':
      command => "${xcode_install_script_dir}/install_xcode_cli_tools.sh",
      require => [
                  File['set_installondemand'],
                  File['xcode_cli_install_script'],
                  ],
      before  => Xcodeclitools::Remove_helpers['remove_helper_files'],
    }
    xcodeclitools::remove_helpers {'remove_helper_files':
    }
  }
  elsif $::xcode_cli_installed == true {
    #notice('Xcode Command Line Tools is installed')
  }
  else {
    fail('This module supports only OS X versions 10.9 or above')
  }
}
