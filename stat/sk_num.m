function sum = sk_num(sk)
%计算SK中比较对数量的和
sum = 0;
for i = 1: size(sk,1)
    sum = sum + size(sk{i},1);
end
end