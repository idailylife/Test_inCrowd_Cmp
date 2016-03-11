function [ prec_recall_mat, MAP ] = get_prec_recall( ranking, std_answers )
%GET_PREC_RECALL 根据排序表和标准答案表，计算precision/recall矩阵
%   [precision, recall]
%   MAP: Mean Average Precision
len = length(std_answers);
len_ranking = length(ranking);
prec_recall_mat = zeros(len_ranking, 2);

count_std = 0;
sum_precision = 0;
for i = 1:len_ranking
    if ismember(ranking(i,1), std_answers) == 1
        %Relevane document retrieved
        count_std = count_std + 1;
        sum_precision = sum_precision + count_std / i;
    end
    recall = count_std / len;
    precision = count_std / i;
    prec_recall_mat(i, :) = [precision, recall];
end

MAP = sum_precision / count_std;

end

