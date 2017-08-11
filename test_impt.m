e = exp(1); X = log(1+U);
T = exp(X.*(X-1));
disp( [mean(T) 2*std(T)/sqrt(N)]) % importance