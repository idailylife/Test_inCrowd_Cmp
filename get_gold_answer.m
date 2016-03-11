function [ answer ] = get_gold_answer( comparison_record, qoe_img_data )
%GET_GOLD_ANSWER Get ground truth of QoE comparison
%   comparison_rerord: one row of comparison_record
%   qoe_img_data: dataset of QoE images
img_id_A = comparison_record(3);
img_A_index = find(cell2mat(qoe_img_data(:, 1)) == img_id_A);
img_A_category = qoe_img_data{img_A_index, 2};
switch strcmp(img_A_category, 'IN')
    case 1
        % A is better
        answer = 1;
    case 0
        % B is better
        answer = 0;
    otherwise
        warning('get_gold_answer->Unrecognized category type');
        answer = -1;
end

end

