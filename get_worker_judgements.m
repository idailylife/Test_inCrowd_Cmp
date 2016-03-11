function [ J ] = get_worker_judgements( cmps )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
cmp_size = size(cmps, 1);
J = zeros(cmp_size, 3);

for row = 1:cmp_size
    id0 = cmps(row, 3);
    id1 = cmps(row, 4);
    rate_orig = cmps(row, 2);
    if rate_orig == 1
        %id0 wins
        rate = 1;
    elseif rate_orig == 2
        %tie
        rate = 0;
    elseif rate_orig == 0
        %id1 wins
        rate = -1;
    end
    J(row, 1) = id0;
    J(row, 2) = id1;
    J(row, 3) = rate;
end

end

