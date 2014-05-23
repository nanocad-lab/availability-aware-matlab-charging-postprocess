% Load in all our traces and plot them
[nexus4_trace_5V_300mA] = convert_raw_keithley_csv('/Users/Mark/Dropbox/AvailabilityAware-share/data/nexus4-charging/nexus4_b_25_90000_6_0.3_5_nplc_notimestamps_ascii/nexus4_b_25_90000_6_0.3_5_nplc_notimestamp_ascii.csv', 2, 2.4);
[nexus4_trace_5V_400mA] = convert_raw_keithley_csv('/Users/Mark/Dropbox/AvailabilityAware-share/data/nexus4-charging/nexus4_b_25_90000_6_0.4_5_nplc_notimestamps_ascii/nexus4_b_25_90000_6_0.4_5_nplc_notimestamp_ascii.csv', 2, 2.4);
[nexus4_trace_5V_600mA] = convert_raw_keithley_csv('/Users/Mark/Dropbox/AvailabilityAware-share/data/nexus4-charging/nexus4_b_25_90000_6_0.6_5_nplc_notimestamps_ascii_mod_ac_cable/nexus4_b_25_90000_6_0.6_5_nplc_notimestamp_ascii_mod_ac_cable.csv', 2, 2.4);
[nexus4_trace_5V_1000mA_1] = convert_raw_keithley_csv('/Users/Mark/Dropbox/AvailabilityAware-share/data/nexus4-charging/nexus4_b_25_90000_6_1_5_nplc_notimestamp_ascii_mod_ac_cable/nexus4_b_25_90000_6_1_5_nplc_notimestamp_ascii_mod_ac_cable.csv', 2, 2.4);
[nexus4_trace_5V_1000mA_2] = convert_raw_keithley_csv('/Users/Mark/Dropbox/AvailabilityAware-share/data/nexus4-charging/nexus4_b_3_64800_6_1_5/nexus4_b_3_64800_6_1_5.csv', 1, 3);
[nexus4_trace_5V_1000mA_3] = convert_raw_keithley_csv('/Users/Mark/Dropbox/AvailabilityAware-share/data/nexus4-charging/nexus4_b_5_36000_6_1_5/nexus4_b_5_36000_6_1_5.csv', 1, 5);


max_S = 90000;
traces = NaN(max_S, 3, 6);
traces(1:size(nexus4_trace_5V_300mA,1), :, 1) = nexus4_trace_5V_300mA;
traces(1:size(nexus4_trace_5V_400mA,1), :, 2) = nexus4_trace_5V_400mA;
traces(1:size(nexus4_trace_5V_600mA,1), :, 3) = nexus4_trace_5V_600mA;
traces(1:size(nexus4_trace_5V_1000mA_1,1), :, 4) = nexus4_trace_5V_1000mA_1;
traces(1:size(nexus4_trace_5V_1000mA_2,1), :, 5) = nexus4_trace_5V_1000mA_2;
traces(1:size(nexus4_trace_5V_1000mA_3,1), :, 6) = nexus4_trace_5V_1000mA_3;


plot_charging_data(traces, hsv(6), {'Nexus4, 5V, 300mA Limit', 'Nexus4, 5V, 400mA Limit', 'Nexus4, 5V, 600mA Limit With USB Hack', 'Nexus4, 5V, 1000mA Limit With USB Hack', 'Nexus4, 5V, 1000mA Limit Without USB Hack Run 1', 'Nexus4, 5V, 1000mA Limit Without USB Hack Run 2'});