function [Config] = default_params()

Config = struct();

% parameters for DetectLicensePlate()
Config.DetectLicensePlate = struct();
Config.DetectLicensePlate.h_low_thresh = 0.1;
Config.DetectLicensePlate.h_high_thresh = 0.18;
Config.DetectLicensePlate.s_low_thresh = 0.35;
Config.DetectLicensePlate.v_low_thresh = 0.5;
Config.DetectLicensePlate.eccentricity_low_thresh = 0.8;
Config.DetectLicensePlate.eccentricity_high_thresh = 1;
Config.DetectLicensePlate.eulerNum_low_thresh = -50;
Config.DetectLicensePlate.eulerNum_high_thresh = 0;
Config.DetectLicensePlate.close_se_size = 7;
Config.DetectLicensePlate.dilate_se_size = 5;
Config.DetectLicensePlate.is_debug = false;
%Config.DetectLicensePlate.is_debug = true;

% parameters for DetectPlateCorners()
Config.DetectPlateCorners = struct();
Config.DetectPlateCorners.harris_filter_size = 21;
Config.DetectPlateCorners.is_debug = false;

% parameters for LocatPlat()
Config.LocatPlat = struct();
Config.LocatPlat.NumColor = 15;
Config.LocatPlat.is_debug = true;

end

