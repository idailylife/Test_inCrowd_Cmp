function [ rank, models ] = expert_leaded_ranking( hits, cmps, args )
%EXPERT_LEADED_RANKING Performs expert-leaded ranking
% args.
%   method: 'bf' bruteforce
%         : 'gold' gold_std
%   F: Elo arg
%   N: number of potential experts to select
%   std_ans: ['bf' only] pre-judged good images
%   evalpic: gold-standard images
%   q_type: 0 or 1
%   Th: worker-exp similarity 'tie' threshold
%   u_a_stage2: use user ability in 2nd stage (not expert leading)
%   th_change: threshold of `change`
args.use_ua = false;
if isfield(args, 'u_a_stage2') == 0
    args.u_a_stage2 = 1;    % Default
end

if isfield(args, 'th_change') == 0
    args.th_change = 100;
end

[best_indices, ~, models] = find_best_n(hits, cmps, args.std_ans, args);
hit_indices = (1:size(hits,1))';
nonexp_indices = ~ismember(hit_indices, best_indices);
hits_nonexp = hits(nonexp_indices, :);
exp_judgements = get_expert_judgements(models);

change = realmax;
r = zeros(size(models, 1), 1);

while change > args.th_change
    for i = 1: size(hits_nonexp)
        hit = hits_nonexp(i, :);
        user_comparisons = get_comparison_data(hit, cmps);
        %u_a = get_user_ability(hit, user_comparisons, args.evalpic, args.q_type);
        if args.u_a_stage2 == 1
            worker_j = get_worker_judgements(user_comparisons);
            u_a = get_expert_similarity(exp_judgements, worker_j, args.Th);
        else
            u_a = 1;
        end
        
        [models, ~] = update_elo_model(models, hit, user_comparisons, ...
            args.q_type, args.F, u_a, args.std_ans);
    end
    new_r = model_to_r(models);
    change = norm(new_r - r);
    disp(['change=',num2str(change)]);
    r = new_r;
end
[~, rank] = generate_elo_rank(models);
end

