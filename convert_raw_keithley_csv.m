function [trace] = convert_raw_keithley_csv(filename, file_format, sample_rate)
% Authors: Mark Gottscho and Salma Elmalaki
% mgottscho@ucla.edu
%
% Arguments:
%   filename -- String: path to CSV file with the data.
%   file_format -- Scalar: 1 or 2
%   sample_rate -- Scalar: sample rate in Hz if using file format 2
%
% CSV file format 1:
%   Row 1: timestamp in seconds
%   Row 2: current in A
%   Row 1: timestamp in seconds
%   Row 3: voltage in V
%
% CSV file format 2
%   Row 1: current in A
%   Row 2: voltage in V
%
% Returns:
%   trace -- Sx3 Matrix: Rows are S samples. Column 1: timestamp in seconds
%       Column 2: voltage in V
%       Column 3: current in A

% Error check
if file_format ~= 1 && file_format ~= 2
    display('file_format must be 1 or 2');
    trace = NaN(1,3); % junk return
    return; 
end

% Load the raw data
raw_data = csvread(filename);
raw_data_size = size(raw_data);
S = raw_data_size(2);

trace = NaN(S,3);

if file_format == 1
    %trace(:,1) = raw_data(1,:)'; % Timestamp
    trace(:,1) = [1:S]' .* 1/sample_rate; % Timestamp
    trace(:,2) = raw_data(4,:)'; % V
    trace(:,3) = raw_data(2,:)'; % I
else
    trace(:,1) = [1:S]' .* 1/sample_rate; % Timestamp
    trace(:,2) = raw_data(2,:)'; % V
    trace(:,3) = raw_data(1,:)'; % I
end

end