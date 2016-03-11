result_c = zeros(2,2);
result_u = zeros(2,2);
for i = 1:length(S1)
    result_c(S1(i,3)+1, ic_c(i)+1) = result_c(S1(i,3)+1, ic_c(i)+1) + 1;
    result_u(S1(i,3)+1, ic_u(i)+1) = result_u(S1(i,3)+1, ic_u(i)+1) + 1;
end