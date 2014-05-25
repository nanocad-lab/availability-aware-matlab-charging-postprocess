% Author: Mark Gottscho
% mgottscho@ucla.edu

% Load in all our traces and plot them

raw_data_path = '/Users/Mark/Dropbox/AvailabilityAware-share/data/charging/raw/nexus4/'; % Feel free to change this

% Add more as needed
[nexus4_trace_5V_300mA] = convert_raw_keithley_csv([raw_data_path 'nexus4-charging-nplc25-90000samples-5V-300mA-limit-notimestamp.csv'], 2, 60/25);
[nexus4_trace_5V_400mA] = convert_raw_keithley_csv([raw_data_path 'nexus4-charging-nplc25-90000samples-5V-400mA-limit-notimestamp.csv'], 2, 60/25);
[nexus4_trace_5V_600mA] = convert_raw_keithley_csv([raw_data_path 'nexus4-charging-nplc25-90000samples-5V-600mA-limit-modUSB-notimestamp.csv'], 2, 60/25);
[nexus4_trace_5V_700mA_1] = convert_raw_keithley_csv([raw_data_path 'nexus4-charging-nplc25-90000samples-5V-700mA-limit-modUSB-notimestamp.csv'], 2, 60/25);
[nexus4_trace_5V_700mA_2] = convert_raw_keithley_csv([raw_data_path 'nexus4-charging-nplc25-90000samples-5V-700mA-limit-modUSB-notimestamp_v2.csv'], 2, 60/25);
[nexus4_trace_5V_1000mA_1] = convert_raw_keithley_csv([raw_data_path 'nexus4-charging-nplc25-90000samples-5V-1000mA-limit-modUSB-notimestamp.csv'], 2, 60/25);
[nexus4_trace_5V_1000mA_2] = convert_raw_keithley_csv([raw_data_path 'nexus4-charging-hz3-64800samples-5V-1000mA-limit.csv'], 1, 3);
[nexus4_trace_5V_1000mA_3] = convert_raw_keithley_csv([raw_data_path 'nexus4-charging-hz5-36000samples-5V-1000mA-limit.csv'], 1, 5);

max_S = 90000; % Change me
num_traces = 8; % Change me

traces = NaN(max_S, 3, num_traces);

% Add more as needed
traces(1:size(nexus4_trace_5V_300mA,1), :, 1) = nexus4_trace_5V_300mA;
traces(1:size(nexus4_trace_5V_400mA,1), :, 2) = nexus4_trace_5V_400mA;
traces(1:size(nexus4_trace_5V_600mA,1), :, 3) = nexus4_trace_5V_600mA;
traces(1:size(nexus4_trace_5V_700mA_1,1), :, 4) = nexus4_trace_5V_700mA_1;
traces(1:size(nexus4_trace_5V_700mA_2,1), :, 5) = nexus4_trace_5V_700mA_2;
traces(1:size(nexus4_trace_5V_1000mA_1,1), :, 6) = nexus4_trace_5V_1000mA_1;
traces(1:size(nexus4_trace_5V_1000mA_2,1), :, 7) = nexus4_trace_5V_1000mA_2;
traces(1:size(nexus4_trace_5V_1000mA_3,1), :, 8) = nexus4_trace_5V_1000mA_3;

% Add more as needed
labels = {  'Nexus4, 5V, 300mA Limit'...
            'Nexus4, 5V, 400mA Limit'...
            'Nexus4, 5V, 600mA Limit With USB Hack'...
            'Nexus4, 5V, 700mA Limit With USB Hack Run 1'...
            'Nexus4, 5V, 700mA Limit With USB Hack Run 2'...
            'Nexus4, 5V, 1000mA Limit With USB Hack'...
            'Nexus4, 5V, 1000mA Limit Without USB Hack Run 1'...
            'Nexus4, 5V, 1000mA Limit Without USB Hack Run 2'...
         };

plot_charging_data(traces, hsv(num_traces), labels);