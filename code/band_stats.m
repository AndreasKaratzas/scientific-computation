function [P] = band_stats(mxid, p)
% Author : A. KARATZAS , AM 1054336 , Date : 16/02/2021
%
% BAND_STATS
%   
%   Usage BAND_STATS(mxid, p) where:
%     mxid - either the id (string or integer) corresponding to the matrix 
%            to be fetched from sparse suite, or the matrix itself
%        p - the upper bandwidth limit
%
%   Returns [P] where:
%        P - the array containing `rnnz` and `rerr`

    %% Initialize Matrix
    if issparse(mxid)               % Extract `A` with respect to variable type of `mxid`
        A = mxid;
    elseif isinteger(int8(mxid))
        A = ssget(mxid).A;
    elseif ischar(mxid)
        A = ssget(mxid).A;
    else                            % Mask undetected variable type fault
        assert(0, 'Error in mxid - argument is invalid')
    end
    
    %% Initialize workspace
    [n, ~] = size(A);               % Get size of A
    P = zeros(p, 2);                % Declare P
     
    %% Compute Statistics
    for i=0:p-1
        D = spdiags(spdiags(A, -i:i),-i:i, n, n);
                                    % Get A(k)
        P(i + 1,:) = [nnz(D)/nnz(A) norm(A - D, 'fro')/norm(A, 'fro')];
                                    % Compute `rnnz` and `rerr`
    end
    
    %% Plot statistics
    y = (1:2:2*p-1);
    figure;
    p = plot(y,P(:,1),y,P(:,2));
    p(1).Marker = 'o';
    p(2).Marker = '^';
    title('Band Stats');
    xlabel('k');
    xlabel('value');
    legend('rnnz', 'rerr');

end