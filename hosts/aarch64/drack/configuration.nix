{ config, pkgs, lib, ... }:

{
  imports =
    [
        ./hardware-configuration.nix
    ];

  boot.kernelParams = [ 
    "console=tty0" 
    "clk_ignore_unused"
    "pd_ignore_unused"
    "arm64.nopauth"
  ];

  boot.kernelModules = [
    # Core
    "qnoc-sc8280xp"

    # NVME
    "phy_qcom_qmp_pcie"
    "pcie_qcom"
    "nvme"

    # Keyboard
    "i2c_qcom_geni"
    "i2c_hid_of"
    "hid_generic"

    # Display
    "pwm_bl"
    "qrtr"
    "phy_qcom_edp"
    "i2c_qcom_geni"
    "gpio_sbu_mux"
    "pmic_glink_altmode"
    "spmi_pmic_arb"
    "phy_qcom_qmp_combo"
    "qcom_spmi_pmic"
    "pinctrl_spmi_gpio"
    "leds_qcom_lpg"
    "panel_edp"
    "msm"

    # USB (required for installation from USB)
    "qcom_q6v5_pas"  # This module loads a lot of FW blobs
    "usb_storage"
    "uas"
    ];

  networking.hostName = "drack";

  services.udev.extraRules = ''
    # Enable touchscreen on X13s
    ACTION=="add", SUBSYSTEM=="drivers", KERNEL=="i2c_hid_of", ATTR{bind}="4-0010"
    # Set wifi MAC on X13s
    SUBSYSTEM=="net", ACTION=="add", ATTRS{vendor}=="0x17cb", ATTRS{device}=="0x1103", PROGRAM="/usr/share/ubuntu-x13s-settings/set-wifi-mac-addr %k"
  '';

}
