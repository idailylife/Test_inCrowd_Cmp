function [ g_sigma2 ] = get_g_sigma2( q, sigma2 )
%GET_SIGMA2 Summary of this function goes here
%   Detailed explanation goes here
g_sigma2 = 1 / sqrt(1 + 3 * q^2 * sigma2 / pi^2);

end

