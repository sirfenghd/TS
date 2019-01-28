function [pp, nmf, xj] = initializePP(X, M, k)
        
    q = 1;

    for i = 1:k
       
        h = sum(M == i);
        
        if (h ~= 0)
            
            temp = zeros(2^h, 3);
            l = (max(X(:, i+1)) - min(X(:, i+1)))/(2^h + 1);
            
           	for j = 1:2^h
                temp(j, :) = [min(X(:, i+1)) + (j-1)*l, min(X(:, i+1)) + j*l,  min(X(:, i+1)) + (j+1)*l];
            end
            
            pp{q} = temp;
            nmf(q) = size(temp, 1);
            xj(q) = i;
            q = q + 1;
        end
    end
end