function [ wilson_centre ] = get_wilson_centre( correct_count, total_count, z )
%����ѷ����������м�ֵ
%   Detailed explanation goes here
if nargin < 3
    z = 1.96;
end

p = correct_count / total_count;
wilson_centre = (p + z*z/(2*total_count))/(1 + z*z/total_count);


end

