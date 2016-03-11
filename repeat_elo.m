function [ ranks ] = repeat_elo( F, user_ability_effect, eval_pic, hit_records, cmp_records, num_repeat )
%REPEAT_ELO 循环N多遍的ELO更新
%   Detailed explanation goes here
num_repeat = num_repeat - 1;
[ranks, models] = all_in_one( F, user_ability_effect, eval_pic, hit_records, cmp_records );

while num_repeat > 0
    disp ('======================');
    [ranks, models] = all_in_one( F, user_ability_effect, eval_pic, hit_records, cmp_records, models );
    num_repeat = num_repeat - 1;
end

end

