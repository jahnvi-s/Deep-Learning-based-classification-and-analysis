% Define the starting and ending index of the subjects
start_index = 2;
end_index = 2;

% Iterate over each subject
for subj = start_index:end_index
    % Load the .mat file containing the EEG data for the current subject
    file_name = ['sub-00' num2str(subj) '_task-eyesclosed_eeg.mat'];  % Adjust the file naming convention as needed
    loaded_data = load(file_name);

    % Get the EEG data for the current subject from the 'data' field within the 'EEG' structure
    channel_data = loaded_data(4, :);

    % Plot the EEG data for the current subject
    figure;
    plot(channel_data);
    title(['Subject ' num2str(subj) ' - EEG Data - Row 4']);
    xlabel('Samples');
    ylabel('Amplitude');
    
    % Save the plot as an image
    save_dir = 'EEG_plots';
    if ~exist(save_dir, 'dir')
        mkdir(save_dir);
    end
    saveas(gcf, fullfile(save_dir, ['subject_' num2str(subj) '_EEG_Row_4.png']));
    close(gcf); % Close the figure to prevent accumulation of figures in memory
end
