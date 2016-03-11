 function [ comparison_result ] = get_comparison_data( hit_record, comparison_records, cmp_index )
%Extract comparison data from one SINGLE-LINED hit_record
%   hit_record: single hit_record
%   comparioson_records: matrix of the whole comparison_records
%   cmp_index: index of comparison in the hit_record (not the id)\

cmp_array_json = hit_record{1, 8};  %JSON array of comparisons of the HIT record
cmp_array = loadjson(cmp_array_json);

%Find index in cmp_array (not in matlab metrix)
%disp(num2str(cmp_index));
if nargin < 3
    % Retrieve all indices
    cmp_ids = cell2numary(cmp_array);
    ret_array_index = find(ismember(comparison_records(:,1), cmp_ids));
else
    cmp_ids = str2num(cmp_array{cmp_index}); %cell item
    ret_array_index = find(comparison_records(:,1) == cmp_ids);
end
%Find comparison record by cmp_id

comparison_result = comparison_records(ret_array_index,:);

end

