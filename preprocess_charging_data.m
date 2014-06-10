% Author: Mark Gottscho
% mgottscho@ucla.edu

%% Set up paths for data for all devices of interest
master_path = '/Users/Mark/Dropbox/AvailabilityAware-share/data/charging/';

raw_data_path = [master_path 'raw/']; 
toshiba_raw_data_path = [raw_data_path 'toshiba/'];
nexus4_raw_data_path = [raw_data_path 'nexus4/'];
ipod_raw_data_path = [raw_data_path 'ipod/'];
custom_raw_data_path = [raw_data_path 'custom/'];
rawbatt_raw_data_path = [raw_data_path 'rawbatt/'];

pre_processed_data_path = [master_path 'pre-processed/'];
toshiba_pre_processed_data_path = [pre_processed_data_path 'toshiba/'];
nexus4_pre_processed_data_path = [pre_processed_data_path 'nexus4/'];
ipod_pre_processed_data_path = [pre_processed_data_path 'ipod/'];
custom_pre_processed_data_path = [pre_processed_data_path 'custom/'];
rawbatt_pre_processed_data_path = [pre_processed_data_path 'rawbatt/'];

%% Parse raw Toshiba laptop traces
%TODO

%% Parse raw Nexus4 traces
[nexus4_trace_5V_300mA] = convert_raw_keithley_csv([nexus4_raw_data_path 'nexus4-charging-nplc25-90000samples-5V-300mA-limit-notimestamp.csv'], 2, 60/25);
[nexus4_trace_5V_400mA] = convert_raw_keithley_csv([nexus4_raw_data_path 'nexus4-charging-nplc25-90000samples-5V-400mA-limit-notimestamp.csv'], 2, 60/25);
[nexus4_trace_5V_500mA] = convert_raw_keithley_csv([nexus4_raw_data_path 'nexus4-charging-nplc25-90000samples-5V-500mA-limit-modUSB-notimestamp.csv'], 2, 60/25);
[nexus4_trace_5V_600mA] = convert_raw_keithley_csv([nexus4_raw_data_path 'nexus4-charging-nplc25-90000samples-5V-600mA-limit-modUSB-notimestamp.csv'], 2, 60/25);
[nexus4_trace_5V_700mA] = convert_raw_keithley_csv([nexus4_raw_data_path 'nexus4-charging-nplc25-90000samples-5V-700mA-limit-modUSB-notimestamp.csv'], 2, 60/25);
[nexus4_trace_5V_1000mA] = convert_raw_keithley_csv([nexus4_raw_data_path 'nexus4-charging-nplc25-90000samples-5V-1000mA-limit-modUSB-notimestamp.csv'], 2, 60/25);
[nexus4_trace_5V_2100mA] = convert_raw_keithley_csv([nexus4_raw_data_path 'nexus4-charging-nplc25-90000samples-5V-2100mA-limit-modUSB-notimestamp.csv'], 2, 60/25);

%% Output pre-processed Nexus4 traces as CSV
csvwrite([nexus4_pre_processed_data_path 'nexus4_trace_5V_300mA.csv'], nexus4_trace_5V_300mA);
csvwrite([nexus4_pre_processed_data_path 'nexus4_trace_5V_400mA.csv'], nexus4_trace_5V_400mA);
csvwrite([nexus4_pre_processed_data_path 'nexus4_trace_5V_500mA.csv'], nexus4_trace_5V_500mA);
csvwrite([nexus4_pre_processed_data_path 'nexus4_trace_5V_600mA.csv'], nexus4_trace_5V_600mA);
csvwrite([nexus4_pre_processed_data_path 'nexus4_trace_5V_700mA.csv'], nexus4_trace_5V_700mA);
csvwrite([nexus4_pre_processed_data_path 'nexus4_trace_5V_1000mA.csv'], nexus4_trace_5V_1000mA);
csvwrite([nexus4_pre_processed_data_path 'nexus4_trace_5V_2100mA.csv'], nexus4_trace_5V_2100mA);

%% Parse raw iPod Touch traces
[ipod_trace_5V_500mA] = convert_raw_keithley_csv([ipod_raw_data_path 'ipod-charging-nplc25-90000samples-5V-500mA-limit-notimestamp.csv'], 2, 60/25);
[ipod_trace_5V_1000mA] = convert_raw_keithley_csv([ipod_raw_data_path 'ipod-charging-nplc25-90000samples-5V-1000mA-limit-notimestamp.csv'], 2, 60/25);

