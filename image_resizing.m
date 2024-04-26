% Define the input size of AlexNet
inputSize = [227, 227];

% Define the main folder containing subfolders
main_folder = 'C:\Users\singh\Major_Project\processing\stft_files'; % Replace 'path_to_main_folder' with the actual path to your main folder

% Get a list of subfolders
subfolders = dir(fullfile(main_folder, 'sub-*'));

% Iterate over each subfolder
for sub_idx = 1:numel(subfolders)
    subfolder = subfolders(sub_idx).name;
    subfolder_path = fullfile(main_folder, subfolder);
    
    % Get a list of STFT images in the current subfolder
    stft_files = dir(fullfile(subfolder_path, '*.png')); % assuming the STFT images are in PNG format
    num_images = numel(stft_files);
    
    % Create a cell array to store resized images for the current subfolder
    resized_images = cell(1, num_images);
    
    % Iterate over each STFT image in the current subfolder
    for i = 1:num_images
        % Read the STFT image
        stft_image = imread(fullfile(subfolder_path, stft_files(i).name));
        
        % Resize the image
        resized_image = imresize(stft_image, inputSize);
        
        % Convert to single precision and normalize pixel values
        resized_image = im2single(resized_image);
        
        % Store the resized image
        resized_images{i} = resized_image;
    end
    
    % Do something with resized_images (e.g., save them, process them further)
    % For example, you can save the resized images to a new folder
    output_folder = fullfile(main_folder, 'resized_images', subfolder);
    if ~exist(output_folder, 'dir')
        mkdir(output_folder);
    end
    for j = 1:num_images
        imwrite(resized_images{j}, fullfile(output_folder, sprintf('image_%d.png', j)));
    end
end
