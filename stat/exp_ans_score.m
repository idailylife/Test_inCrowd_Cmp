function [ score ] = exp_ans_score( gt_cnt, eq_cnt, lt_cnt )
%计算专家评价的标准分
%  [0,...,0.5,...,1] = [lt,...,eq,...,gt]
sum = gt_cnt + 0.5 * eq_cnt;
score = sum / (gt_cnt + eq_cnt + lt_cnt);

end

