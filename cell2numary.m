function [ num_ary ] = cell2numary( cell_ary )
%CELL2NUMARY Turns cell array (1 * N cell) to number vector(vertical)
cell_n = length(cell_ary);
num_ary = zeros(cell_n, 1);
for i = 1:cell_n
    num_ary(i, 1) = str2num(cell_ary{1,i});
end

end

