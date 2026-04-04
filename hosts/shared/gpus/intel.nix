{ pkgs, config, lib, ...}:

{
  # Load intel driver for Xorg and Wayland
  services.xserver.videoDrivers = ["modesetting"];

  hardware.graphics = {
    enable = true;
    extraPackages = {
      # Only for Xe/ARC
      intel-media-driver # VA-API userspace (iHD)
      vpl-gpu-rt # oneVPL runtime (QSV)
      intel-compute-runtime # OpenCL (NEO) + Level Zero
    }; 
  };
}
