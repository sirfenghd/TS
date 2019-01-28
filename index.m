function idx = index(p, pp, X, P, y, R, xj, n, m, k, i, nmf)
   p_ = cell(1, length(pp)); 
   for i = 1:length(pp)
       p_{i} = reshape(p(1:nmf(i)*3), nmf(i), 3);
       p = p(nmf(i)*3+1:end);
   end
   beta = calculateBeta(R, p_, xj, n, m, X);
   y_ = calculateY(P, X, beta, n, k);
   idx = pIndex(y, y_);
end