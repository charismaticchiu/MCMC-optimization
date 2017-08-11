function [X,Y] = anneal2Dpath(f,initX,initY,maxIter,cooling)
    old_cost = feval(f,initX, initY);
    T0 = 1.0;
    i = 1;
    X = zeros(1,maxIter);
    Y = zeros(1,maxIter);
    X(i) = initX;
    Y(i) = initY;
    while i<maxIter
        if strcmp(cooling,'log')
            T = T0/log(1+i);
        elseif strcmp(cooling,'exp')
            T = T0*(0.95^i);
        elseif strcmp(cooling,'poly')
            T = max(0,T0-0.0001*i);
        end
        
        newX = min(max(600*rand(1)-300+X(i),-500),500); % range of space: [-500,500]
        newY = min(max(600*rand(1)-300+Y(i),-500),500);
        i = i+1;
        new_cost = feval(f,newX, newY);
        a = min(1,exp((old_cost-new_cost)/T));
        if a > rand(1) %% accept
            X(i) = newX;
            Y(i) = newY;
            old_cost = new_cost ;
        else 
            X(i) = X(i-1);
            Y(i) = Y(i-1);
        end
        
    end
end