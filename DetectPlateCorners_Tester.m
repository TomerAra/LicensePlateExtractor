close all; clear; clc;

sample_images_path = "C:\Users\Tomer Arama\Desktop\Projects\LicensePlateExtractor\sample_images";
sample_images = dir(sample_images_path);

Params = default_params();

for k = 3:length(sample_images)
    im_path = [sample_images(k).folder,'\',sample_images(k).name];
    im = imread(im_path);
    
    % create a mask in one channel
    plate_mask_BW = DetectLicensePlate(im, Params);

    corners = DetectPlateCorners(plate_mask_BW, Params);
    
    % duplicate the mask to fit to three channels (fit to RGB image)
    plate_mask_RGB = repmat(plate_mask_BW,[1 1 3]);
    result = im.*plate_mask_RGB;

    fig = figure();
    subplot(1,3,1);
    imshow(im,[]);
    title(['Sample Image: ', sample_images(k).name]);
    hold on;
    plot(corners);
    subplot(1,3,2);
    imshow(plate_mask_BW,[]);
    title('Plate Mask');
    subplot(1,3,3);
    imshow(result,[]);
    title('License Plate');
    truesize(fig);
    
end