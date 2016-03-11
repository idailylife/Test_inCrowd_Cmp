function [ corr_val ] = get_corr( ranking_list, std_answer, type )
%���ݱ�׼�𰸣��������б����׼�𰸵����ϵ��
%   ranking_list: ��ƷID�������б�����/˫�У�������;ʵ���ԣ�
%   type: 0-������; 1-ʵ����
%   std_answer: ר��������TOPXXX������/˫�У�������;ʵ���ԣ�
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

