function [c] = get_ten_fiber(G, i, j)
% Author : A. KARATZAS , AM 1054336 , Date : 15/02/2021
%
% GET_TEN_FIBER Returns sum of all fiber elements given an order-3 tensor.
%   
%   Usage GET_TEN_FIBER(G, i, j) where:
%        G - a 3-order tensor
%        i - the row index
%        j - the column index
%
%   Returns [c] where:
%        c - the accumulated sum of all fiber elements

    c = collapse(G(i,j,:));
end