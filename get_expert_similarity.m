function [ simi ] = get_expert_similarity( R, J, Th )
%GET_EXPERT_SIMILARITY 计算某个参与者与专家团决策的相似度
%   R: 专家评分矩阵，每一行对应项为(id, r_id)
%   J: 参与者评价矩阵，每一行对应项为(id0, id1, j)，
%       其中j=1表示id0>id1，
%       j=-1表示id1=id0，j=0表示打平 (注意与cmp数据的区别！)
%   Th: 取等号的阈值（>=0)

    function [ rate ] = get_exp_rate(R, id)
        rate = find(R(:,1) == id);
    end

    function [ sgn ] = get_sgn(rx, ry, Th)
        if rx - ry > Th
            sgn = 1;
        elseif rx-ry < -Th
            sgn = -1;
        else
            sgn = 0;
        end
    end

dist = 0;
count = 0;
for row = 1:size(J, 1)
    rate0 = get_exp_rate(R, J(row, 1));
    rate1 = get_exp_rate(R, J(row, 2));
    if isempty(rate0) || isempty(rate1)
        continue;
    end
    sgn = get_sgn(rate0, rate1, Th);
    dist = dist + abs(sgn - J(row, 3));
    count = count + 2; % 1/2N ...
end

if count > 0
    simi = 1 - dist / count;
else
    simi = 0.3; %TBD
end

end

