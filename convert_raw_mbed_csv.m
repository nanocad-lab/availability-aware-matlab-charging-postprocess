function [supply_trace, battery_trace, load_trace, battery_soc_trace] = convert_raw_mbed_csv(filename)
% Authors: Mark Gottscho and Salma Elmalaki
% mgottscho@ucla.edu
%
% Arguments:
%   filename -- String: path to CSV file with the data.
%
% CSV file format:
%   Column 1: timestamp in seconds
%   Column 2: power supply voltage in V
%   Column 3: power supply current in A
%   Column 4: power supply power in W (not used)
%   Column 5: battery voltage in V
%   Column 6: battery current in A
%   Column 7: battery power in W (not used)
%   Column 8: load voltage in V
%   Column 9: load current in A
%   Column 10: load power in W (not used)
%   Column 11: battery SOC in percent
%
% Returns:
%   supply_trace -- Sx3 Matrix: Rows are S samples.
%       Column 1: timestamp in seconds
%       Column 2: voltage in V
%       Column 3: current in A
%   battery_trace -- Sx3 Matrix: Rows are S samples.
%       Column 1: timestamp in seconds
%       Column 2: voltage in V
%       Column 3: current in A
%   load_trace -- Sx3 Matrix: Rows are S samples.
%       Column 1: timestamp in seconds
%       Column 2: voltage in V
%       Column 3: current in A
%   battery_soc_trace -- Sx3 Matrix: Rows are S samples.
%       Column 1: timestamp in seconds
%       Column 2: state of charge in percent


% Load the raw data
raw_data = csvread(filename,1,0); % Skip first header row
raw_data_size = size(raw_data);
S = raw_data_size(1);

supply_trace = NaN(S,3);
battery_trace = NaN(S,3);
load_trace = NaN(S,3);
battery_soc_trace = NaN(S,2);


supply_trace(:,1) = raw_data(:,1); % timestamp
supply_trace(:,2) = raw_data(:,2); % voltage
supply_trace(:,3) = raw_data(:,3); % current

battery_trace(:,1) = raw_data(:,1); % timestamp
battery_trace(:,2) = raw_data(:,5); % voltage
battery_trace(:,3) = raw_data(:,6); % current

load_trace(:,1) = raw_data(:,1); % timestamp
load_trace(:,2) = raw_data(:,8); % voltage
load_trace(:,3) = raw_data(:,9); % current

battery_soc_trace(:,1) = raw_data(:,1); % timestamp
battery_soc_trace(:,2) = raw_data(:,11); % soc

end