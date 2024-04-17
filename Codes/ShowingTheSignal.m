function ShowingTheSignal(button1, button2)
    % This function is for showing the signal of the recorded voice (for testing)
    % in the Time-Domain and Frequency-Domain
    
    % Check if button1 is pressed (indicating that recording has been done)
    if (button1 == 1 && button2 == 2)
        testing_file = dir('D:\Matlab\bin\DSBProject\testingOneVoice\*.wav');
        
        % Check if there is at least one testing file
        if ~isempty(testing_file)
            file_path = fullfile(testing_file(1).folder, testing_file(1).name);
            [y, fs] = audioread(file_path);
            
            % Plot the signal in the Time Domain
            fprintf('\n-------------------------------------------------\n');
            fprintf('\nThe plot in Time Domain is shown\n');
            fprintf('\n-------------------------------------------------\n');
            figure;
            plot(y);
            title('Time Domain');
            xlabel('Time (s)');
            ylabel('Magnitude');
        else
            fprintf('!! ERROR: No testing files found. Please record a voice first !!\n');
        end
    else
        fprintf('!! ERROR: Please record a voice first !!\n');
    end
end
