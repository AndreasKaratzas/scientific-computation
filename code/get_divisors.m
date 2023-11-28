function [D] = get_divisors(x, n)
% Author : A. KARATZAS , AM 1054336 , Date : 02/02/2021
%
% GET_DIVISORS Generates all ivisors for a given scalar.
%   
%   Usage SP_MX2BCRS(x, n) where:
%        x - is a scalar
%        n - is the amount of elements to cut from the vector's beginning and end
%
%   Returns [D] where:
%        D - a vector with all divisors of x

    K = 1:ceil(sqrt(x));
    D = K(rem(x,K)==0);
    D = [D sort(x./D)];

    assert(n * 2 < numel(D), 'n was greater than total number of elements in D')
    D = D(1 + n: numel(D) - n);
end