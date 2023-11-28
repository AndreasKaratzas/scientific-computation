function [G] = adj_mat2tensor(A, k)
% Author : A. KARATZAS , AM 1054336 , Date : 15/02/2021
%
% ADJ_MAT2TENSOR Converts Adjacent Matrix to a tensor that contains the
%                number of walks of length up to k between any set of nodes
%                (i, j).
%   
%   Usage ADJ_MAT2TENSOR(A, k) where:
%        A - the adjacent matrix of a graph G
%        k - the upper bound of length of a walk to be computed
%
%   Returns [G] where:
%        G - the computed tensor

    %% Initialize workspace
    [n, ~] = size(A);           % Getmatrix size
    flag = 0;                   % Initialize flag for tracing defective matrix
    G = A;                      % Initialize tensor
    
    %% Compute 3-order tensor
    tf = issymmetric(A);        % test if matrix is symmetric
    if tf == 1
        [V, D] = eig(A);        % diagonalize matrix
        if length(unique(diag(D))) ~= n
                                % test if matrix is defective
            flag = is_defective(V, diag(D), n);
        end
        if flag == 0            % if matrix is not defective
            V_inv = inv(V);
            for i=2:k           % Use diagonalized matrix to compute powers of matrix
                G(:,:,i) = V*diag(diag(D).^i)*V_inv;
            end
        else                    % if matrix is defective
            for i = 2:k         % Use traditional GEMM
                G(:,:,i) = G(:,:,i-1) * A;
            end
        end
    else                        % Matrix is not symmetric
        for i = 2:k             % Use traditional GEMM
            G(:,:,i) = G(:,:,i-1) * A;
        end
    end  
    
    %% Convert computed structure to tensor
    G = tensor(G);
    
end
