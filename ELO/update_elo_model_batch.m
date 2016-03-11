function [ output_model, corr_vals ] = update_elo_model_batch( input_model, hit_records, ...
    comparison_records, qoe_data, q_type, F, std_answer, exp_dist, user_abilities)
%This is the batched function of `update_elo`
%   Detailed explanation goes here
% if nargin < 7
%     ability_factor = 1.0;
% end

if nargin < 9
    % Calculate user abilities
    user_abilities = get_user_ability_normalized(hit_records, comparison_records, qoe_data, q_type, 1);
end

if ~isempty(exp_dist)
    ua_bonus = calc_user_ability_bonus(exp_dist, q_type);
    user_abilities = user_abilities + ua_bonus;
end

hit_record_length = size(hit_records, 1);
output_model = input_model;
corr_vals = zeros(0, 1);

for row=1:hit_record_length
    % Iterate throughout all hit records
    hit_record = hit_records(row,:);
%     cmps_hit = get_cmp_hit(hit_record, comparison_records);
%     if isempty(cmps_hit)
%         continue;
%     end
    [output_model, corr_val_new] = update_elo_model(output_model, hit_record, comparison_records, q_type, F, user_abilities(row), std_answer);
    corr_vals = [corr_vals; corr_val_new];
end 

end

