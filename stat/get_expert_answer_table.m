function [ exp_ans_mat ] = get_expert_answer_table( hit_records, cmp_records, q_type, max_id )
%统计专家评价结果 '>''=''<'个数以及标准分数
%   Detailed explanation goes here
if nargin < 4
    max_id = 551;
end

len = length(hit_records);
exp_ans_mat.gt = sparse(max_id, max_id);
exp_ans_mat.eq = sparse(max_id, max_id);
exp_ans_mat.lt = sparse(max_id, max_id);
exp_ans_mat.score = -1 * ones(max_id, max_id); % 未设置值为-1
% id0 < id1 !!!

for line = 1:len
    n = hit_records{line, 7};%length(comparisons);
    n = n - mod(n, 15);
    disp(['hit_len=', num2str(n)]);
    for i = 1:n
        cmp = get_comparison_data(hit_records(line,:), cmp_records, i);
        try
            if cmp(7) ~= q_type
                continue;
            elseif cmp(6) ~= 0
                continue;   % Qoe question
            elseif cmp(8) ~= -1
                continue;   % Trap question
            end
        catch
            warning(['Unrecognized compare record at #', num2str(i)]);
            continue;
        end
        S_A = cmp(2); % 1:A wins, 0:B wins, 2:Tie
        if S_A == 2
            S_A = 0.5;
        end
        id_1 = cmp(3);
        id_2 = cmp(4);
        if id_1 > id_2
            temp = id_2;
            id_2 = id_1;
            id_1 = temp;
            S_A = 1 - S_A;
        end
        
        if S_A == 1
            exp_ans_mat.gt(id_1, id_2) = exp_ans_mat.gt(id_1, id_2) + 1;
        elseif S_A == 0
            exp_ans_mat.lt(id_1, id_2) = exp_ans_mat.lt(id_1, id_2) + 1;
        else
            exp_ans_mat.eq(id_1, id_2) = exp_ans_mat.eq(id_1, id_2) + 1;
        end
        
        score = exp_ans_score(exp_ans_mat.gt(id_1, id_2), ...
            exp_ans_mat.eq(id_1, id_2), exp_ans_mat.lt(id_1, id_2));
        exp_ans_mat.score(id_1, id_2) = score;
        
    end
end

end

