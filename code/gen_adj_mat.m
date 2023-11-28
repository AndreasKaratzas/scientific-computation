function [A] = gen_adj_mat(n, sym_flag)
% Author : A. KARATZAS , AM 1054336 , Date : 15/02/2021
%
% GEN_ADJ_MAT Generates a random adjacency matrix 
%
%   Usage GEN_ADJ_MAT(n, sym_flag) where:
%        n - the number of nodes in a graph
% sym_flag - a flag that if set tells the function to generate a random
%            adjacency matrix corresponding to a undirected graph.
%
%   Returns [A] where:
%        A - the random adjacency matrix

    A = zeros(n);
    
    if sym_flag == 1
        nnz_count = (n^2 + n)/2;
        for i=1:nnz_count
            for j=i:n
                A(i, j) = randi([0 1]);
                A(j, i) = A(i, j);
            end
        end
    else
        A = randi([0 1], n);
    end
end