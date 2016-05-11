# Class: xcodeclitools::remove_helpers
# ===========================
#
# Removes install_xcode_cli_tools.sh and
# /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress files
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
define xcodeclitools::remove_helpers (
  String $script_dir = $xcodeclitools::xcode_install_script_dir
  ) {
  validate_string($script_dir)
  # file { 'remove_installondemand':
  #   ensure => absent,
  #   path   =>
  #   '/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress',
  #   # subscribe => Exec['install_Xcode_CLI_Tools'],
  # }
  #
  # file { 'remove_xcode_cli_install_script':
  #   ensure => absent,
  #   path   => "${script_dir}/install_xcode_cli_tools.sh",
  #   # subscribe => Exec['install_Xcode_CLI_Tools'],
  # }
  exec { 'remove_installondemand':
    command => 'rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress',
    path    => '/bin',
    #require =>  File['xcodeclitools::set_installondemand']
  }
  exec { 'remove_xcode_cli_install_script':
    command => "rm ${script_dir}/install_xcode_cli_tools.sh",
    path    => '/bin',
    # refreshonly => true,
  }
}
