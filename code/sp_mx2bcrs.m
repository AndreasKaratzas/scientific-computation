function [val, col_idx, row_blk] = sp_mx2bcrs(A, nb)
% Author : A. KARATZAS, AM 1054336, Date : 01/02/2021
%
% SP_MX2BCRS Generates Block Sparse Row representation of sparse matrix.
%   
%   Usage SP_MX2BCRS(A, nb) where:
%        A - is a square sparse matrix
%       nb - is the block size that divides perfectly the size of A
%
%   Returns [val, col_idx, row_blk] where:
%      val - a vector with the non-zero values
%  col_idx - indices of the columns
%  row_blk - the row block pointer  

    %% Initialize Workspace
    [rows, cols] = size(A);             % Get shape of given matrix
    [B, nz_blk] = nnz_blk(A, nb);       % Get indeces and total of non-zero blocks
    B_acc = cumsum(B, 2);               % Increments total of non-zero blocks for every block
    b_acc = B_acc(:, rows/nb);          % Compute total of non-zero blocks for every row
    val = zeros(nz_blk * nb, 1);        % Declare `val`
    row_blk = ones(rows/nb + 1, 1);     % Declare `row_blk`
    col_idx = zeros(nz_blk, 1);         % Declare `col_idx`
    val_cntr = 1;                       % Initialize index for `val`
    col_cntr = 1;                       % Initialize index for `col_idx`

    %% Perform Block Sparse Row matrix transformation
    for r_b = 1:(rows/nb)               % Iterate through block rows of A
        for c_b = 1:(cols/nb)           % Iterate through block rows of B
            if B(r_b, c_b) ~= 0         % This is a `non zero` block
                for r = 1:nb            % Store this block into `val`
                    for c = 1:nb
                        val(val_cntr) = A((r_b - 1) * nb + r,(c_b - 1) * nb + c);
                        val_cntr = val_cntr + 1;
                    end
                end
                col_idx(col_cntr) = c_b;% Store the column index
                col_cntr = col_cntr + 1;% Increment idex for `col_idx`
            end
        end
        row_blk(r_b + 1) = row_blk(r_b) + b_acc(r_b);
    end                                 % Store the row block pointer
end