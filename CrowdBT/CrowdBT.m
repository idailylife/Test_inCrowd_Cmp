function result = CrowdBT(Eta, S, Sk, lambda, s0)
% Calculate likelihood function L(eta, s) + lambda*R(s) of Crowd-BT
% Input variables:
% Eta: 1-by-K column vector, K is the number of annotator
% S:   1-by-(N+1) column vector of item score, the end item is the virtual
%       node
% Sk:  1-by-K cell vector, each cell contains lines of pair (i,j)
%      where i,j is the ids of items annotated by worker k
%      ASSERT: item i is judged better than (>) item j by worker k 
if nargin < 5
    s0 = 0.5;
end

K = length(Eta);
N = length(S);
result = 0;

for k = 1:K
    eta = Eta(k);
%     if eta < 0
%         result = -65535;
%         return;
%     end
    for row = 1:length(Sk{k})
        i = Sk{k}(row,1);
        j = Sk{k}(row,2);
        temp = eta  / ( 1 + exp( S(j) - S(i) ) ) ...
                + ( 1 - eta ) / (exp( S(i) - S(j) ) + 1);
        result = result + log(temp);
    end
end
temp = 0;
for i = 1:N
    si = S(i);
    temp = temp + log( 1 / (1 + exp(si - s0))) + ...
        log( 1 / (exp(s0 - si) + 1));
end

result = result + temp * lambda;

end