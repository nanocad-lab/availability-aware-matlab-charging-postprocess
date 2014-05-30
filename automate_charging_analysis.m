% Author: Mark Gottscho
% mgottscho@ucla.edu

raw_data_path = '/Users/Mark/Dropbox/AvailabilityAware-share/data/charging/raw/'; % Feel free to change this
nexus_raw_data_path = [raw_data_path 'nexus4/'];
custom_raw_data_path = [raw_data_path 'custom/'];
rawbatt_raw_data_path = [raw_data_path 'rawbatt/'];

% Parse, aggregate, & plot Nexus4 traces
[nexus4_trace_5V_300mA] = convert_raw_keithley_csv([nexus_raw_data_path 'nexus4-charging-nplc25-90000samples-5V-300mA-limit-notimestamp.csv'], 2, 60/25);
[nexus4_trace_5V_300mA_v2] = convert_raw_keithley_csv([nexus_raw_data_path 'nexus4-charging-nplc25-90000samples-5V-300mA-limit-modUSB-notimestamp.csv'], 2, 60/25);
[nexus4_trace_5V_400mA] = convert_raw_keithley_csv([nexus_raw_data_path 'nexus4-charging-nplc25-90000samples-5V-400mA-limit-notimestamp.csv'], 2, 60/25);
[nexus4_trace_5V_600mA] = convert_raw_keithley_csv([nexus_raw_data_path 'nexus4-charging-nplc25-90000samples-5V-600mA-limit-modUSB-notimestamp.csv'], 2, 60/25);
[nexus4_trace_5V_700mA_1] = convert_raw_keithley_csv([nexus_raw_data_path 'nexus4-charging-nplc25-90000samples-5V-700mA-limit-modUSB-notimestamp.csv'], 2, 60/25);
[nexus4_trace_5V_700mA_2] = convert_raw_keithley_csv([nexus_raw_data_path 'nexus4-charging-nplc25-90000samples-5V-700mA-limit-modUSB-notimestamp_v2.csv'], 2, 60/25);
[nexus4_trace_5V_1000mA_1] = convert_raw_keithley_csv([nexus_raw_data_path 'nexus4-charging-nplc25-90000samples-5V-1000mA-limit-modUSB-notimestamp.csv'], 2, 60/25);
[nexus4_trace_5V_1000mA_2] = convert_raw_keithley_csv([nexus_raw_data_path 'nexus4-charging-hz3-64800samples-5V-1000mA-limit.csv'], 1, 3);
[nexus4_trace_5V_1000mA_3] = convert_raw_keithley_csv([nexus_raw_data_path 'nexus4-charging-hz5-36000samples-5V-1000mA-limit.csv'], 1, 5);

nexus4_max_S = 90000; % Change me, I am a hack
nexus4_num_traces = 9; % Change me, I am a hack
nexus4_traces = NaN(nexus4_max_S, 3, nexus4_num_traces);

nexus4_traces(:,:,1) = nexus4_trace_5V_300mA;
nexus4_traces(:,:,2) = nexus4_trace_5V_300mA_v2;
nexus4_traces(:,:,3) = nexus4_trace_5V_400mA;
nexus4_traces(:,:,4) = nexus4_trace_5V_600mA;
nexus4_traces(:,:,5) = nexus4_trace_5V_700mA_1;
nexus4_traces(:,:,6) = nexus4_trace_5V_700mA_2;
nexus4_traces(:,:,7) = nexus4_trace_5V_1000mA_1;
nexus4_traces(1:size(nexus4_trace_5V_1000mA_2, 1), :,8) = nexus4_trace_5V_1000mA_2;
nexus4_traces(1:size(nexus4_trace_5V_1000mA_3, 1), :,9) = nexus4_trace_5V_1000mA_3;

nexus4_labels = {  'Nexus4, 5V, 300mA Limit'...
			'Nexus4, 5V, 300mA Limit With USB Hack'...
            'Nexus4, 5V, 400mA Limit'...
            'Nexus4, 5V, 600mA Limit With USB Hack'...
            'Nexus4, 5V, 700mA Limit With USB Hack Run 1'...
            'Nexus4, 5V, 700mA Limit With USB Hack Run 2'...
            'Nexus4, 5V, 1000mA Limit With USB Hack'...
            'Nexus4, 5V, 1000mA Limit Without USB Hack Run 1'...
            'Nexus4, 5V, 1000mA Limit Without USB Hack Run 2'...
         };

plot_charging_data(nexus4_traces, hsv(nexus4_num_traces), nexus4_labels);


% Parse, aggregate, & plot Custom mbed-generated traces with the
% instrumentation board
[custom_trace_5V_500mA_supply, custom_trace_5V_500mA_battery, custom_trace_5V_500mA_load, custom_trace_5V_500mA_battsoc] = convert_raw_mbed_csv([custom_raw_data_path 'custom-charging-hz2-6600samples-5V-1000mA-limit.csv']);
custom_max_S = 13238; % Change me, I am a hack
custom_num_traces = 1; % Change me, I am a hack
custom_traces = NaN(custom_max_S, 3, custom_num_traces);

custom_traces(:,:,1) = custom_trace_5V_500mA_battery;

custom_labels = {  'Custom Board, 5V, 500mA Limit'...
         };

plot_charging_data(custom_traces, hsv(custom_num_traces), custom_labels);

% Plot the battery SOC custom since it's not expected format for
% plot_charging_data()
figure;
plot(custom_trace_5V_500mA_battsoc(:,1)/3600, custom_trace_5V_500mA_battsoc(:,2));
xlabel('Time (h)');
set(gca, 'FontName', 'Arial', 'FontSize', 18);
ylabel('Battery State of Charge (%)');
set(gca, 'FontName', 'Arial', 'FontSize', 18);


% Parse, aggregate, & plot direct battery traces
[rawbatt_400mAh_trace_4200mV_500mA] = convert_raw_keithley_csv([rawbatt_raw_data_path 'rawbatt-charging-nplc6-72000samples-4.2V-500mA-limit.csv']);
rawbatt_max_S = 72000; % Change me, I am a hack
rawbatt_num_traces = 1; % Change me, I am a hack
rawbatt_traces = NaN(rawbatt_max_S, 3, rawbatt_num_traces);

rawbatt_traces(:,:,1) = rawbatt_400mAh_trace_4200mV_500mA;

rawbatt_labels = {  'Raw 400mAh Battery, 4.2V, 500mA Limit'...
         };

plot_charging_data(rawbatt_traces, hsv(rawbatt_num_traces), rawbatt_labels);

tilefig;