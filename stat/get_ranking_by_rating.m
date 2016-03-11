function [ ranking ] = get_ranking_by_rating( model_cellmat )
%根据输入的ID,R值矩阵计算ID排序（从高到低）
%   model_cellmat 存储模型参数的cell矩阵。model{id}: .R   .s2
%   rating_mat:  ID;R;(SIGMA)

%生成rating矩阵
len = length(model_cellmat);
rating_mat = zeros(len, 2);
for i = 1:len
    rating_mat(i, 1) = i;
    rating_mat(i, 2) = model_cellmat{i}.R;
end

[~, ind] = sort(rating_mat(:,2), 'descend');
ranking(:,1) = 1:len;
ranking(:,2) = rating_mat(ind, 1);

end

