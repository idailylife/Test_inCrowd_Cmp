function [ corr_val ] = get_corr( ranking_list, std_answer, type )
%根据标准答案，计算结果列表与标准答案的相关系数
%   ranking_list: 作品ID的排序列表，单列/双列（创新性;实用性）
%   type: 0-创新性; 1-实用性
%   std_answer: 专家评出的TOPXXX，单列/双列（创新性;实用性）
length = size(ranking_list, 1);
len_std= size(std_answer, 1);
ranking_list = ranking_list(1:len_std);
%ranking_list = ranking_list(1:length);
std_answer = std_answer(:, type+1);

%Jaccard distance
it = intersect(ranking_list, std_answer);
un = union(ranking_list, std_answer);
corr_val = size(it, 1)/size(un, 1);

% corr_mat = zeros(length, 2);
% corr_mat(ranking_list, 1) = 1;
% corr_mat(std_answer, 2) = 1;
% 
% corr_val = corr(corr_mat(:,1), corr_mat(:,2));
% int_ary = (corr_mat(:,1)+corr_mat(:,2)) == 2;
% num_int = sum(int_ary);
% disp([num2str(num_int), '/', num2str(len_std)]);


end

