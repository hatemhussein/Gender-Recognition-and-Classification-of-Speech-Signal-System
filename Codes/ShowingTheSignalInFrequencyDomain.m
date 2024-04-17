function ShowingTheSignalInFrequencyDomain(button1, button2)
    % This function is for showing the signal of the recorded voice (for testing)
    % in the Frequency-Domain
    
    % Check if button1 is pressed (indicating that recording has been done)
    if (button1 == 1 && button2 == 3)
        testing_file = dir('D:\Matlab\bin\DSBProject\testingOneVoice\*.wav');
        
        % Check if there is at least one testing file
        if ~isempty(testing_file)
            file_path = fullfile(testing_file(1).folder, testing_file(1).name);
            [y, fs] = audioread(file_path);
            
            % Compute the Fourier transform of the signal
            N = length(y);
            Y = fft(y);
            f = linspace(0, fs, N);
            
            % Plot the magnitude spectrum
            fprintf('\n-------------------------------------------------\n');
            fprintf('The plot in Frequency Domain is shown\n');
            fprintf('\n-------------------------------------------------\n');
            figure;
            plot(f, abs(Y));
            title('Frequency Domain');
            xlabel('Frequency (Hz)');
            ylabel('Magnitude');
        else
            fprintf('!! ERROR: No testing files found. Please record a voice first !!\n');
        end
    else
        fprintf('!! ERROR: Please record a voice first !!\n');
    end
end

