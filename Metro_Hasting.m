% BLOCK-WISE SAMPLER (BIVARIATE NORMAL)
rand('seed' ,12345);
close all, clear 
D = 2; % # VARIABLES
% True distribution
true_func =  @(x) cos(pi + 5*x(1) + 5*x(2));
% TARGET DISTRIBUTION 
p  = @(x) abs(cos(pi + 5*x(1) + 5*x(2))); % x,y in[-1,1]x[-1,1]
% PROPOSAL DISTRIBUTION STANDARD 2D GUASSIAN
q = inline('mvnpdf(x,mu)','x','mu');
nSamples = 1000;
minn = -1;  maxx = 1;
for k=1:50
% INITIALIZE BLOCK-WISE SAMPLER
    t = 1;
    x = zeros(nSamples,2);
    x(1,:) = rand(1,2);
    % RUN SAMPLER
    while t < nSamples
        t = t + 1;
        % SAMPLE FROM PROPOSAL
        xStar = mvnrnd(x(t-1,:),eye(D));
        % SAMPLE MUST be within boundary
        while minn>= xStar(1) || xStar(1) >=maxx ||...
                maxx<= xStar(2) || xStar(2) <=minn 
            xStar = mvnrnd(x(t-1,:),eye(D));
        end
        % CORRECTION FACTOR (SHOULD EQUAL 1)
        c = q(x(t-1,:),xStar)/q(xStar,x(t-1,:));
        % CALCULATE THE M-H ACCEPTANCE PROBABILITY
        alpha = min([1, p(xStar)*c/p(x(t-1,:))]);
        % ACCEPT OR REJECT?
        u = rand;
        if u < alpha
            x(t,:) = xStar;
        else
            x(t,:) = x(t-1,:);
        end
    end
    val = zeros(1000,1);
    for i=1:1000
        val(i) = true_func(x(i,:));
    end
    est(k) = mean(val);
end
% DISPLAY
disp(['func 2 Metropolis_Hastings mu = ',num2str(mean(est)),' var = ',num2str(var(est))])
figure,hist3(x, [100,100]);
xlabel('x_1'); ylabel('x_2'); zlabel('Frequency'),title('Sampled Distribution');
