function [ ua_bonus ] = calc_user_ability_bonus( exp_dist, q_type )
%CALC_USER_ABILITY_BONUS Summary of this function goes here
%   Detailed explanation goes here
len = length(exp_dist);
ua_bonus = zeros(len ,1);
for i = 1:len
    if isnan(exp_dist(i, q_type +1))
        neg_qtype = 2 - q_type;
        if isnan(exp_dist(i, neg_qtype))
            continue;
        else
            ua_bonus(i) = 0.5 * (1 - exp_dist(i, neg_qtype));
        end
    else
        ua_bonus(i) = 1 - exp_dist(i, q_type+1);
    end
end

end

