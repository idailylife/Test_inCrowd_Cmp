function [ user_ability ] = get_user_ability( hit_record, comparison_records, qoe_data, use_wilson )
%function [ user_ability ] = get_user_ability( hit_record, comparison_records, qoe_data, q_type )
%GET_USER_ABILITY Calculate user ability of an single hit_record
%目前考虑的只有回答题目的正确率以及陷阱题的错误率
%   hit_record
%   comparison_records
%   qoe_data
%   [DEPRECATED] q_type: creativity(0) of usability(1)
%   use_wilson: 使用或不用威尔逊评分
if nargin < 4
    use_wilson = false;
end

% Count the number of questions answered
%disp(['====> hit_id=', num2str(hit_record{1,1})]);
n_of_answers = int16(hit_record{1,7});
n_of_answers = n_of_answers - mod(n_of_answers, 15); %有些尾数可能有问题需要特殊处理
%disp(['n of comparison = ', num2str(n_of_answers)]);
if n_of_answers < 1
    user_ability = 0;
    return
end

% Iterate throughout all QoE comparisons
eval_total_count = 0; % Number of QoE quesitons
eval_correct_count = 0; % Number of correct answers
eval_trap_correct = 0; % Number of correct trap questions
eval_trap_total = 0; % Number of trap questions
for i=1:n_of_answers
    if mod(i, 15) == 1 && i>1
        % 检测用户是否应该被踢出去
        user_ability = eval_correct_count / eval_total_count;
        trap_ratio = eval_trap_correct/eval_trap_total;
        if trap_ratio < 0.6
            cprintf('Keywords', ['LQ HIT #1@lv', num2str(fix(i/15)), '\n']);
        elseif user_ability < 0.5
            cprintf('Keywords', ['LQ HIT #2@lv', num2str(fix(i/15)), '\n']);
        end
    end
    
    if size(comparison_records, 1) == n_of_answers
        cmp_record = comparison_records(i,:);
    else
        cmp_record = get_comparison_data(hit_record, comparison_records, i);
    end
    
    try
        
        if cmp_record(8) ~= -1
            % Trap quesion
            eval_trap_total = eval_trap_total + 1;
            orig_cmp_id = cmp_record(8);
            orig_cmp = get_comparison_by_id(comparison_records, orig_cmp_id);
            if orig_cmp(2) == cmp_record(2)
                eval_trap_correct = eval_trap_correct + 1;
            else
                disp(['Wrong trap answer, cmp_id=', num2str(cmp_record(1))]);
            end
            continue;
        end
%         if cmp_record(7) ~= q_type
%             continue; % Not the same q_type
        if cmp_record(6) ~= 1
            continue; % Not a QoE question
        end
    catch
        warning(['Unrecognized compare record at #', num2str(i)]);
        continue;
    end
    % Get ground truth
    ground_truth = get_gold_answer(cmp_record, qoe_data);
    user_answer = cmp_record(1, 2);
    if user_answer == ground_truth
        eval_correct_count = eval_correct_count + 1;
    end
    eval_total_count = eval_total_count + 1;
    
    
    
end

if eval_total_count == 0
    user_ability = 0.599;
else
    if use_wilson == true
        user_ability = get_wilson_centre(eval_correct_count, eval_total_count);
    else
        user_ability = eval_correct_count / eval_total_count;
    end
    
%     trap_ratio = eval_trap_correct/eval_trap_total;
%     if  trap_ratio < 0.6
%         user_ability = 0.3;
%         %disp(['Low quality user detected.', num2str(trap_ratio)]);
%     end
%      
%     if user_ability > 0.7
%         user_ability = 1.0;
%     elseif user_ability > 0.6
%         user_ability = 0.9;
%     elseif user_ability > 0.5
%         user_ability = 0.75;
%     else
%         user_ability = 0.5;
%     end

end

%disp(['user_ability=', num2str(user_ability), ' total=', num2str(eval_total_count)]);

end

