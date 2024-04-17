training_files_male = dir('D:\Matlab\bin\DSBProject\training\male\*.wav');
testing_files_male = dir('D:\Matlab\bin\DSBProject\testing\male\*.wav');
training_files_female = dir('D:\Matlab\bin\DSBProject\training\female\*.wav');
testing_files_female = dir('D:\Matlab\bin\DSBProject\testing\female\*.wav');

% ________________ READING THE TRAINING FILE FOR MALE ________________
data_male = [];%for the ZCR
CORR_male_matrix = [];%for the CORRELATION
ENERGY_male_matrix = [];%for the ENERGY
ZCR_ENERGY_male_matrix = [];%combining the ZCR with ENERGY to make it more accurate
PSD_male_matrix = [];%for the PSD
for i = 1:length(training_files_male)
file_path = strcat(training_files_male(i).folder,'\',training_files_male(i).name);
[y,fs] = audioread(file_path);
%divide the signal into 3 parts and calculate the ZERO CROSSING COUNT for each part
ZCR_male1 = sum(abs(diff(sign(y(1:floor(end/3))))))./2;
ZCR_male2 = sum(abs(diff(sign(y(floor(end/3):floor (end*2/3))))))./2;
ZCR_male3 = sum(abs(diff(sign(y(floor(end*2/3):end)))))./2;

%divide the signal into 3 parts and calculate the AUTO-CORRELATION for each part
% Divide the signal into 3 parts
part1 = y(1:floor(end/3));
part2 = y(floor(end/3) : floor(end*2/3));
part3 = y(floor(end*2/3) : end);

% Calculate auto-correlation for each part using only positive lags
CORR_male1 = xcorr(part1, 'coeff');  % 'coeff' normalizes the values
CORR_male2 = xcorr(part2, 'coeff');
CORR_male3 = xcorr(part3, 'coeff');

% Extract only positive lags
positive_lags = 0:length(CORR_male1)-1;
CORR_male1 = CORR_male1(positive_lags+1);
CORR_male2 = CORR_male2(positive_lags+1);
CORR_male3 = CORR_male3(positive_lags+1);

% Concatenate the auto-correlation values for each part
CORR_male = [CORR_male1 CORR_male2 CORR_male3];
CORR_male_matrix = [CORR_male_matrix ;CORR_male];

%calculate the energy
energy = sum(y.^2);
ENERGY_male_matrix = [energy];

%calculate the ZCR
ZCR_male = [ZCR_male1 ZCR_male2 ZCR_male3];
data_male = [data_male ;ZCR_male];

%combining energy with ZCR
ZCR_ENERGY_male = [ZCR_male1 ZCR_male2 ZCR_male3 energy];
ZCR_ENERGY_male_matrix = [ZCR_ENERGY_male_matrix ;ZCR_ENERGY_male];

%calculating PSD
%[psd, freq] = pwelch(y, hamming(256), 128, 1024, fs);
%PSD_male_matrix = [PSD_male_matrix; psd];
%disp(length(y))
%[psd, freq] = periodogram(y, rectwin(length(y)), length(y), fs);
%disp(psd);
%total_power = trapz(freq, psd);
[psd, freq] = pwelch(y, [], [], [], fs);
%total_power = trapz(freq, psd);
%PSD_male_matrix = [PSD_male_matrix; total_power];
% Check if any element of psd is non-zero
if any(psd)
    total_power = trapz(freq, psd);
    PSD_male_matrix = [PSD_male_matrix; total_power];
else
    disp('Error: PSD vector is all zeros.');
end
end

ZCR_male=mean(data_male);
CORR_male = mean(CORR_male_matrix,1);
energy = mean(ENERGY_male_matrix);
ZCR_ENERGY_male = mean(ZCR_ENERGY_male_matrix);
psd = mean(PSD_male_matrix);
fprintf('\n*******************************************************************************\n');
fprintf('\n\t\tTHE RESULTS OF TRAINING MALES FILES\t\t\n');
fprintf('\n*******************************************************************************\n');
fprintf('The ZCR of male is:\t');
fprintf('%.4f\t', ZCR_male);
fprintf('\nThe CORRELATION of male is:\t');
fprintf('%.4f\t', CORR_male);
fprintf('\nThe ENERGY of male is:\t');
fprintf('%.4f\t', energy);
format long  % Display more decimal places
fprintf('\nThe PSD of male is:\t');
disp(psd);
format short  % Reset the display format to the default

% ________________ READING THE TRAINING FILE FOR FEMALE ________________
data_female = [];%for the ZCR
CORR_female_matrix = [];%for the CORRELATION
ENERGY_female_matrix = [];%for the ENERGY
ZCR_ENERGY_female_matrix = [];%combining the ZCR with ENERGY to make it more accurate
PSD_female_matrix = [];%for the PSD
for i = 1:length(training_files_female)
file_path = strcat(training_files_female(i).folder,'\',training_files_female(i).name);
[y,fs] = audioread(file_path);
%divide the signal into 3 parts and calculate the ZERO CROSSING COUNT for each part
ZCR_female1 = sum(abs(diff(sign(y(1:floor(end/3))))))./2;
ZCR_female2 = sum(abs(diff(sign(y(floor(end/3):floor (end*2/3))))))./2;
ZCR_female3 = sum(abs(diff(sign(y(floor(end*2/3):end)))))./2;

%divide the signal into 3 parts and calculate the AUTO-CORRELATION for each part
% Divide the signal into 3 parts
part1 = y(1:floor(end/3));
part2 = y(floor(end/3) : floor(end*2/3));
part3 = y(floor(end*2/3) : end);

% Calculate auto-correlation for each part using only positive lags
CORR_female1 = xcorr(part1, 'coeff');  % 'coeff' normalizes the values
CORR_female2 = xcorr(part2, 'coeff');
CORR_female3 = xcorr(part3, 'coeff');

% Extract only positive lags
positive_lags = 0:length(CORR_female1)-1;
CORR_female1 = CORR_female1(positive_lags+1);
CORR_female2 = CORR_female2(positive_lags+1);
CORR_female3 = CORR_female3(positive_lags+1);

% Concatenate the auto-correlation values for each part
CORR_female = [CORR_female1 CORR_female2 CORR_female3];
CORR_female_matrix = [CORR_female_matrix ;CORR_female];

%calculate the energy
energy_female = sum(y.^2);
ENERGY_female_matrix = [energy_female];

%calculating ZCR
ZCR_female = [ZCR_female1 ZCR_female2 ZCR_female3];
data_female = [data_female ;ZCR_female];

%combining ZCR with energy
ZCR_ENERGY_female = [ZCR_female1 ZCR_female2 ZCR_female3 energy];
ZCR_ENERGY_female_matrix = [ZCR_ENERGY_female_matrix ;ZCR_ENERGY_female];
%calculating PSD
[psd_female, freq] = pwelch(y, [], [], [], fs);
if any(psd_female)
    total_power = trapz(freq, psd_female);
    PSD_female_matrix = [PSD_female_matrix; total_power];
else
    disp('Error: PSD vector is all zeros.');
end
end

ZCR_female=mean(data_female);
CORR_female = mean(CORR_female_matrix,1);
energy_female = mean(ENERGY_female_matrix);
ZCR_ENERGY_female = mean (ZCR_ENERGY_female_matrix);
psd_female = mean(PSD_female_matrix);
fprintf('\n*******************************************************************************\n');
fprintf('\n\t\tTHE RESULTS OF TRAINING FEMALES FILES\t\t\n');
fprintf('\n*******************************************************************************\n');
fprintf('The ZCR of female is:\t');
fprintf('%.4f\t', ZCR_female);
fprintf('\nThe CORRELATION of female is:\t');
fprintf('%.4f\t', CORR_female);
fprintf('\nThe ENERGY of female is:\t');
fprintf('%.4f\t', energy_female);
format long  % Display more decimal places
fprintf('\nThe PSD of female is:\t');
disp(psd_female);
format short  


fprintf('\n*******************************************************************************\n');
fprintf('\n\t\tNOW LETS SEE TESTING RESULTS FOR MALES\t\t\n');
fprintf('\n*******************************************************************************\n');


% ________________ READING THE TESTING FILE FOR MALE ________________
CORR_male_matrix_testing = [];
ZCR_male_testing = [];
ENERGY_male_testing = [];
ZCR_ENERGY_male_testing = [];
PSD_male_testing = [];
window_size = 1;  
correct_male = 0;
incorrect_male = 0;

for i = 1:length(testing_files_male)
file_path = strcat(testing_files_male(i).folder,'\',testing_files_male(i).name);
[y,fs] = audioread(file_path);

%divide the signal into 3 parts and calculate the ZERO CROSSING COUNT for each part
ZCR_male1 = sum(abs(diff(sign(y(1:floor(end/3))))))./2;
ZCR_male2 = sum(abs(diff(sign(y(floor(end/3):floor (end*2/3))))))./2;
ZCR_male3 = sum(abs(diff(sign(y(floor(end*2/3):end)))))./2;

%divide the signal into 3 parts and calculate the AUTO-CORRELATION for each part
% Divide the signal into 3 parts
part1 = y(1:floor(end/3));
part2 = y(floor(end/3) : floor(end*2/3));
part3 = y(floor(end*2/3) : end);

% Calculate auto-correlation for each part using only positive lags
CORR_male1 = xcorr(part1, 'coeff');  % 'coeff' normalizes the values
CORR_male2 = xcorr(part2, 'coeff');
CORR_male3 = xcorr(part3, 'coeff');

% Extract only positive lags
positive_lags = 0:length(CORR_male1)-1;
CORR_male1 = CORR_male1(positive_lags+1);
CORR_male2 = CORR_male2(positive_lags+1);
CORR_male3 = CORR_male3(positive_lags+1);

%calculating CORR
CORR_male_testing = [CORR_male1 CORR_male2 CORR_male3];
%calculate the energy
energy_male_testing = sum(y.^2);
%calculating ZCR
ZCR_male_testing = [ZCR_male1 ZCR_male2 ZCR_male3];
%combining ZCR with ENERGY
ZCR_ENERGY_male_testing = [ZCR_male1 ZCR_male2 ZCR_male3 energy_male_testing];
%calculating PSD
[psd_male_testing, freq] = pwelch(y, [], [], [], fs);
fprintf('\n_______________________________________________________________________\n');
% COMPARISON BASED ON MULYIPLE MATRICES
  %BASED ON ZCR (ZERO CROSSING COUNT)
    %make the decision based on cosine distance
    if(pdist([ZCR_male_testing;ZCR_male],'cityblock') < pdist([ZCR_male_testing;ZCR_female],'cityblock'))
        fprintf('Test file [male] #%d classified as male based on ZCR\n',i);
        correct_male = correct_male + 1;
    else
        fprintf('Test file [male] #%d classified as female based on ZCR\n',i);
        incorrect_male = incorrect_male + 1;
    end
  %BASED ON CORR (CORRELATION)
 % Initialize start index for sliding window
    start_idx = 1;

    while start_idx <= 1
        end_idx = min(start_idx + window_size - 1, length(CORR_male_testing));

        % Extract the current window
        current_window_testing = CORR_male_testing(start_idx:end_idx, :);
        current_window_male = CORR_male(start_idx:min(end_idx, size(CORR_male, 1)), :);
        current_window_female = CORR_female(start_idx:min(end_idx, size(CORR_female, 1)), :);

        % Compute distances for the current window
        dist_male = pdist([current_window_testing; current_window_male], 'cosine');
        dist_female = pdist([current_window_testing; current_window_female], 'cosine');

        % Make decisions based on distances for the current window
        if dist_male < dist_female
            fprintf('Test file [male] #%d classified as male based on CORR\n', i);
            correct_male = correct_male + 1;
        else
            fprintf('Test file [male] #%d classified as female based on CORR\n', i);
            incorrect_male = incorrect_male + 1;
        end

        start_idx = end_idx + 1;
    end
    %BASED ON ENERGY
    %make the decision based on cosine distance
    if(pdist([energy_male_testing;energy],'cityblock') < pdist([energy_male_testing;energy_female],'cityblock'))
        fprintf('Test file [male] #%d classified as male based on ENERGY\n',i);
        correct_male = correct_male + 1;
    else
        fprintf('Test file [male] #%d classified as female based on ENERGY\n',i);
        incorrect_male = incorrect_male + 1;
    end
    %BASED ON ZCR WITH ENERGY
    %make the decision based on cosine distance
    if(pdist([ZCR_ENERGY_male_testing;ZCR_ENERGY_male],'cosine') < pdist([ZCR_ENERGY_male_testing;ZCR_ENERGY_female],'cosine'))
        fprintf('Test file [male] #%d classified as male based on ZCR with ENERGY\n',i);
        correct_male = correct_male + 1;
    else
        fprintf('Test file [male] #%d classified as female based on ZCR with ENERGY\n',i);
        incorrect_male = incorrect_male + 1;
    end
    %BASED ON PSD
    %make the decision based on cosine distance
    if(pdist([psd_male_testing;psd],'cityblock') < pdist([psd_male_testing;psd_female],'cityblock'))
        fprintf('Test file [male] #%d classified as male based on PSD\n',i);
        correct_male = correct_male + 1;
    else
        fprintf('Test file [male] #%d classified as female based on PSD\n',i);
        incorrect_male = incorrect_male + 1;
    end
end
% Calculate accuracy for males
accuracy_male = correct_male / (correct_male + incorrect_male) * 100;
%fprintf('Accuracy for male testing files: %.2f%%\n', accuracy_male);
printAccuracy(accuracy_male, 'male');

fprintf('\n\n*******************************************************************************\n');
fprintf('\n\t\tNOW LETS SEE TESTING RESULTS FOR FEMALES\t\t\n');
fprintf('\n*******************************************************************************\n');
% ________________ READING THE TESTING FILE FOR FEMALE ________________
CORR_female_matrix_testing = [];
ZCR_ENERGY_female_testing = [];
window_size = 5;
correct_female = 0;
incorrect_female = 0;
for i = 1:length(testing_files_female)
    file_path = strcat(testing_files_female(i).folder,'\',testing_files_female(i).name);
    [y,fs] = audioread(file_path);

    %divide the signal into 3 parts and calculate the ZERO CROSSING COUNT for each part
    ZCR_female1 = sum(abs(diff(sign(y(1:floor(end/3))))))./2;
    ZCR_female2 = sum(abs(diff(sign(y(floor(end/3):floor (end*2/3))))))./2;
    ZCR_female3 = sum(abs(diff(sign(y(floor(end*2/3):end)))))./2;

    %divide the signal into 3 parts and calculate the AUTO-CORRELATION for each part
    % Divide the signal into 3 parts
    part1 = y(1:floor(end/3));
    part2 = y(floor(end/3) : floor(end*2/3));
    part3 = y(floor(end*2/3) : end);

    % Calculate auto-correlation for each part using only positive lags
    CORR_female1 = xcorr(part1, 'coeff');  % 'coeff' normalizes the values
    CORR_female2 = xcorr(part2, 'coeff');
    CORR_female3 = xcorr(part3, 'coeff');

    % Extract only positive lags
    positive_lags = 0:length(CORR_female1)-1;
    CORR_female1 = CORR_female1(positive_lags+1);
    CORR_female2 = CORR_female2(positive_lags+1);
    CORR_female3 = CORR_female3(positive_lags+1);

    % Concatenate the auto-correlation values for each part
    CORR_female_testing = [CORR_female1 CORR_female2 CORR_female3];
    %calculate the energy
    energy_female_testing = sum(y.^2);
    %calculating ZCR
    ZCR_female_testing = [ZCR_female1 ZCR_female2 ZCR_female3];
    %combining ZCR with ENERGY
    ZCR_ENERGY_female_testing = [ZCR_female1 ZCR_female2 ZCR_female3 energy_female_testing];
    %calculating PSD
    [psd_female_testing, freq] = pwelch(y, [], [], [], fs);

    %make the decision based on cosine distance
    %fprintf('\n\nThe CORR,\t\tZCR,\t\tENERGY,\t\t and PSD of the female testing file #%d is \n',i);
    %fprintf('%.4f\t\t%.4f\t\t%.4f\t\t%.4f\t\t', CORR_female_testing,ZCR_female_testing,energy_female_testing,  psd_female_testing);
    fprintf('\n_______________________________________________________________________\n');
    if(pdist([ZCR_female_testing;ZCR_male],'cityblock') < pdist([ZCR_female_testing;ZCR_female],'cityblock'))
        fprintf('Test file [female] #%d classified as male based on ZCR\n',i);
        incorrect_female = incorrect_female + 1;
    else
        fprintf('Test file [female] #%d classified as female based on ZCR\n',i);
        correct_female = correct_female + 1;
    end
      %BASED ON CORR (CORRELATION)
     % Initialize start index for sliding window
    start_idx = 1;

    while start_idx <= 1
        end_idx = min(start_idx + window_size - 1, length(CORR_female_testing));

        % Extract the current window
        current_window_testing = CORR_female_testing(start_idx:end_idx, :);
        current_window_male = CORR_male(start_idx:min(end_idx, size(CORR_male, 1)), :);
        current_window_female = CORR_female(start_idx:min(end_idx, size(CORR_female, 1)), :);

        % Compute distances for the current window
        dist_male = pdist([current_window_testing; current_window_male], 'cosine');
        dist_female = pdist([current_window_testing; current_window_female], 'cosine');

        % Make decisions based on distances for the current window
        if dist_male < dist_female
            fprintf('Test file [female] #%d classified as male based on CORR\n', i);
            incorrect_female = incorrect_female + 1;
        else
            fprintf('Test file [female] #%d classified as female based on CORR\n', i);
            correct_female = correct_female + 1;
        end

        start_idx = end_idx + 1;
    end
    %BASED ON ENERGY
    %make the decision based on cosine distance
    if(pdist([energy_female_testing;energy],'cityblock') < pdist([energy_female_testing;energy_female],'cityblock'))
        fprintf('Test file [female] #%d classified as male based on ENERGY\n',i);
        incorrect_female = incorrect_female + 1;
    else
        fprintf('Test file [female] #%d classified as female based on ENERGY\n',i);
        correct_female = correct_female + 1;
    end
    %BASED ON ZCR WITH ENERGY
    %make the decision based on cosine distance
    if(pdist([ZCR_ENERGY_female_testing;ZCR_ENERGY_male],'cosine') < pdist([ZCR_ENERGY_female_testing;ZCR_ENERGY_female],'cosine'))
        fprintf('Test file [female] #%d classified as male based on ZCR with ENERGY\n',i);
        incorrect_female = incorrect_female + 1;
    else
        fprintf('Test file [female] #%d classified as female based on ZCR with ENERGY\n',i);
        correct_female = correct_female + 1;
    end
    %BASED ON PSD
    %make the decision based on cosine distance
    if(pdist([psd_female_testing;psd],'cosine') < pdist([psd_female_testing;psd_female],'cosine'))
        fprintf('Test file [female] #%d classified as male based on PSD\n',i);
        incorrect_female = incorrect_female + 1;
    else
        fprintf('Test file [female] #%d classified as female based on PSD\n',i);
        correct_female = correct_female + 1;
    end
end
% Calculate accuracy for females
accuracy_female = correct_female / (correct_female + incorrect_female) * 100;
%fprintf('Accuracy for female testing files: %.2f%%\n', accuracy_female);
printAccuracy(accuracy_female, 'female');


function printAccuracy(accuracy, gender)
    fprintf('\n###############################################################################\n');
    fprintf('\n\t\tTHE ACCURACY OF TESTING %s FILES\t\t\n', upper(gender));

    %fprintf('Accuracy for %s testing files: %.2f%%\n', gender, accuracy);

    % Display a progress bar
    progressBarLength = 20;
    progress = round(accuracy / 100 * progressBarLength);
    remaining = progressBarLength - progress;

    fprintf('[');
    fprintf(repmat('=', 1, progress));
    fprintf('>');
    fprintf(repmat(' ', 1, remaining - 1));
    fprintf('] %.2f%%\n', accuracy);
    fprintf('\n###############################################################################\n');
end