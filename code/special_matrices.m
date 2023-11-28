
%% Clear workspace
clear;
clc;

%% Experiment 1
n = 500; 
A1 = spdiags([1:n]', [0], n, n); 
xsol = ones(n, 1); 
b1 = A1 * xsol;
tol = 1e-6;
maxit = 4 * n;
[x1, flag1, relres1, iter1, resvec1] = pcg(A1, b1, tol, maxit, [], [], []);

%% Experiment 2
n = 500; 
A2 = spdiags([linspace(1, 2, n/2)';linspace(1000, 1001, n/2)'], [0], n, n); 
xsol = ones(n, 1);
b2 = A2 * xsol;
tol = 1e-6;
maxit = 4 * n;
[x2, flag2, relres2, iter2, resvec2] = pcg(A2, b2, tol, maxit, [], [], []);

%% plot
figure;
semilogy(0:length(resvec1)-1, resvec1/norm(b1),'-o')
hold on
semilogy(0:length(resvec2)-1, resvec2/norm(b2),'-^')
yline(tol,'r--');
legend('First Experiment','Second Experiment','Tolerance','Location','East')
xlabel('Iteration number')
ylabel('Relative residual')
title('Experiments')
