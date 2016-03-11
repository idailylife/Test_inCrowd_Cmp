function [  rank_table, elo_rank ] = generate_elo_rank( elo_model )%, res_general_pic )
%GENERATE_ELO_RANK Generate elo rank from elo model
% Data format: [ID, Rank, Sigma2]

elo_rank = zeros(0, 4);
tmp_cell_ary = cell(0, 1);
m_length = length(elo_model);
count = 1;
for i = 1:m_length
    if isempty(elo_model{i})
        continue;
    elseif (elo_model{i}.sigma2 == 100) && (elo_model{i}.R == 100)
        disp(['dismissed id = ', num2str(i)]);
        continue;
    end
    m = elo_model{i};
    elo_rank(count, 1) = m.id;
    elo_rank(count, 2) = m.R;
    elo_rank(count, 3) = m.sigma2;
%     img_index = find(cell2mat(res_general_pic(:,1)) == m.id);
%     temp_cell_ary{count, 1} = res_general_pic{img_index, 2};
    
    count = count + 1;
end

var_names = {'id', 'R', 'sigma2'}; %, 'resource'};
rank_table = table(elo_rank(:,1), elo_rank(:,2), elo_rank(:,3) ...%temp_cell_ary...
     ,'VariableNames', var_names);

end

