% Assume data is your input data array

% Define the segment size
segment_size = 2048;

% Extract a segment of data
x = data(1:segment_size);

% Compute the STFT of the segment
[s, f, t] = stft(hilbert(x));

% Compute the magnitude of the STFT in decibels (dB)
s_dB = 20 * log10(abs(s));

% Plot the 3D STFT
surf(t, f, s_dB, 'EdgeColor', 'none');
shading interp; % Interpolated shading for smoother surface
colormap(jet); % Color map
title('3D STFT Plot');
xlabel('Time (s)');
ylabel('Frequency (Hz)');
zlabel('Magnitude (dB)');
