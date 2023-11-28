
%% Clear workspace
clc;
clear;

%% Perform validation check for first Sparse matrix
Q = load('circuit204.mat');                                     % Load first chosen sparse matrix
[q_n, ~] = size(Q.Problem.A);                                   % Get size of matrix
q_div = get_divisors(q_n, 5);                                   % Get divisors of size of matrix
q_nb = q_div(randi([1 numel(q_div)]));                          % Generate a random divisor as block size
[q_val, q_col_idx, q_row_blk] = sp_mx2bcrs(Q.Problem.A, q_nb);  % Compute BCRS format
q_x = rand(q_n,1);                                              % Generate a random `x` vector
q_y = rand(q_n,1);                                              % Generate a random `y` vector
[q_z] = spmv_bcrs(q_y, q_val, q_col_idx, q_row_blk, q_x);       % Compute GEMV
v1 = norm(q_z - (q_y + Q.Problem.A * q_x), 'fro');              % Validation

%% Perform validation check for second Sparse matrix
R = load('tols2000.mat');                                       % Load second chosen sparse matrix
[r_n, ~] = size(R.Problem.A);                                   % Get size of matrix
r_div = get_divisors(r_n, 5);                                   % Get divisors of size of matrix
r_nb = r_div(randi([1 numel(r_div)]));                          % Generate a random divisor as block size
[r_val, r_col_idx, r_row_blk] = sp_mx2bcrs(R.Problem.A, r_nb);  % Compute BCRS format
r_x = rand(r_n,1);                                              % Generate a random `x` vector
r_y = rand(r_n,1);                                              % Generate a random `y` vector
[r_z] = spmv_bcrs(r_y, r_val, r_col_idx, r_row_blk, r_x);       % Compute GEMV
v2 = norm(r_z - (r_y + R.Problem.A * r_x), 'fro');              % Validation

%% Wrap results
one.epxeriment = 'circuit204.mat';
one.error = v1;

two.epxeriment = 'tols2000.mat';
two.error = v2;

% Wrap results
experiment_results = struct2table([one; two]);

% Display results
disp(experiment_results);
