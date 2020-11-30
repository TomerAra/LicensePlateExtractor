close all; clear; clc;

sample_images_path = "C:\Users\Tomer Arama\Desktop\Projects\LicensePlateExtractor\sample_images";
sample_images = dir(sample_images_path);

Params = default_params();
             
for k = 3:length(sample_images)
    %%%%%
    if(Params.LocatPlat.is_debug)
        %im_path = [sample_images(k).folder,'\','plate05.jpg'];
        im_path = [sample_images(k).folder,'\','plate04.jpg'];
    else
        sample_images(k).name
        im_path = [sample_images(k).folder,'\',sample_images(k).name];
    end
    %%%%%
    
    im = imread(im_path);
    
    %%%%%
    if(Params.LocatPlat.is_debug)
        figure();
        imshow(im,[]);
        title('original image');
        impixelinfo;
    end
    %%%%%
    
    RgbPlat = LocatPlat(im, Params);
    
    fig = figure();
    subplot(1,2,1);
    imshow(im,[]);
    title('Sample Image');
    subplot(1,2,2);
    imshow(RgbPlat,[]);
    title('Rgb Plate');
    truesize(fig);
    
    %%%%%
    if(Params.LocatPlat.is_debug)
        break;
    end
    %%%%%

end