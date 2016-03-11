function [ J ] = get_expert_judgements( models )
%GET_EXPERT_JUDGEMENTS 把模型内的数据转化为get_expert_similarity的比较数据
%   Detailed explanation goes here
model_len = size(models,1);
J = zeros(0, 2);

row = 1;
for i = 1:model_len
    m = models{i,1};
    if m.sigma2 == 100
        %过滤没有评价过的
        continue;
    end
    J(row, 1) = m.id;
    J(row, 2) = m.R;
    row = row + 1;
end

end

