function [ result ] = restore_indices( btmm_result, idmap )
%RESTORE_INDICES ��extĿ¼�е�bt��������ָ����������кţ�543 -> 551��
%   
result_sz = size(btmm_result,1);
result = zeros(result_sz, 2);
result(:,2) = btmm_result(:,1);
for i=1:result_sz
    orig_id = idmap(idmap(:,2) == btmm_result(i,1) ,1);
    result(i, 1) = orig_id;
end

end

