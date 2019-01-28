function X_ = calculateX(beta, X, n, m, k)
    X_ = [];
    for i = 1:(k+1)
        temp = zeros(m, n);
        for j = 1:m
            temp(j, :) = beta(j, :) * X(j, i);
        end
        X_ = [X_, temp];
    end    
end