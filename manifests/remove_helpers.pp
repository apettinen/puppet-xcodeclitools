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

  exec { 'remove_installondemand':
    command => 'rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress',
    path    => '/bin',
  }
  exec { 'remove_xcode_cli_install_script':
    command => "rm ${script_dir}/install_xcode_cli_tools.sh",
    path    => '/bin',
  }
}
