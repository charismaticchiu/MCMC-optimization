function [X,Y] = anneal2D(f,initX,initY,maxIter,cooling)
    old_cost = feval(f,initX, initY);
    T0 = 1.0;
    X = initX;
    Y = initY;
    i = 0;
    while i<maxIter
        if strcmp(cooling,'log')
            T = T0/log(1+i);
        elseif strcmp(cooling,'exp')
            T = T0*(0.95^i);
        elseif strcmp(cooling,'poly')
            T = max(0,T0-0.0001*i);
        end
        % range of space: [-500,500]
        newX = min(max(600*rand(1)-300+X,-500),500); 
        newY = min(max(600*rand(1)-300+Y,-500),500);
        
        new_cost = feval(f,newX, newY);
        a = min(1,exp((old_cost-new_cost)/T));
        if a > rand(1) %% accept
            X = newX;
            Y = newY;
            old_cost = new_cost ;
        end
        i = i+1;
    end
end