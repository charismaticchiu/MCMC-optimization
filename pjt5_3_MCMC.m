close all,clear all
schwefel = @(x,y) 418.9829*2 - x.*sin(sqrt(abs(x))) - y.*sin(sqrt(abs(y)));
%% part a) contour setting
x = -500:1:500;
y = -500:1:500;
gridSize = 1000;
u = linspace(-500, 500, gridSize);
[A, B] = meshgrid(u, u);
z = schwefel(A(:),B(:));
z = reshape(z, gridSize, gridSize);
t = 1000;
%% part b)
%exp colling
exp_mins(100,2) = 0;
for k = 1:100
    [exp_mins(k,1), exp_mins(k,2)] = anneal2D(schwefel,0,0,t,'exp');
end
minimum = schwefel(exp_mins(:,1),exp_mins(:,2));
figure,hist(minimum),title(['Exponential Cooling t = ',num2str(t)]),...
    xlabel('function minima'),ylabel('number of occurence')
%figure,hist3(exp_mins,[100, 100]),title('Exponential Cooling')

%% part c)
%poly colling
poly_mins(100,2) = 0;
for k = 1:100
    [poly_mins(k,1), poly_mins(k,2)]= anneal2D(schwefel,0,0,t,'poly');

end
minimum = schwefel(poly_mins(:,1),poly_mins(:,2));
figure,hist(minimum),title(['Polynomial Cooling t = ',num2str(t)]),...
    xlabel('function minima'),ylabel('number of occurence')
%figure,hist3(poly_mins,[100, 100]),title('Polynomial Cooling')

%log colling
log_mins(100,2) = 0;
for k = 1:100
    [log_mins(k,1), log_mins(k,2)]= anneal2D(schwefel,0,0,t,'log');

end
minimum = schwefel(log_mins(:,1),log_mins(:,2));
figure,hist(minimum),title(['Logarithmic Cooling t = ',num2str(t)]),...
    xlabel('function minima'),ylabel('number of occurence')
%figure,hist3(log_mins,[100, 100]),title('Logarithmic Cooling')

%% plot contour
figure, contour(A,B,z),hold on
plot(exp_mins(:,1),exp_mins(:,2),'r.'), 
title('Contour -- Exponential Cooling result overlay, t = 1000, k = 100')
hold off
minimum = schwefel(exp_mins(:,1),exp_mins(:,2));
[a,b] = min(minimum);
exp_mins(b,:)