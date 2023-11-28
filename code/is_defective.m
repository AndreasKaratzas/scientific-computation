function [flag] = is_defective(V, d, n)
% Author : A. KARATZAS , AM 1054336 , Date : 14/02/2021
%
% IS_DEFECTIVE Checks if matrix is diagonalizable.
%   
%   Usage is_defective(V, d, n) where:
%        V - is the matrix whose columns are the corresponding right eigenvectors
%        d - is the vector with diagonal of the diagonal matrix D of eigenvalues
%        n - is the size of d (this is also equal to the number of rows and the number of columns of V)
%
%   Returns [flag] where:
%     flag - binary variable indicating:
%          * a diagonalizable matrix if 0
%          * a non-diagonalizable (defective) matrix if 1

    flag = 0;
    
    for i=1:n
        for j=i+1:n
            if d(i) == d(j)
                if V(i) == V(j)
                    flag = 1;
                    break;
                end
            end
        end
    end
end