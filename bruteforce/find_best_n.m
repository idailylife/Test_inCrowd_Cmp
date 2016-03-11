function [ best_indices, corr_vals, models] = find_best_n( hits, cmps, std_answer, args, old_model)
%FIND_BEST_N ������õ�N��������(hit��¼)
%   ������user_ability
%   args:�������q_type, F, N����Ҫѡ�ŵĸ���, use_ua�����Ƿ�����û�����ֵ

q_type = args.q_type;
F = args.F;
N = args.N;
use_ability_factor = args.use_ua;
if use_ability_factor == true
    qoe_data = args.qoe_data;
end


if nargin < 5
    models = init_elo_model([], 551);
    best_corr = 0;
else
    % old_model
    models = old_model.models;
    best_corr = old_model.corr(end);
end

best_indices = [];
avail_indices = 1:size(hits, 1);
corr_vals = [];




while (length(best_indices) < N) && ~isempty(avail_indices)
    % ÿ��ѡȡ����corr�������ļ�¼
    best_model = models;
    best_corr_in = best_corr;
    best_id = -1;
    corr_vals_inner = [];
    for index = avail_indices
        hit = hits(index, :);
        curr_model = models;
        
        user_comparisons = get_comparison_data(hit, cmps);
        
        if use_ability_factor == true
            u_a = get_user_ability(hit, user_comparisons, qoe_data, q_type);
        else
            u_a = 1.0;
        end
        
        [curr_model, corr_vals_inner] = update_elo_model(curr_model, hit, user_comparisons, q_type, ...
            F, u_a, std_answer);
        if length(corr_vals_inner) <= 0
            avail_indices(index) = [];
            continue;
        end
        corr_vals_inner = corr_vals_inner(end);
        if corr_vals_inner >= best_corr_in
            best_corr_in = corr_vals_inner;
            best_model = curr_model;
            best_id = index;
        end
    end
    %���Ԫ�ؼ���
    fprintf('\n');
    disp(['Selected best index=', num2str(best_id), ', corr=', num2str(best_corr_in)]);
    best_indices = [best_indices; best_id];
    locate = (avail_indices == best_id);
    avail_indices(locate)  = [];
    corr_vals = [corr_vals, best_corr_in];
    models = best_model;
end

end

