function P = KalmanFilter(X, y)
    I = pinv(X' * X);
    P =  I * X' * y;
end