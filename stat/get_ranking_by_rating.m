function [ ranking ] = get_ranking_by_rating( model_cellmat )
%���������ID,Rֵ�������ID���򣨴Ӹߵ��ͣ�
%   model_cellmat �洢ģ�Ͳ�����cell����model{id}: .R   .s2
%   rating_mat:  ID;R;(SIGMA)

%����rating����
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

