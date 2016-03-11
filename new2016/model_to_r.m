function [ r ] = model_to_r( models )
%MODEL_TO_R 输入models文件(cell)
%   输出：id对应的评分列表
model_size = size(models, 1);
r = zeros(model_size, 1);
for i = 1 : model_size
    r(i) = models{i}.R;
end

end

