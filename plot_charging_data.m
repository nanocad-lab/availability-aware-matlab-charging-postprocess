function [] = plot_charging_data(traces, colors, labels, figtitle, output_dir)
% Author: Mark Gottscho
% mgottscho@ucla.edu
%
% Arguments:
%   traces -- Sx3xN Matrix: First column is timestamp in seconds,
%       second column is voltage in V, third column is current in A.
%       S is maximum number of samples in any of the traces. N is the
%       number of traces.
%   colors -- Nx3 Matrix: Color RGB entry in rows for each trace
%   labels -- 1xN Vector: Labels for each trace to be put in figure legend
%   figtitle -- String: Title string to display on top of each generated
%       figure. Leave as '' if you don't want a title shown
%   output_dir -- String: Full path to directory where you want .fig, .eps,
%       .png files written for each figure

N = size(traces,3);
S = size(traces,2);

% Error check
if size(colors,1) ~= N || size(labels,2) ~= N
    display('Number of traces must match number of colors and labels.');
    colors_size = size(colors)
    labels_size = size(labels)
    return;
end

vfig = figure; % voltage
ifig = figure; % current
pfig = figure; % power

for i=1:N
   % Voltage
   figure(vfig);
   hold on;
   plot(traces(:,1,i)/3600, traces(:,2,i), 'Color', colors(i,:));
   hold off;
   
   % Current
   figure(ifig);
   hold on;
   plot(traces(:,1,i)/3600, traces(:,3,i), 'Color', colors(i,:));
   hold off;
   
   % Power
   figure(pfig);
   hold on;
   plot(traces(:,1,i)/3600, traces(:,2,i) .* traces(:,3,i), 'Color', colors(i,:));
   hold off;
end


figure(vfig);
title(figtitle, 'FontName', 'Arial', 'FontSize', 18);
xlabel('Time (h)', 'FontName', 'Arial', 'FontSize', 16);
set(gca, 'FontName', 'Arial', 'FontSize', 16);
ylabel('Voltage (V)', 'FontName', 'Arial', 'FontSize', 16);
set(gca, 'FontName', 'Arial', 'FontSize', 16);
legend(labels, 'FontName', 'Arial', 'FontSize', 12);
saveplot(vfig, [output_dir 'charging_voltages']);

figure(ifig);
title(figtitle, 'FontName', 'Arial', 'FontSize', 18);
xlabel('Time (h)', 'FontName', 'Arial', 'FontSize', 16);
set(gca, 'FontName', 'Arial', 'FontSize', 16);
ylabel('Current (A)', 'FontName', 'Arial', 'FontSize', 16);
set(gca, 'FontName', 'Arial', 'FontSize', 16);
legend(labels, 'FontName', 'Arial', 'FontSize', 12);
saveplot(ifig, [output_dir 'charging_currents']);

figure(pfig);
title(figtitle, 'FontName', 'Arial', 'FontSize', 18);
xlabel('Time (h)', 'FontName', 'Arial', 'FontSize', 16);
set(gca, 'FontName', 'Arial', 'FontSize', 16);
ylabel('Power (W)', 'FontName', 'Arial', 'FontSize', 16);
set(gca, 'FontName', 'Arial', 'FontSize', 16);
legend(labels, 'FontName', 'Arial', 'FontSize', 12);
saveplot(pfig, [output_dir 'charging_powers']);

end