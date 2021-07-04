close all; clear; clc;

sample_images_path = "C:\Users\Tomer Arama\Desktop\Projects\LicensePlateExtractor\sample_images";
sample_images = dir(sample_images_path);

Params = default_params();

results = {};

print_en = true;

for k = 3:length(sample_images)
    im_path = [sample_images(k).folder,'\',sample_images(k).name];
    im = imread(im_path);
    
    fprintf('\nProcessing image: %s...\n', im_path);
    
    % create a mask in one channel
    plate_mask_BW = DetectLicensePlate(im, Params);
    plate_mask_RGB = repmat(plate_mask_BW,[1 1 3]);
    
    [corners, status] = DetectPlateCorners(plate_mask_BW, Params);
    
    if(status)
        ref_image = CreateRefPlateImage(im,corners, plate_mask_RGB, Params);

        if(print_en)
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
        end      
    else
        fprintf('Could not find a plate in %s.\n', im_path);
        tmp_res = ['Could not find a plate in image ' sample_images(k).name];
    end
end

