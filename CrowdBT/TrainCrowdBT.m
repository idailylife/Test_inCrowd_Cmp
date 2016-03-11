function [ Eta, S ] = TrainCrowdBT( hits, cmps, opt )
%TRAINCROWDBT Train CrowdBT parameters using (LM)BFGS
%opt: 
%   .use_worker_q: 1 - Use worker quality to initialize Eta
%   .exp_judgments  Expert judgments to estimate worker quality
%   .q_type
%   .lambda
%   [ABOLISHED].optimize_opt: options for BFGS (see fminlbfgs.m)
%   .Th_S: Threshold for iteration S(n) - S(n-1)  (norm)
%   .Th_Eta: Threshold for Eta(n) - Eta(n-1)      (norm)
item_size = max(cmps(:,4));
S = zeros(item_size, 1);

size_hit = size(hits, 1);
Eta = ones(size_hit, 1);

if opt.use_worker_q == 1
    for i = 1:size(hits, 1)
        user_comp = get_comparison_data(hits(i,:), cmps);
        wj = get_worker_judgements(user_comp);
        Eta(i) = get_expert_similarity(opt.exp_judgments, wj, 0.01);
    end
end

Sk = GenerateSkFromHit(hits, cmps, opt.q_type);
delta_S = realmax;
delta_Eta = realmax;
opts_model = struct('maxIts', 400, 'm', 20, 'pgtol', 1e-7, ...
    'maxTotalIts', 10000, 'factr', 1e2);

while delta_S > opt.Th_S && delta_Eta > opt.Th_Eta
    %% Fix Eta, optimize S
    fh_S = @(x)-CrowdBT(Eta, x, Sk, opt.lambda);
    fh_SG = @(x)CrowdBtGrad(fh_S, x, 1);
    fh_ = @(x)fminunc_wrapper(x, fh_S, fh_SG);
    %S_new = fminlbfgs(fh_S, S, opt.optimize_opt);
    opts = opts_model;
    opts.x0 = S;
    S_new = lbfgsb(fh_, -Inf(item_size,1), Inf(item_size,1), opts);
    %S_new = S;
    %% Fix S, optimize Eta
    fh_Eta = @(x)-CrowdBT(x, S_new, Sk, opt.lambda);
    fh_EtaG = @(x)CrowdBtGrad(fh_Eta, x, 1);
    fh = @(x)fminunc_wrapper(x, fh_Eta, fh_EtaG);
    %Eta_new = fminlbfgs(fh_Eta, Eta, opt.optimize_opt);
    %opts = struct('maxIts',400, 'x0', Eta);
    opts = opts_model;
    opts.x0 = Eta;
    Eta_new = lbfgsb(fh, zeros(size_hit,1), ones(size_hit,1), opts);
    %% Update Result
    delta_S = norm(S_new - S);
    delta_Eta = norm(Eta_new - Eta);
    S = S_new;
    Eta= Eta_new;
end

end

