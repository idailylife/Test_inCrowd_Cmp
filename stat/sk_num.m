function sum = sk_num(sk)
%����SK�бȽ϶������ĺ�
sum = 0;
for i = 1: size(sk,1)
    sum = sum + size(sk{i},1);
end
end