clear all
%% true probability distribution
true_func1 = @(x,y) exp(5*(abs(x-0.5)+abs(y-0.5))); % x,y in[0,1]x[0,1]
true_func2 = @(x,y) cos(pi + 5*x + 5*y); % x,y in[-1,1]x[-1,1]
true_func3 = @(x,y) abs(4.*x - 2).*abs(4.*y - 2); % x,y in[0,1]x[0,1]
N = 1000; 
%% function 1 Simple MC
est = zeros(50,1);
for k = 1:50
    X = true_func1(rand(1,N),rand(1,N));
    est(k) = mean(X);
end
disp(['func 1 simple MC mu = ',num2str(mean(est)),' var = ',num2str(var(est))])
%% function 1 Stratified Sampling

K = 10; Nij = N/K^2; % Stratified
for k = 1:50
    for i = 1:K
        for j = 1:K
            XS = true_func1([i-1+rand(1,Nij)]/K,[j-1+rand(1,Nij)]/K);
            XSb(i,j) = mean(XS); SS(i,j) = var(XS);
        end
    end, SST = mean(mean(SS/N));
    est(k) = mean(mean(XSb));
end    
disp(['func 1 strat MC mu = ',num2str(mean(est)),' var = ',num2str(var(est))])

%% function 1 importance sampling
proposal = @(x,c) 4*x^3 - 6*x^2 + 3*x - c;
U = rand(1,1000);
for k = 1:50
    X = zeros(1,1000);
    for i = 1:N
        fun = @(x) proposal(x,U(i));
        X(i) = fzero(fun,[0 1]);
        while X(i) > 1 || X(i) < 0
            X(i) = fzero(fun,[0 1]);
        end
    end
    T = exp(5*abs(X-0.5))./(12*((X-0.5).^2));
    est(k) = mean(T)^2;
end
disp(['func 1 importance MC mu = ',num2str(mean(est)),' var = ',num2str(var(est))])
%% func 2 Simple MC
for k = 1:50
    X = true_func2(2*rand(1,N)-1,2*rand(1,N)-1);
    est(k) = mean(X);
end
disp(['func 2 simple MC mu = ',num2str(mean(est)),' var = ',num2str(var(est))])
%% function 2 Stratified Sampling

K = 10; Nij = N/K^2; % Stratified
for k = 1:50
    for i = 1:K
        for j = 1:K
            XS = true_func2((2*(i-1+rand(1,Nij)))/K -1,...
                (2*(j-1+rand(1,Nij)))/K -1);
            XSb(i,j) = mean(XS); SS(i,j) = var(XS);
        end
    end, SST = mean(mean(SS/N));
    est(k) = mean(mean(XSb));

end
disp(['func 2 stra MC mu = ',num2str(mean(est)),' var = ',num2str(var(est))])
%% func 3 Simple MC
for k = 1:50
    X = true_func3(rand(1,N),rand(1,N));
    est(k) = mean(X);
end
disp(['func 3 simple MC mu = ',num2str(mean(est)),' var = ',num2str(var(est))])
%% func 3 Stratified Sampling
K = 10; Nij = N/K^2; % Stratified
for k = 1:50
    for i = 1:K
        for j = 1:K
            XS = true_func3((i-1+rand(1,Nij))/K , (j-1+rand(1,Nij))/K);
            XSb(i,j) = mean(XS); SS(i,j) = var(XS);
        end
    end, SST = mean(mean(SS/N));
    est(k) = mean(mean(XSb));
end
disp(['func 3 stra MC mu = ',num2str(mean(est)),' var = ',num2str(var(est))])
%% func 3  importance sampling
proposal = @(x,c) 4*x^3 - 6*x^2 + 3*x - c;
U = rand(1,1000);
for k = 1:50
    X = zeros(1,1000);
    for i = 1:N
        fun = @(x) proposal(x,U(i));
        X(i) = fzero(fun,[0 1]);
        while X(i) > 1 || X(i) < 0
            X(i) = fzero(fun,[0 1]);
        end
    end
    T = abs(4.*X-2)./(12*((X-0.5).^2));
    est(k) = mean(T)^2;
end   
disp(['func 3 importance MC mu = ',num2str(mean(est)),' var = ',num2str(var(est))])