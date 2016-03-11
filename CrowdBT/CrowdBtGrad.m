function [ grad ] = CrowdBtGrad( func, x, steplen )
%CROWDBTGRAD 此处显示有关此函数的摘要
%   此处显示详细说明
grad = zeros(length(x), 1);
fval = func(x);
gstep = steplen / 1e6;
for i = 1:length(x)
    xi = x;
    xi(i) = x(i) + gstep;   % diff @ ig_
    fval_g = feval(func, xi);
    grad(i) = (fval_g - fval)/gstep;  % (x'-x)/delta_x
end
    
end
