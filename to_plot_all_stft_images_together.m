% Define the segment size
segment_size = 2048;

% Define the starting and ending index of the subjects
start_index = 78;
end_index = 88;

% Iterate over each subject
for subj = start_index:end_index
    % Load the .mat file containing the EEG data for the current subject
    file_name = ['sub-0' num2str(subj) '_task-eyesclosed_eeg.mat'];  % Adjust the file naming convention as needed
    loaded_data = load(file_name);

    % Get the EEG data for the current subject from the 'data' field within the 'EEG' structure
    channel_data = loaded_data.EEG.data(4, :);

    % Calculate the number of segments
    num_segments = floor(length(channel_data) / segment_size);

    % Create a directory to save the images for the current subject
    save_dir = ['sub-0' num2str(subj)];
    mkdir(save_dir);

    % Iterate over each segment for the current subject
    for i = 1:num_segments
        % Get the start and end indices of the current segment
        start_idx = (i - 1) * segment_size + 1;
        end_idx = i * segment_size;

        % Extract the current segment
        segment = channel_data(start_idx:end_idx);

        % Compute the STFT of the segment
        [s, f, t] = stft(hilbert(segment));

        % Compute the magnitude of the STFT in dB
        s_dB = 20 * log10(abs(s)); 

        % Normalize the frequency axis to range from -1 to 1
        normalized_f = linspace(-1, 1, length(f));

        % Plot the magnitude of the STFT in dB as an image
        figure;
        imagesc(t, normalized_f, s_dB);
        colorbar;
        title(['Subject ' num2str(subj) ' - Hilbert STFT Magnitude (dB) - Segment ' num2str(i)]);
        xlabel('Samples');
        ylabel('Normalized Frequency');
        axis xy;

        % Set color axis to range from 0 to 80 dB
        caxis([0 80]);

        % Save the image
        saveas(gcf, fullfile(save_dir, ['hilbert_stft_segment_' num2str(i) '_dB.png']));
        close(gcf); % Close the figure to prevent accumulation of figures in memory
    end
end