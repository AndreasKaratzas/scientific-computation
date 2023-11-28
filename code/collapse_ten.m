function [C] = collapse_ten(G)
% Author : A. KARATZAS , AM 1054336 , Date : 15/02/2021
%
% COLLAPSE_TEN Returns a collapsed matrix containing the sum of 
%              each fiber in a given tensor.
%   
%   Usage COLLAPSE_TEN(G) where:
%        G - a 3-order tensor
%
%   Returns [c] where:
%        C - the collapsed tensor

    C = collapse(G,[3:3]);
end