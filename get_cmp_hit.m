function [ output_cmps ] = get_cmp_hit( hit_record, input_cmps )
%GET_CMP_HIT 从Hit_record提取比较对的ID，找到相应的比较对
%   Detailed explanation goes here
comparison_ids = loadjson(hit_record{1, 8});
cmp_len = int16(hit_record{1,7});
cmp_len = cmp_len - mod(cmp_len, 15); %有些尾数可能有问题需要特殊处理
if cmp_len < 1
    output_cmps = [];
    return;
end
cmp_ids_ary = zeros(cmp_len, 1);
for i=1:cmp_len
    cmp_ids_ary(i) = str2num(comparison_ids{i});
end

min_id = min(cmp_ids_ary);

min_index = find(input_cmps(:,1) == min_id);
if(isempty(min_index))
    warning(['Cannot cmp id=', num2str(min_index)]);
    output_cmps = [];
else
    output_cmps = input_cmps(min_index: min_index+cmp_len-1, :);
end
end

