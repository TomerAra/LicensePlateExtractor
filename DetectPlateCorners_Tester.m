close all; clear; clc;

sample_images_path = "C:\Users\Tomer Arama\Desktop\Projects\LicensePlateExtractor\sample_images";
sample_images = dir(sample_images_path);

Params = default_params();

for k = 3:length(sample_images)
    im_path = [sample_images(k).folder,'\',sample_images(k).name];
    im = imread(im_path);
    
    plate_mask_BW = DetectLicensePlate(im, Params);

    corners = DetectPlateCorners(plate_mask_BW, Params);
    
    figure();
    imshow(im,[]);
    title(['Sample Image: ', sample_images(k).name]);
    hold on;
    plot(corners);
end