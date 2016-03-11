function [ comparison ] = get_comparison_by_id( comparisons, id )
%GET_COMPARISON_BY_ID Summary of this function goes here
%   Detailed explanation goes here
index = find(comparisons(:,1)==id, 1);
if isempty(index)
    error(['Cannot find comparion with specified id #', num2str(id)]);
end
comparison = comparisons(index,:);

end

