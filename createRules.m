function R = createRules(nmf, n)
    R = 1:nmf(1);
    
    if(length(nmf) > 1)
        for i = 2:length(nmf)
            [B1, B2] = repeat2combine(2, R, 1:nmf(i));
            R = cat(1, B1, B2);
        end
    end
            
end