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
class XcodeCLI {
  file { 'set_installondemand':
    ensure => present,
    path   =>
    '/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress',
    mode   => '0644',
    owner  => 'root',
    group  => 'wheel',
    before => Exec['install_Xcode_CLI_Tools'],
  }

  exec { 'install_Xcode_CLI_Tools':
    command => '',
    # path => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    # refreshonly => true,
    notify  => File['remove_installondemand'],
  }

  file { 'remove_installondemand':
    ensure => absent,
    path   => '/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress',
  }
}
