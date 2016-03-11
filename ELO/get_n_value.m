function [ n_B ] = get_n_value( cmp_records, B_id, q_type, cmp_matrix )
%GET_N_VALUE Summary of this function goes here
%   Detailed explanation goes here
if nargin < 4
    cmp_matrix = get_n_matrix(cmp_records, q_type);
end
n_B = sum(cmp_matrix(B_id,:));

end

