function [ ndcg ] = calc_NDCG( ranklist, relevance )
%CALC_NDCG 计算NDCG，输出为矩阵
%   ranklist: 排序列表，每一行为 (n, id)
%   relevance: (id, rel) 不存在的id默认rel=0
%               
%   ndcg: 每一行从左到右分别为(n, id, rel, dcg, idcg, ndcg)
    function [relMat] = build_rel_map()
        % 生成行号为id号的rel表，方便查找
        len = max(ranklist(:,2));
        relMat = zeros(len, 1);
        for r = 1:size(relevance, 1)
            relMat(relevance(r,1)) = relevance(r,2);
        end
    end

     function [idcg] = calc_idcg()
         % 计算所有项的idcg，
         [~, I] = sort(relevance(:,2), 'descend');
         rel_desc = relevance(I, :);
         idcg = zeros(size(ranklist,1), 1);
         idcg(1) = rel_desc(1, 2);
         rel_size = size(rel_desc, 1);
         for r = 2:rel_size
             idcg(r) = idcg(r-1) + rel_desc(r,2)/log2(r);
         end
         % 补齐余下的值
         for r = rel_size+1: size(idcg, 1)
            idcg(r) = idcg(rel_size);
         end
     end

relMat = build_rel_map();
ndcg = ranklist;
idcg = calc_idcg();

ndcg(:, 5) = idcg;

ndcg(1, 3) = relMat( ndcg(1,2)); % rel
%ndcg(1, 4) = ndcg(1, 3);    % CG_1
ndcg(1, 4) = ndcg(1, 3);    % DCG_1
ndcg(1, 6) = ndcg(1, 5) / idcg(1);  %NDCG_1

for i = 2:size(ranklist, 1)
    % Get the relevance
    ndcg(i, 3) = relMat( ndcg(i,2) );   % relevance (gain)
    %ndcg(i, 4) = ndcg(i-1, 4) + ndcg(i, 3) ; % CG_n
    ndcg(i, 4) = ndcg(i-1, 4) + ndcg(i, 3) / log2(i); % DCG_n
    
    ndcg(i, 6) = ndcg(i, 4) / idcg(i);  %NDCG_n
    
end

end

