close all, clear all
%% part a
piEstimate(50) = 0;
n = 100; % number of Monte Carlo samples
for i=1:50
    
    x = rand(n, 1); % sample the input random variable x
    y = rand(n, 1); % sample the input random variable y
    isInside = (x.^2 + y.^2 < 1); % is the point inside a unit circle?
    percentage = sum(isInside) / n; % compute statistics: the inside percentage
    piEstimate(i) = percentage * 4;
end
hist(piEstimate)
mu = mean(piEstimate);
title('Histogram of MC estimation of \pi, sample size n = 100')
%title('Histogram of MC estimation of \pi, sample size n = 100, \mu_estimate = %f',mu)
xlabel('Estimates'),ylabel('times')
sig100 = var(piEstimate);

%% part b

piEstimate(50) = 0;
n = 1000; % number of Monte Carlo samples
for i=1:50
    
    x = rand(n, 1); % sample the input random variable x
    y = rand(n, 1); % sample the input random variable y
    isInside = (x.^2 + y.^2 < 1); % is the point inside a unit circle?
    percentage = sum(isInside) / n; % compute statistics: the inside percentage
    piEstimate(i) = percentage * 4;
end
figure
hist(piEstimate)
title('Histogram of MC estimation of \pi, sample size n = 1000')
xlabel('Estimates'),ylabel('times')
mean(piEstimate)
sig1000 = var(piEstimate);

piEstimate(50) = 0;
n = 10000; % number of Monte Carlo samples
for i=1:50
    
    x = rand(n, 1); % sample the input random variable x
    y = rand(n, 1); % sample the input random variable y
    isInside = (x.^2 + y.^2 < 1); % is the point inside a unit circle?
    percentage = sum(isInside) / n; % compute statistics: the inside percentage
    piEstimate(i) = percentage * 4;
end
figure
hist(piEstimate)
title('Histogram of MC estimation of \pi, sample size n = 10000')
xlabel('Estimates'),ylabel('times')
mean(piEstimate)
sig10000 = var(piEstimate);

figure,loglog([100,1000,10000],[sig100,sig1000,sig10000])
xlabel('number of sample'),ylabel('variance')
%% part c
aEstimate(50) = 0;
n = 100; % number of Monte Carlo samples
sampleArea = 1*1*4;
for i=1:50
    
    x = rand(n, 1); % sample the input random variable x
    y = rand(n, 1); % sample the input random variable y
    z = 4*rand(n, 1); % sample the input random variable z
    isInside = (z < abs(4 .* x - 2) .* abs(4 .* y - 2));
    aEstimate(i) = sum(isInside)* sampleArea / n;
end
figure
hist(aEstimate)
mean(aEstimate)
var(aEstimate)