function y_ = calculateY(P, X, beta, n, k)
    P = reshape(P, n, k+1);
    y_ = sum((X * P') .* beta, 2);
end