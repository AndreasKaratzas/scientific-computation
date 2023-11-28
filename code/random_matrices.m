
%% Clear workspace
clear;
clc;

%% Disable warnings (gmres warns of maxit)
warning('off','all')

%% Initialize workspace
n = 500;
m = 100;
A = randn(n);
xsol = rand(n,1);
b = A * xsol;
tol = 1e-6;
maxit = 4 * n;

%% First experiment - pcg (No preconditioner)
[x_pcg, flag_pcg, ~, iter_pcg, resvec_pcg] = pcg(A, b, tol, maxit, [], [], []);

%% Second experiment - gmres (Restarts every m iterations)
[x_gmres_m, flag_gmres_m, ~, iter_gmres_m, resvec_gmres_m] = gmres(A, b, m, tol, maxit, [], [], []);

%% Third experiment - gmres (Restarts every n iterations)
[x_gmres_n, flag_gmres_n, ~, iter_gmres_n, resvec_gmres_n] = gmres(A, b, n, tol, maxit, [], [], []);

%% Fourth experiment - mldivide
x_mldivide = A\b;

%% Compute relative residual for each experiment
relres_pcg = norm(b - A * x_pcg) / norm(b);
relres_gmres_m = norm(b - A * x_gmres_m) / norm(b);
relres_gmres_n = norm(b - A * x_gmres_n) / norm(b);
relres_mldivide = norm(b - A * x_mldivide) / norm(b);

%% Plot experiment results
figure;
semilogy(0:length(resvec_pcg)-1, resvec_pcg/norm(b),'-o')
hold on
semilogy(0:length(resvec_gmres_m)-1, resvec_gmres_m/norm(b),'-^')
semilogy(0:length(resvec_gmres_n)-1, resvec_gmres_n/norm(b),'-*')
yline(tol,'r--');
legend('PCG','GMRES (restart = m)', 'GMRES (restart = n)', 'Tolerance','Location','East')
xlabel('Iteration number')
ylabel('Relative residual')
title('Experiments')

%% Benchmark methods
f = @() pcg(A, b, tol, maxit, [], [], []);
g = @() gmres(A, b, m, tol, maxit, [], [], []);
h = @() gmres(A, b, n, tol, maxit, [], [], []);
i = @() A\b;

t_pcg = timeit(f, 5);
t_gmres_m = timeit(g, 5);
t_gmres_n = timeit(h, 5);
t_mldivide = timeit(i, 1);

%% Compare results - relative residual & benchmark
pcg.experiment = 'PCG';
pcg.relres = relres_pcg;
pcg.benchmark = t_pcg;

gmres_m.experiment = 'GMRES_m';
gmres_m.relres = relres_gmres_m;
gmres_m.benchmark = t_gmres_m;

gmres_n.experiment = 'GMRES_n';
gmres_n.relres = relres_gmres_n;
gmres_n.benchmark = t_gmres_n;

mldivide.experiment = 'MLDIVIDE';
mldivide.relres = relres_mldivide;
mldivide.benchmark = t_mldivide;

% Wrap results
experiment_results = struct2table([pcg; gmres_m; gmres_n; mldivide]);

% Display results
disp(experiment_results);

%% Enable warnings (restore warning policy)
warning('on','all')
