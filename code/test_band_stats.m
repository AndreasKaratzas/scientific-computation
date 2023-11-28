
%% Clear workspace
clc;
clear;

%% Initialize workspase
mat_1 = 1 + mod(4336, 2892);        % AM : 105 4336
mat_2 = 'Rajat/rajat04';
mat_3 = gallery('wathen',10,20);

%% Get test matrices
mxid_1 = ssget(mat_1);
mxid_2 = ssget(mat_2);
mxid_3 = mat_3;

%% Extract sparse matrices from structs
mxid_1 = mxid_1.A;
mxid_2 = mxid_2.A;

%% Crop large matrix
[n, ~] = size(mxid_1);
if n > 1000
    mxid_1 = mxid_1(1:1000, 1:1000);
end

%% Get matrix sizes
[p_1, ~] = size(mxid_1);
[p_2, ~] = size(mxid_2);
[p_3, ~] = size(mxid_3);

%% test band_stats for each matrix
P_1 = band_stats(mxid_1, p_1);
P_2 = band_stats(mxid_2, p_2);
P_3 = band_stats(mxid_3, p_3);
