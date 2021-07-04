function [plate_number_str, status] = ExtractLicensePlate(im_RGB, print_en)
% a function that takes rgb image, and if there is a license plate in the image it
% returns its plate number as a string and the status will be true, if not - the status will be false
% input:
% im_RGB - rgb image
% print_en - if true, the function will show the image and its license plate
% output:
% plate_number_str - the plate number as a string (if found)
% status - true if a plate was found, false otherwise

    % get default params
    Params = default_params();
    
    % create a mask in one channel
    plate_mask_BW = DetectLicensePlate(im_RGB, Params);
    plate_mask_RGB = repmat(plate_mask_BW,[1 1 3]);
    
    [corners, status] = DetectPlateCorners(plate_mask_BW, Params);
    
    if(status)
        ref_image = CreateRefPlateImage(im_RGB, corners, plate_mask_RGB, Params);
        
        ocrResults = ocr(ref_image, 'CharacterSet', Params.CreateRefPlateImage.valid_characters);
        plate_number_str = ocrResults.Text; 
        
        if(print_en)
            fig = figure();
            subplot(1,2,1);
            imshow(im_RGB,[]);
            %title(['Sample Image: ', sample_images(k).name]);
            hold on;
            plot(corners);
            subplot(1,2,2);
            imshow(ref_image,[]);
            title('Ref 2D Image');
            impixelinfo;
            truesize(fig);
            sgtitle(['License plate number: ' plate_number_str]);
        end
        
    else
        plate_number_str = 'NO LICENSE PLATE WAS FOUND!';
    end
end

