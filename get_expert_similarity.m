function [ simi ] = get_expert_similarity( R, J, Th )
%GET_EXPERT_SIMILARITY ����ĳ����������ר���ž��ߵ����ƶ�
%   R: ר�����־���ÿһ�ж�Ӧ��Ϊ(id, r_id)
%   J: ���������۾���ÿһ�ж�Ӧ��Ϊ(id0, id1, j)��
%       ����j=1��ʾid0>id1��
%       j=-1��ʾid1=id0��j=0��ʾ��ƽ (ע����cmp���ݵ�����)
%   Th: ȡ�Ⱥŵ���ֵ��>=0)

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

