function [ wm_new, id_map_mat ] = cre_id_map( wm, nan_logi )
%CRE_ID_MAP ɾ��ֵΪNaN����Ŀ��������ӳ���(old_id, new_id)
%   nan_logi Ϊ�߼�ֵ0,1������. ����Ҫɾ����id���Ӧ�е�ֵ����1
nan_count = 0;  % Non-NaN values count
id_size = length(nan_logi);
id_map_mat = zeros(id_size, 2);
for i =1:id_size
    id_map_mat(i, 1) = i;
    if nan_logi(i) == 1
        nan_count = nan_count + 1;
        id_map_mat(i, 2) = -1;
    else
        id_map_mat(i, 2) = i - nan_count;
    end
end

wm_new = wm;
wm_new(nan_logi, :) = [];
wm_new(:, nan_logi) = [];

end

