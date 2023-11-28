function [B, nz] = nnz_blk(A, nb)
% Author : A. KARATZAS, AM 1054336, Date : 01/02/2021
%
% NNZ_BLK Finds non zero blocks of the given matrix. It also
%         computes the boolean block matrix representing the 
%         non-zero blocks, providing index information.
%   
%   Usage NNZ_BLK(A, nb) where:
%        A - is a square sparse matrix
%       nb - is the block size that divides perfectly the size of A
%
%   Returns [nz] where:
%        B - boolean matrix representing non-zero blocks
%       nz - number of non-zero blocks found in the given square matrix

    %% Initialize workspace
    [rows, cols] = size(A);
    acc = zeros((rows/nb) * (rows/nb), 1);
    B = zeros((rows/nb), (rows/nb));
    
    %% Perform custom Block NNZ
    for r_b = 1:(rows/nb)
        for c_b = 1:(cols/nb)
            for r = 1:nb
                for c = 1:nb
                    if A((r_b - 1) * nb + r,(c_b - 1) * nb + c) ~= 0
                        acc(r_b * rows / nb + c_b) = 1;
                        B(r_b, c_b) = 1;
                    end
                end
            end
        end
    end
    
    %% Fine tune results
    acc = cumsum(acc);
    nz = acc(end);
end