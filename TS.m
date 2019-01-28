clear ; close all; clc

% data = load('data_sinc.txt');
% data = load('data_sinc_2.txt');
% data = load('data_saddle.txt');
 data = load('data_saddle_2.txt');
k = size(data, 2) - 1; % number of premise variables
X = data(:, 1:k);
y = data(:, k+1);
m = length(y); % number of examples
X = [ones(m, 1), X];

% data_test = load('data_sinc_test.txt');
% data_test = load('data_sinc_test_2.txt');
% data_test = load('data_saddle_test.txt');
 data_test = load('data_saddle_test_2.txt');
X_test = data_test(:, 1:k);
y_test = data_test(:, k+1);
m_test = length(y_test);
X_test = [ones(m_test, 1), X_test];

S = 0; % stage
S_max = 5;
threshold = 0.0001;

q = zeros(1, S_max);

q_opt = inf;
M_opt = [];
M = [];

while (S < S_max && q_opt > threshold)
   S = S + 1;
   
   M = [M_opt, 0];
   n = 2^length(M);
   
   for j = 1:k 
       M(S) = j;   
       [pp, nmf, xj] = initializePP(X, M, k);
       
       R = createRules(nmf, n);
       
       qq = inf;
       
       while (1)
           beta = calculateBeta(R, pp, xj, n, m, X);
           X_ = calculateX(beta, X, n, m, k);

           P = KalmanFilter(X_, y);
           
           pp = optimizePP(pp, xj, nmf, X, P, y, R, n, m, k);
           y_ = calculateY(P, X, beta, n, k);
          
           if (abs(qq - pIndex(y, y_)) < 0.001)
               qq = pIndex(y, y_);
               break;
           end
           
           qq = pIndex(y, y_);
       end
       
       if (qq < q_opt)
           q_opt = qq;
           M_opt = M;
           P_opt = P;
           pp_opt = pp;
           R_opt = R;
           xj_opt = xj;
           n_opt = n;
           y_opt = y_;
       end
   end
  
end

beta_test = calculateBeta(R_opt, pp_opt, xj_opt, n_opt, m_test, X_test);
y_ = calculateY(P_opt, X_test, beta_test, n_opt, k);

pIndex(y_test, y_)

% figure()
% plot(X_test, y_test)
% title('Desired Model')
% 
% figure()
% plot(X_test, y_)
% title('TS Model');


% M_opt --> final model
% q_opt --> final performance index
% y_test --> desire output
% y_ --> system output 
