function [] = plot_charging_data(traces, colors, labels)
% Authors: Mark Gottscho and Salma Elmalaki
% mgottscho@ucla.edu
%
% Arguments:
%   traces -- Sx3xN Matrix: First column is timestamp in seconds,
%       second column is voltage in V, third column is current in A.
%       S is maximum number of samples in any of the traces. N is the
%       number of traces.

N = size(traces,3);
S = size(traces,2);

% Error check
if size(colors,1) ~= N || size(labels,2) ~= N
    display('Number of traces must match number of colors and labels.');
    colors_size = size(colors)
    labels_size = size(labels)
    return;
end

for i=1:N
   % Voltage
   figure(1);
   hold on;
   plot(traces(:,1,i)/3600, traces(:,2,i), 'Color', colors(i,:));
   hold off;
   
   % Current
   figure(2);
   hold on;
   plot(traces(:,1,i)/3600, traces(:,3,i), 'Color', colors(i,:));
   hold off;
   
   % Power
   figure(3);
   hold on;
   plot(traces(:,1,i)/3600, traces(:,2,i) .* traces(:,3,i), 'Color', colors(i,:));
   hold off;
end


figure(1);
xlabel('Time (h)');
ylabel('Voltage (V)');
set(gca, 'FontName', 'Arial', 'FontSize', 16);
legend(labels);

figure(2);
xlabel('Time (h)');
ylabel('Current (A)');
set(gca, 'FontName', 'Arial', 'FontSize', 16);
legend(labels);


figure(3);
xlabel('Time (h)');
ylabel('Power (W)');
set(gca, 'FontName', 'Arial', 'FontSize', 16);
legend(labels);

end