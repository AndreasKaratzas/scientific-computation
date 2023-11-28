
%% Clear workspace
clear;
clc;

%% Initialize workspace
n = 100;                            % Initialize dimensions of graph
sym_flag = 1;                       % Set sym flag to 0 for a undirected graph, or 1 for a directed
A = gen_adj_mat(n, sym_flag);       % Generate a random adjacency matrix
k = 3;                              % Set veriable `k`

%% Test ADJ_MAT2TENSOR
G = adj_mat2tensor(A, k);
