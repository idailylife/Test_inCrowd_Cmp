function [ updated_model, corr_vals ] = update_elo_model( input_model, hit_record, comparison_records, q_type, F, user_ability, std_answer )
% Update parameters of 'input_model' and export with the 'updated_model'
% This function does NOT do the iteration job throughout all the hit_records!
%   input_model: older model
%   hit_record: single-lined hit_record
%   comparison_records:
%   q_type : question type 创新性/实用性
%   F (constant in mu-ELO model)
%   user_ability
%   std_answer

% corr_vals: 每一条评价记录更新一次corr信息

% if nargin < 7
%     user_ability_effect = 1.0;
% end

updated_model = input_model;

%get_user_ability(hit_record, comparison_records, qoe_data, q_type);
% NEED TO BE TUNED!!!!
%user_ability = user_ability_effect * user_ability + (1 - user_ability_effect);

% Loop through comparisons in hit_record
% comparisons = loadjson(hit_record{1,8})';
n = hit_record{1, 7};%length(comparisons);
n = n - mod(n, 15);
%disp(['hit_len=', num2str(n)]);
fprintf('~');

corr_vals = zeros(0, 1);
cmp_size = size(comparison_records, 1);

if cmp_size == n
    cmps = comparison_records;
else
    cmps = get_comparison_data(hit_record, comparison_records);
end

if n > cmp_size
    n = cmp_size;
end

for i=1:n
    % Gather the data of the comparison %  
    %cmp = get_comparison_data(hit_record, comparison_records, i);
    cmp = cmps(i, :);
    try
        if cmp(7) ~= q_type
            continue;
        elseif cmp(6) ~= 0
            continue;   % Qoe question
        elseif cmp(8) ~= -1
            continue;   % Trap question
        end
    catch
        warning(['Unrecognized compare record at #', num2str(i)]);
        continue;
    end
    
    S_A = cmp(2); % 1:A wins, 0:B wins, 2:Tie
    if S_A == 2
        S_A = 0.5;
    end
    
    % Map id to unique id
    id_1 = cmp(3);
    id_2 = cmp(4);
    
    model_A = updated_model{id_1}; % model A
    model_B = updated_model{id_2}; % model B 
    q = log(10)/F;
    
    % Update parameters of model A
    g_sigma2_B = get_g_sigma2(q, model_B.sigma2);
    E_A = get_E(model_A.R, model_B.R, model_B.sigma2, F);
    delta2_A = get_delta2(F, updated_model, model_A.id, comparison_records, q_type, 1);
    K_A = q / ( 1 / model_A.sigma2 + 1 / delta2_A );
    R = model_A.R + user_ability * K_A * g_sigma2_B * ( S_A - E_A ); %;model_A.R + K_A * g_sigma2_B * ( S_A - E_A )
    s2 = 1 / ( 1 / model_A.sigma2 + 1 / delta2_A ) ;
    updated_model{id_1}.R = R; % Update R of model A
    updated_model{id_1}.sigma2 = s2;  % Update sigma^2 of model A
        
    % Update parameters of model B
    S_B = 1 - S_A;
    g_sigma2_A = get_g_sigma2(q, model_A.sigma2);
    E_B = get_E(model_B.R, model_A.R, model_A.sigma2, F);
    delta2_B = get_delta2(F, updated_model, model_B.id, comparison_records, q_type, 1);
    K_B = q / ( 1 / model_B.sigma2 + 1 / delta2_B );
    R = model_B.R + user_ability * K_B * g_sigma2_A * ( S_B - E_B ); % model_B.R + K_B * g_sigma2_A * ( S_B - E_B);
    s2 = 1 / ( 1 / model_B.sigma2 + 1 / delta2_B );
    updated_model{id_2}.R = R;
    updated_model{id_2}.sigma2 = s2;
    
    ranking = get_ranking_by_rating(updated_model);
    corr_vals = [corr_vals; get_corr(ranking, std_answer, q_type)];
end



end

