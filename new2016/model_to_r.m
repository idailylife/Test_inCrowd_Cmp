function [ r ] = model_to_r( models )
%MODEL_TO_R ����models�ļ�(cell)
%   �����id��Ӧ�������б�
model_size = size(models, 1);
r = zeros(model_size, 1);
for i = 1 : model_size
    r(i) = models{i}.R;
end

end

