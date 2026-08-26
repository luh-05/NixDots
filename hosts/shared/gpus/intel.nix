{ pkgs, config, lib, ...}:

{
  boot.kernelParams = [ "i915.enable_guc=2" ];

  # Load intel driver for Xorg and Wayland
  services.xserver.videoDrivers = ["modesetting"];
  # services.xserver.videoDrivers = ["modesetting" "fbdev"];

  hardware.intel-gpu-tools.enable = true;

  hardware.graphics = {
    enable = true;

    enable32Bit = true;

    extraPackages = with pkgs; [
      intel-vaapi-driver
      # mesa
      intel-media-driver
      libvdpau-va-gl
      # vulkan-loader
      # vulkan-validation-layers

      # Only for Xe/ARC
      # intel-media-driver # VA-API userspace (iHD)
      # vpl-gpu-rt # oneVPL runtime (QSV)
      # intel-compute-runtime # OpenCL (NEO) + Level Zero
    ]; 

    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
      intel-vaapi-driver
      intel-gpu-tools
      # mesa
      # vulkan-loader
      # vulkan-validation-layers
    ];
  };
}
