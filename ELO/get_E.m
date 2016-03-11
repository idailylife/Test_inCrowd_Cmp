function [ E ] = get_E( R_A, R_B, sigma2_B, F )
%GET_E Summary of this function goes here
%   Detailed explanation goes here
tmp = - get_g_sigma2(log2(10)/F, sigma2_B) * (R_B - R_A)/F;
E = 1 / ( 1 + 10^tmp);

end

