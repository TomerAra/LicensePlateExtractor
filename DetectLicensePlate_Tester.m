close all; clear; clc;

sample_images_path = "C:\Users\Tomer Arama\Desktop\Projects\LicensePlateExtractor\sample_images";
sample_images = dir(sample_images_path);

Params = default_params();

for k = 3:length(sample_images)
    %%%%%
    if(Params.DetectLicensePlate.is_debug)
        %im_path = [sample_images(k).folder,'\','plate05.jpg'];
        im_path = [sample_images(k).folder,'\','plate09.jpg'];
    else
        sample_images(k).name
        im_path = [sample_images(k).folder,'\',sample_images(k).name];
    end
    %%%%%
    
    im = imread(im_path);
    
    plate_mask_BW = DetectLicensePlate(im, Params);

    plate_mask_RGB = repmat(plate_mask_BW,[1 1 3]);
    result = im.*plate_mask_RGB;

    fig = figure();
    subplot(1,3,1);
    imshow(im,[]);
    title('Sample Image');
    subplot(1,3,2);
    imshow(plate_mask_BW,[]);
    title('Plate Mask');
    subplot(1,3,3);
    imshow(result,[]);
    title('License Plate');
    truesize(fig);
end
