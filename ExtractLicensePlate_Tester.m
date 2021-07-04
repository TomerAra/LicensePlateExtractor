close all; clear; clc;

sample_images_path = "C:\Users\Tomer Arama\Desktop\Projects\LicensePlateExtractor\sample_images";
sample_images = dir(sample_images_path);

Params = default_params();

results = {};

print_en = true;

for k = 3:length(sample_images)
    im_path = [sample_images(k).folder,'\',sample_images(k).name];
    im = imread(im_path);
    
    [plate_number_str, status] = ExtractLicensePlate(im, print_en);
    
    if(status)
        tmp_res = ['Image ' sample_images(k).name ' plate number is: ' plate_number_str];
    else
        fprintf('Could not find a plate in %s.\n', im_path);
        tmp_res = ['Could not find a plate in image ' sample_images(k).name];
    end
    
    results{k-2} = tmp_res;
end

for i = 1:(length(sample_images)-2)
    results{i}
end