function beta = calculateBeta(R, pp, xj, n, m, X)

    belief = zeros(1, length(xj));
    beta = zeros(m, n);

    for j = 1:m
        for i = 1:n
            for k = 1:length(xj)
                belief(k) = calculateBelief(X(j, xj(k)+1), pp{k}(R(k, i), :));
            end
            
            beta(j, i) = min(belief);
        end
        
        if (sum(beta(j, :)) ~= 0)     
            beta(j, :) = beta(j, :)/sum(beta(j, :));
        end
    end

end