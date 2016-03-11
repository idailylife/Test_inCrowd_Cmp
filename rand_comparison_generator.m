function [ hit_record, comparisons ] = rand_comparison_generator( general_pic, user_eval_pic, cmp_quantity, start_cmp_id, hit_id)
%RAND_COMPARISON_GENERATOR Generate random comparison results
%   Including a Hit_record and several random Comparison_records
%   Contains no trap question
%   cmp_quantity must be a multiple of 15 !!!
hit_record = cell(1, 14);
hit_record{1,1} = hit_id; %id
hit_record{1,2} = '*** DEBUG_ONLY ***';
hit_record{1,7} = cmp_quantity;
start_id = start_cmp_id;
tmp_cell = cell(cmp_quantity, 1);
for i = 1: cmp_quantity
    tmp_cell{i, 1} = num2str(start_id + i - 1);
end
%cmp_id_ary = start_id: start_id+cmp_quantity;
%opt.NoRowBracket = 1;
opt.Compact = 1;
text = savejson('', tmp_cell, opt);
text(length(text)) = '';
text(1) = '';
hit_record{1,8} = text;

comparisons = zeros(cmp_quantity, 8);
% Generate comparison records
qoe_rand_ary = [1 1 1 1 0 0 0 0 0 0 0 0 0 0]; % 1-QoE
for i = 1: cmp_quantity
    if mod(i, 15) == 1
        % Randomize the position of QoE question in array
        % Note that the last one is for trap question  
        ix = randperm(14);
        qoe_rand_ary = qoe_rand_ary(ix);
    end
    comparisons(i, 1) = start_id + i - 1;   %id
    comparisons(i, 5) = 500;                %duration
    if mod(i, 15) == 0
        % Trap question
        id_src = i - randi([1, 14]);
        comparisons(i, 2:7) = comparisons(id_src, 2:7);
        comparisons(i, 8) = comparisons(id_src, 1);
        % TODO: 随机更改一小部分陷阱题答案
       
        continue;
    end
    
    
    comparisons(i, 2) = randi([0, 2]);     %answer
    is_qoe = qoe_rand_ary(mod(i, 15));
    comparisons(i, 7) = 1 - (mod(i, 15) < 8);
    if is_qoe == 1
        comparisons(i, 8) = -1;
        comparisons(i, 6) = 1;
        cmp_size = length(user_eval_pic);
        id_indexes = randperm(cmp_size, 2);
        ids = cell2mat(user_eval_pic(id_indexes, 1));
        comparisons(i, 3) = ids(1);
        comparisons(i, 4) = ids(2);
        
    else
        comparisons(i, 8) = -1;
        comparisons(i, 6) = 0;
        cmp_size = length(general_pic);
        id_indexes = randperm(cmp_size, 2);
        ids = cell2mat( general_pic(id_indexes, 1) );
        comparisons(i, 3) = ids(1);
        comparisons(i, 4) = ids(2);
    end
    
    
end


end

