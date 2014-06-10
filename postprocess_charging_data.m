% Author: Mark Gottscho
% mgottscho@ucla.edu
%
% Make sure to run pre_process_charging_data.m script first, or otherwise
% load in the saved .mat file from that script.

%% Set up paths for pre-processed, processed, and output
master_path = '/Users/Mark/Dropbox/AvailabilityAware-share/data/charging/';

pre_processed_data_path = [master_path 'pre-processed/'];
nexus4_pre_processed_data_path = [pre_processed_data_path 'nexus4/'];
ipod_pre_processed_data_path = [pre_processed_data_path 'ipod/'];
custom_pre_processed_data_path = [pre_processed_data_path 'custom/'];
rawbatt_pre_processed_data_path = [pre_processed_data_path 'rawbatt/'];

post_processed_data_path = [master_path 'post-processed/'];
nexus4_post_processed_data_path = [post_processed_data_path 'nexus4/'];
ipod_post_processed_data_path = [post_processed_data_path 'ipod/'];
custom_post_processed_data_path = [post_processed_data_path 'custom/'];
rawbatt_post_processed_data_path = [post_processed_data_path 'rawbatt/'];


%% Aggregate & plot Nexus4 traces
nexus4_max_S = 90000; % Change me, I am a hack
nexus4_num_traces = 6; % Change me, I am a hack
nexus4_traces = NaN(nexus4_max_S, 3, nexus4_num_traces);

nexus4_traces(:,:,1) = nexus4_trace_5V_300mA;
nexus4_traces(:,:,2) = nexus4_trace_5V_400mA;
nexus4_traces(:,:,3) = nexus4_trace_5V_600mA;
nexus4_traces(:,:,4) = nexus4_trace_5V_700mA;
nexus4_traces(:,:,5) = nexus4_trace_5V_1000mA;
nexus4_traces(:,:,6) = nexus4_trace_5V_2100mA;

nexus4_labels = {  'Nexus4, 5V, 300mA Limit'...
            'Nexus4, 5V, 400mA Limit'...
            'Nexus4, 5V, 600mA Limit With USB Hack'...
            'Nexus4, 5V, 700mA Limit With USB Hack'...
            'Nexus4, 5V, 1000mA Limit With USB Hack'...
            'Nexus4, 5V, 2100mA Limit With USB Hack'...
         };

plot_charging_data(nexus4_traces, hsv(nexus4_num_traces), nexus4_labels, 'Nexus4 Charging', nexus4_post_processed_data_path);

%% Aggregate & plot iPod traces
ipod_max_S = 90000; % Change me, I am a hack
ipod_num_traces = 2; % Change me, I am a hack
ipod_traces = NaN(ipod_max_S, 3, ipod_num_traces);

ipod_traces(:,:,1) = ipod_trace_5V_500mA;
ipod_traces(:,:,2) = ipod_trace_5V_1000mA;

ipod_labels = {  'iPod Touch 5th Gen, 5V, 500mA Limit'...
                 'iPod Touch 5th Gen, 5V, 1000mA Limit'...
         };

plot_charging_data(ipod_traces, hsv(ipod_num_traces), ipod_labels, 'iPod Touch 5th Gen', ipod_post_processed_data_path);


%% Aggregate & plot Custom mbed-generated traces with the instrumentation board
custom_max_S = 13238; % Change me, I am a hack
custom_num_traces = 1; % Change me, I am a hack
custom_traces = NaN(custom_max_S, 3, custom_num_traces);

custom_traces(:,:,1) = custom_trace_5V_500mA_battery;
custom_traces(:,3,:) = -custom_traces(:,3,:); % Flip current polarity to plot, since negative current for battery on custom board means charging

custom_labels = {  'Custom Board, 5V, 500mA Limit'...
         };

plot_charging_data(custom_traces, hsv(custom_num_traces), custom_labels, 'Custom Board Charging Traces', custom_post_processed_data_path);

% Plot the battery SOC custom since it's not expected format for
% plot_charging_data()
figure;
plot(custom_trace_5V_500mA_battsoc(:,1)/3600, custom_trace_5V_500mA_battsoc(:,2));
xlabel('Time (h)', 'FontName', 'Arial', 'FontSize', 16);
ylabel('Battery State of Charge (%)', 'FontName', 'Arial', 'FontSize', 16);
title('Custom Board Charging Traces', 'FontName', 'Arial', 'FontSize', 18);
saveplot(gcf, [custom_post_processed_data_path 'charging_soc']);


%% Aggregate & plot direct battery traces
rawbatt_max_S = 72000; % Change me, I am a hack
rawbatt_num_traces = 1; % Change me, I am a hack
rawbatt_traces = NaN(rawbatt_max_S, 3, rawbatt_num_traces);

rawbatt_traces(:,:,1) = rawbatt_400mAh_trace_4200mV_500mA;

rawbatt_labels = {  'Raw 400mAh Battery, 4.2V, 500mA Limit'...
         };

plot_charging_data(rawbatt_traces, hsv(rawbatt_num_traces), rawbatt_labels, 'Raw LiPo Battery Charging Traces', rawbatt_post_processed_data_path);

%% Save post-processed workspace, which includes pre-processed data as well
save([post_processed_data_path 'post-processed.mat'], '-v7.3');

%% Organize figures on screen
tilefig;