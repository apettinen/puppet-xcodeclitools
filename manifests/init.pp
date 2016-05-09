# Class: XcodeCLI
# ===========================
#
# Install XCode Command Line Tools. Compatible with OS X versions 10.9 - 10.11
# Utilizes the Apple SUS to install the tools; configure SUS according to
# your environment.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'XcodeCLI':
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
class XcodeCLI (
  String $Xcode_install_script_dir = '/tmp/',
  )
  {
  if $::operatingsystem != 'Darwin' {
    fail('This module is only for OS X machines')
  }
  elsif $::operatingsystemmajrelease >= 15 {
    if $::xcode_cli_installed == 'false' {
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
        source => 'puppet:///modules/XcodeCLI/install_xcode_cli_tools.sh',
        path   => '/tmp/install_xcode_cli_tools.sh'
        mode   => '0700',
        owner  => 'root',
        group  => 'wheel',
        notify => Exec['install_Xcode_CLI_Tools'],
      }

      exec { 'install_Xcode_CLI_Tools':
        command => '',
        # /usr/sbin/softwareupdate
        #PROD=$(softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n')
      # install it
      #softwareupdate -i "$PROD" -v
        # path => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
        # refreshonly => true,
        #require => Exec['get_Xcode_CLI_version'],
        require => File['set_installondemand'],
        notify  => File['remove_installondemand'],
      }

      file { 'remove_installondemand':
        ensure => absent,
        path   =>
        '/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress',
      }

      file { 'remove_xcode_cli_install_script':
        ensure => absent,
        path   => ''
      }


    }

  }
  else {
    fail('This module supports only OS X versions 10.9 or above')
  }

}
