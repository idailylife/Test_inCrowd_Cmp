function [ Sk ] = GenerateSkFromHit( hit_records, cmps, q_type )
%Generate Sk from HIT and comparison records
%Sk is used for CrowdBT.m
worker_len = size(hit_records, 1);
Sk = cell(worker_len, 1);

for k = 1:worker_len
    
    hit = hit_records(k, :);
    user_comparisons = get_comparison_data(hit, cmps);
    cmp_size = size(user_comparisons, 1);
    Sk{k} = zeros(0, 2);
    for row = 1:cmp_size
        cmp = cmps(row, :);
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
        if S_A == 1
            Sk{k}(end+1, 1) = cmp(3);
            Sk{k}(end, 2) = cmp(4);
        elseif S_A == 0
            Sk{k}(end+1, 1) = cmp(4);
            Sk{k}(end, 2) = cmp(3);
        end
    end
end

end

