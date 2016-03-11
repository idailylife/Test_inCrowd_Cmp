function [ user_abilities_Norm ] = get_user_ability_normalized( hit_records, comparison_records, qoe_data, q_type, do_not_norm )
%GET_USER_ABILITY_2 Get normoalized user abilities
%   May need large quantity of records to work
if nargin < 5
    do_not_norm = 1;
end

record_length = size(hit_records, 1);
user_abilities = zeros(record_length, 1);
user_abilities_Norm = zeros(record_length, 1);
for row = 1:record_length
    hit_record = hit_records(row,:);
    user_ability = get_user_ability(hit_record, comparison_records, qoe_data, true);
    user_abilities(row) = user_ability;
end

if do_not_norm == 1
    user_abilities_Norm = user_abilities;
else
    [mu, sigma] = normfit(user_abilities);
    disp([num2str(mu), ',', num2str(sigma)]);
    for row = 1:record_length
        user_abilities_Norm(row) = normcdf(user_abilities(row), mu, sigma);
        disp(['user_ability_norm=', num2str(user_abilities_Norm(row))]);
    end
end

end

