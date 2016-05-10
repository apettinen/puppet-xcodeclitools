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
  file { 'remove_installondemand':
    ensure => absent,
    path   =>
    '/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress',
    # subscribe => Exec['install_Xcode_CLI_Tools'],
  }

  file { 'remove_xcode_cli_install_script':
    ensure => absent,
    path   => "${script_dir}/install_xcode_cli_tools.sh",
    # subscribe => Exec['install_Xcode_CLI_Tools'],
  }
}
