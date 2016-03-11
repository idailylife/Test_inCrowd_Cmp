function [ ranks ] = get_baseline_rank( cmp_records, q_type, lambda, gen_img_size )
%GET_BASELINE_RANK 得到基准参考结果
%   作品(A)评分=λ*A获胜的次数/A比赛次数 + (1-λ )*A比赛次数/总比赛次数
%           1    2               3          4
% 数据结构  id, 比赛次数,   比赛获胜次数,  能力值
ranks = zeros(gen_img_size, 4);

cmp_length = size(cmp_records, 1);
for i= 1:cmp_length
    cmp = cmp_records(i,:);
    if cmp(6) ~= 0
        continue; % QoE question
    elseif cmp(7) ~= q_type
        continue;
    elseif cmp(8) ~= -1
        continue; % trap question
    end
    
    ranks(cmp(3), 2) = ranks(cmp(3), 2) + 1;
    ranks(cmp(4), 2) = ranks(cmp(4), 2) + 1;
    switch cmp(2)
        case 0
            % B wins (A scores 0)
            ranks(cmp(4), 3) = ranks(cmp(4), 3) + 1;
        case 1
            % A wins
            ranks(cmp(3), 3) = ranks(cmp(3), 3) + 1;
        case 2
            %tie
            ranks(cmp(4), 3) = ranks(cmp(4), 3) + 1;
            ranks(cmp(3), 3) = ranks(cmp(3), 3) + 1;
        otherwise
            warning('Should not be here!!!');
    end
    
end

for i = 1:gen_img_size
    ranks(i, 1) = i;
    ranks(i, 4) = lambda * ranks(i, 3) / ranks(i, 2) ...
            + (1-lambda) * ranks(i, 2) / cmp_length;
end

%Remove NaN
ranks(any(isnan(ranks)'), :) = [];

end

