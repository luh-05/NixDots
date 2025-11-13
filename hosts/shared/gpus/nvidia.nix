{ pkgs, config, lib, ...}:

{
  # Enable OpenGL
  #hardware.graphics.package = pkgs.mesa;

  # config nvidia GPU
  #boot.blacklistedKernelModules = [ "nvidia" "nvidia_uvm" ];
  
  #boot.kernelModules = [ "nouveau" ];
  #boot.kernelModules = [ "nvidia_uvm" "nvidia_modeset" "nvidia_drm" "nvidia" ];
  #boot.kernelParams = [
  #  #"nouveau.config=NvGspRm=1"
  #  #"nouveau.debug=info,VBIOS=info,gsp=debug"
  #  "nvidia-drm.fbdev=1"
  #];

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"]; # or "nvidiaLegacy470 etc.

  hardware.nvidia = {
    #package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Modesetting is required.
    modesetting.enable = true;

    powerManagement.enable = true;
    powerManagement.finegrained = true;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      sync.enable = false;
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:11:0:0";
    };

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    # package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
