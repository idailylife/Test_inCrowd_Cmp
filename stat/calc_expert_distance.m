function [ distances ] = calc_expert_distance( hit_records, comparisons, exp_ans_score, q_type )
%计算与专家评价的距离
%   exp_ans_score: 专家打出的标准分
hit_len = length(hit_records);
distances = zeros(hit_len, 1);
for row = 1:hit_len
    hit = hit_records(row, :);
    n = hit{1, 7};%length(comparisons);
    n = n - mod(n, 15);
    disp(['hit_len=', num2str(n)]);
    
    exp_scores = zeros(0, 1);
    worker_scores = zeros(0, 1);
    count = 0;
    
    for i = 1:n
        cmp = get_comparison_data(hit, comparisons, i);
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
        exp_score = exp_ans_score(id_1, id_2);
        if  exp_score == -1
            %专家没有评价过
            continue;
        end
        count = count + 1;
        exp_scores(count, 1) = exp_score;
        worker_scores(count, 1) = S_A;
    end
    if count == 0
        distances(row) = NaN;
    else
        distances(row) = norm(exp_scores - worker_scores);
        distances(row) = distances(row) / count;
    end
end

end

