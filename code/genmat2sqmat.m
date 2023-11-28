function [P] = genmat2sqmat(P)
% Author : A. KARATZAS , AM 1054336 , Date : 15/02/2021
%
% GENMAT2SQMAT Converts a general matrix to a square matrix by cutting off
%              rows or columns.
%   
%   Usage GENMAT2SQMAT(P) where:
%        P - The given (unfiltered) matrix
%
%   Returns [P] where:
%        P - The filtered matrix

    %% Fine tune matrix
    [rows, cols] = size(P);
    % make matrix a square matrix
    if rows > cols
        P = P(1:cols, 1:cols);
    elseif rows < cols
        P = P(1:rows, 1:rows);
    end
end