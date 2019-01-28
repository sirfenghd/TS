function q = pIndex(y, y_)
    q = sum((y - y_).^2)/length(y);
end