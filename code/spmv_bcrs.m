function [y] = spmv_bcrs(y, val, col_idx, row_blk, x)
% Author : A. KARATZAS , AM 1054336 , Date : 02/02/2021
%
% SPMV_BCRS Performs GEMV operation given a sparse matrix in Block Sparse
%           Row representation.
%   
%   Usage SPMV_BCRS(y, val, col_idx, row_blk, x) where:
%        x - is a vector to multiply with the given matrix
%        y - is a vector to add to the result after the multiplication
%      val - is the vector with the matrix data
%  col_idx - indices of the columns
%  row_blk - the row block pointer
%
%   Returns [y] where:
%        y - the result of GEMV

    %% Initialize workspace
    row_blk_cntr = 1;                                               % Initialize row block count
    row_cntr = 1;                                                   % Initialize `row_blk` index
    n_blocks = row_blk(end) - 1;                                    % Initialize total number of blocks
    block_size = sqrt(double(numel(val) / n_blocks));               % Get block size
    r_block_elems = row_blk(row_cntr + 1) - row_blk(row_cntr);      % Get number of non-zero blocks on first row
    
    %% Perform GEMV
    for block = 1:n_blocks
        not_updated = true;                                         % Reet row update flag
        for row = 1:block_size                                      % Iterate through i-th block
            for col = 1:block_size
                y((block_size * (row_cntr - 1)) + row) = y((block_size * (row_cntr - 1)) + row) + val(((block - 1) * block_size * block_size) + ((row - 1) * block_size) + col) * x(((col_idx(block) - 1) * block_size) + col);
            end                                                     % Perform GEMV
        end
        
        while not_updated                                           % Parse all in-between zero blocks
            if row_blk_cntr >= r_block_elems && block < n_blocks    % Non-zero block found
                row_blk_cntr = 1;                                   % Reset row block count
                row_cntr = row_cntr + 1;                            % Get next row
                r_block_elems = row_blk(row_cntr + 1) - row_blk(row_cntr);
                                                                    % Get number of non-zero blocks on that row
                if r_block_elems ~= 0                               % Skip row if there are only zero blocks
                    not_updated = false;
                end
            else                                                    % No non-zero block found on that row
                row_blk_cntr = row_blk_cntr + 1;                    % Update row block count
                not_updated = false;                                % Set row update flag
            end 
        end
    end
end