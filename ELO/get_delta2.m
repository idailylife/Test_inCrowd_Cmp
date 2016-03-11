function [ delta2 ] = get_delta2( F, elo_model, id_A, cmp_records, q_type, eta2 )
%GET_DELTA2 Summary of this function goes here
%   eta: user ability
if nargin < 6
    %warning('get_delta2: No `eta` value input, use 1.0 as default');
    eta2 = 1.0;
end
q2 = (log2(10)/F)^2;

cmp_matrix = get_n_matrix(cmp_records, q_type);
cmp_array = cmp_matrix(id_A,:); % Competitors of A
len = length(cmp_array);
sum = 0;
for id_B = 1:len
    if cmp_array(id_B) == 0
        continue;
    end
    E_A = get_E(elo_model{id_A}.R, elo_model{id_B}.R, elo_model{id_B}.sigma2, F);
    t = cmp_array(id_B) * get_g_sigma2(log(10)/F, elo_model{id_B}.sigma2)^2 * E_A * (1-E_A);
    sum = sum + t;
end
delta2 = 1 / (q2 * sum * eta2);

end

