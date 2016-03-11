function [ ranks, models, corr_vals ] = all_in_one( F, eval_pic, hit_records, ...
    cmp_records, old_models, std_answers, exp_dist, no_user_abilities)
%ALL_IN_ONE 执行整个流程，只输出结果
%   Detailed explanation goes here
if nargin < 8
    no_user_abilities = 0;
end

ranks = cell(1, 2);
models = cell(1, 2);
corr_vals = cell(1, 2);

if no_user_abilities == 1
    hit_len = length(hit_records);
    user_abilities = ones(hit_len, 1);
end

for qtype = 0:1
    if ~isnan(old_models)
        elo_model = old_models{1,qtype+1};
    else
        elo_model = init_elo_model([], 551);
    end
    if no_user_abilities == 1
        [models{1, qtype+1}, corr_vals{1, qtype+1}] = update_elo_model_batch(elo_model, hit_records, cmp_records, ...
            eval_pic, qtype, F, std_answers, exp_dist, user_abilities);
    else
        [models{1, qtype+1}, corr_vals{1, qtype+1}] = update_elo_model_batch(elo_model, hit_records, cmp_records, ...
            eval_pic, qtype, F, std_answers, exp_dist);
    end
    [~, ranks{1, qtype+1}] = generate_elo_rank(models{1, qtype+1});
end

end

