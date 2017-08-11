function x = mvn(x)
    while -1>= x(1) || x(1) >=1 || 1<= x(2) || x(2) <=-1 
            x = mvnrnd(x,[1 0;0 1]);
    end
    x;
end