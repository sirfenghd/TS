function pp_ = optimizePP(pp, xj, nmf, X, P, y, R, n, m, k)
    
    pp_ = cell(1, length(pp));
    options = optimset('MaxIter', 400);
    
    init = [];
    
    for i = 1:length(pp)
        init = [init, reshape(pp{i}, 1, numel(pp{i}))];
    end
        temp = fmincon(@(p)(index(p, pp, X, P, y, R, xj, n, m, k, i, nmf)), init, [], [], [], [], [], [], [],options);
    for i = 1:length(pp)
       pp_{i} = reshape(temp(1:nmf(i)*3), nmf(i), 3);
       temp = temp(nmf(i)*3+1:end);
    end
     
end