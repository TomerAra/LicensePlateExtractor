close all; clear; clc;

sample_images_path = "C:\Users\Tomer Arama\Desktop\Projects\LicensePlateExtractor\sample_images";
sample_images = dir(sample_images_path);

Params = default_params();

for k = 3:length(sample_images)
    im_path = [sample_images(k).folder,'\',sample_images(k).name];
    im = imread(im_path);
    gray_im = rgb2gray(im);
    
    fprintf('\nProcessing image: %s...\n', im_path);
    
    % create a mask in one channel
    plate_mask_BW = DetectLicensePlate(im, Params);
    plate_mask_RGB = repmat(plate_mask_BW,[1 1 3]);
    
    [corners, status] = DetectPlateCorners(plate_mask_BW, Params);
    
    if(status)
        ref_image = CreateRefPlateImage(im,corners, plate_mask_RGB, Params);

        fig = figure();
        subplot(1,2,1);
        imshow(im,[]);
        title(['Sample Image: ', sample_images(k).name]);
        hold on;
        plot(corners);
        subplot(1,2,2);
        imshow(ref_image,[]);
        title('Ref 2D Image');
        impixelinfo;
        truesize(fig);
    else
        fprintf('Could not find a plate in %s.\n', im_path);
    end
end