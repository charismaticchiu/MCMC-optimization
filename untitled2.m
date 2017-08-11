rng default  % For reproducibility

pdf = @(x) abs(cos(pi + 5*x(1) + 5*x(2))); % x,y in[-1,1]x[-1,1]
proppdf = @(x,mu) mvnpdf(x,mu);
proprnd = @(x) mvn(x);
nsamples = 1000;
x = mhsample([0 0],nsamples,'pdf',pdf,'proppdf',proppdf ,'proprnd',proprnd);


