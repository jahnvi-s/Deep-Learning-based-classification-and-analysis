% Load the set file
setFileName = 'C:\Users\singh\Major_Project\set_\set_files\sub-026_task-eyesclosed_eeg.set';
EEG = pop_loadset(setFileName);

% Save the data to a mat file
matFileName = 'sub-026_task-eyesclosed_eeg.mat';
save(matFileName, 'EEG');
