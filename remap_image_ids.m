function [ cmp_records_remapped ] = remap_image_ids( cmp_records, id_map )
%REMAP_IMAGE_IDS 将记录里的非统一的图片id映射成统一id(限非QoE图)
%   Detailed explanation goes here
cmp_records_remapped = cmp_records;
len = length(cmp_records);
disp('ID MAPPING...');
for i = 1:len
    if cmp_records(i,6) == 1
        % Don't manipulate QoE images
        continue
    end
    id_index = (id_map(:,1) == cmp_records(i,3));
    cmp_records_remapped(i,3) = id_map(id_index, 2);
    id_index = (id_map(:,1) == cmp_records(i,4));
    cmp_records_remapped(i,4) = id_map(id_index, 2);
end
disp('DONE.');
end