%% Output pre-processed iPod Touch traces as CSV
csvwrite([ipod_pre_processed_data_path 'ipod_trace_5V_500mA.csv'], ipod_trace_5V_500mA);
csvwrite([ipod_pre_processed_data_path 'ipod_trace_5V_1000mA.csv'], ipod_trace_5V_1000mA);

%% Parse raw Custom Board traces
[custom_trace_5V_500mA_supply, custom_trace_5V_500mA_battery, custom_trace_5V_500mA_load, custom_trace_5V_500mA_battsoc] = convert_raw_mbed_csv([custom_raw_data_path 'custom-charging-hz2-6600samples-5V-1000mA-limit.csv']);

%% Output pre-processed Custom Board traces as CSV
csvwrite([custom_pre_processed_data_path 'custom_trace_5V_500mA_supply.csv'], custom_trace_5V_500mA_supply);
csvwrite([custom_pre_processed_data_path 'custom_trace_5V_500mA_battery.csv'], custom_trace_5V_500mA_battery);
csvwrite([custom_pre_processed_data_path 'custom_trace_5V_500mA_load.csv'], custom_trace_5V_500mA_load);
csvwrite([custom_pre_processed_data_path 'custom_trace_5V_500mA_battsoc.csv'], custom_trace_5V_500mA_battsoc);

%% Parse Raw Battery traces
[rawbatt_400mAh_trace_4200mV_500mA] = convert_raw_keithley_csv([rawbatt_raw_data_path 'rawbatt-charging-nplc6-72000samples-4.2V-500mA-limit-notimestamp.csv'], 2, 10);

% The 600 mA run needs special handling because it is merged data from both
% Keithley and the custom board modified to measure just SOC during
% charging of rawbatt
tmp = csvread([rawbatt_raw_data_path 'rawbatt-charging-4.2V-600mA-limit-VI-SOC-merged.csv'], 1, 0);
rawbatt_400mAh_trace_4200mV_600mA = tmp(:,1:3); % First three columns of this special file are timestamp, voltage, current
rawbatt_400mAh_trace_4200mV_600mA_battsoc = tmp(1:14429,4:5); % Last two columns of this special file are timestamp, battsoc. But sampling rate was different, so different # rows

[rawbatt_400mAh_trace_4200mV_700mA] = convert_raw_keithley_csv([rawbatt_raw_data_path 'rawbatt-charging-nplc6-72000samples-4.2V-700mA-limit-notimestamp.csv'], 2, 10);
[rawbatt_400mAh_trace_4200mV_1000mA] = convert_raw_keithley_csv([rawbatt_raw_data_path 'rawbatt-charging-nplc6-72000samples-4.2V-1000mA-limit-notimestamp.csv'], 2, 10);

%% Output pre-processed Raw Battery traces as CSV
csvwrite([rawbatt_pre_processed_data_path 'rawbatt_400mAh_trace_4.2V_500mA.csv'], rawbatt_400mAh_trace_4200mV_500mA);
csvwrite([rawbatt_pre_processed_data_path 'rawbatt_400mAh_trace_4.2V_600mA.csv'], rawbatt_400mAh_trace_4200mV_600mA);
csvwrite([rawbatt_pre_processed_data_path 'rawbatt_400mAh_trace_4.2V_600mA_battsoc.csv'], rawbatt_400mAh_trace_4200mV_600mA_battsoc);
csvwrite([rawbatt_pre_processed_data_path 'rawbatt_400mAh_trace_4.2V_700mA.csv'], rawbatt_400mAh_trace_4200mV_700mA);
csvwrite([rawbatt_pre_processed_data_path 'rawbatt_400mAh_trace_4.2V_1000mA.csv'], rawbatt_400mAh_trace_4200mV_1000mA);

%% Cleanup unnecessary data
clear localeStruct;
clear i;

% clear master_path;
% 
% clear raw_data_path; 
% clear nexus4_raw_data_path;
% clear ipod_raw_data_path;
% clear custom_raw_data_path;
% clear rawbatt_raw_data_path;
% 
% clear pre_processed_data_path;
% clear nexus4_pre_processed_data_path;
% clear ipod_pre_processed_data_path;
% clear custom_pre_processed_data_path;
% clear rawbatt_pre_processed_data_path;

%% Save pre-processed workspace
save([pre_processed_data_path 'pre-processed.mat'], '-v7.3');
