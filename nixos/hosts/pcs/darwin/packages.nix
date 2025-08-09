{ pkgs }:

#  Darwin Specific Modules for Installation
with pkgs; [
  # General packages for development and system management
  alacritty
  coreutils
  mkalias
#  openssh

  # Encryption and security tools
#  gnupg
#  libfido2

  # Cloud-related tools and SDKs
  docker
  docker-compose

  # Media-related packages
#  dejavu_fonts
  ffmpeg
  font-awesome
  hack-font
#  noto-fonts
#  noto-fonts-emoji
#  meslo-lgs-nf

  # Node.js development tools
#  nodejs_24

  # Python packages
  python3
  virtualenv
]
