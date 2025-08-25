# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5; # Limit configurations shown on boot menu.

  # Enable flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos-server"; # Define your hostname.

  # // KTL // (Keymap, Timezone, Locale)

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # // BASIC SERVICES //
  
  # Enable networking.
  networking.networkmanager.enable = true;

  # Enable X11 windowing system and GNOME Desktop Environment.
  services.xserver.enable = false;

  # Disable unused services.
  services.printing.enable = false;

  # Enable sound with pipewire.
  /*
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  */

  # // PACKAGES / PROGRAMS

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lykle = {
    isNormalUser = true;
    description = "Lykle";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
    hashedPassword = "$2b$05$kJV9j8Yiptocft.1T9ycseNuMlF7heEVAflT1Y.lq0X2wihPRFRl2";
    packages = with pkgs; [

    ];
  };

  programs.fish.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
  fastfetch
  git
  htop
  man
  nixd
  neovim
  #lynx
  wget
  yazi
  ];

  # // MAINTENANCE //

  # Garbage Collecting
   nix.gc = {
    automatic = true;
    dates = "weekly";
    options  = "--delete-older-than +5";
  };
  nix.settings.auto-optimise-store = true;

  # Next Maintenance Commands Here.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
