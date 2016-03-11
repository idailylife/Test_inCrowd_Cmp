%统计专业参与者与非专业参与者完成题目的比例
%以及这些人中被强制清出去的比例
% -------------------------------------------------------------------
%  Lvl.  |  Count  |  Eliminated Count | eta_sum_cre |  eta_sum_usa |
% -------------------------------------------------------------------

function [stat_result] = get_stop_ratio(hit_records, comparisons, evalpic, threshold)
    stat_result = zeros(14, 5); % row1-7:non-pro; row8-14:pro
    stat_result(1:7, 1) = [1:7]';
    stat_result(8:14, 1) = [1:7]';
    for row = 1: size(hit_records, 1)
        record = hit_records(row,:);
        level = fix(record{7}/15);
        if level == 0
            continue;
        end
        if record{5} == 1
            level = level + 7;
        end
        stat_result(level, 2) = stat_result(level, 2) + 1;
        user_ability_c = get_user_ability(record, comparisons, evalpic, 0);
        stat_result(level, 4) = stat_result(level, 4) + user_ability_c;
        user_ability_u = get_user_ability(record, comparisons, evalpic, 1);
        stat_result(level, 5) = stat_result(level, 5) + user_ability_u;
        user_ability = (user_ability_c + user_ability_u)/2;
        disp(['id=', num2str(record{1}), ',ua=', num2str(user_ability)]);
        if user_ability < threshold
            stat_result(level, 3) = stat_result(level, 3) + 1;
        end
        
    end
end