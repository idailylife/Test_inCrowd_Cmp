function [ wm ] = generate_beat_matrix( cmps, q_type, count_eq )
%The output wm is an nxn matrix such that wm(i,j) is the number of times 
% team i beat team j.
% cmps: comparison results
% count_eq: count equal as wm(i,j)++, wm(j,i) ++ or not
if nargin < 3
    count_eq = 1;
end

max_id = max(cmps(:, 3));
wm = zeros(max_id, max_id);

for i = 1:size(cmps, 1)
    cmp = cmps(i, :);
    if cmp(6) ~= 0
        continue; % QoE question
    elseif cmp(7) ~= q_type
        continue;
    elseif cmp(8) ~= -1
        continue; % trap question
    end
    id0 = cmp(3);
    id1 = cmp(4);
    
    switch cmp(2)
        case 0
            % B wins (A scores 0)
            wm(id1, id0) = wm(id1, id0) + 1;
        case 1
            % A wins
            wm(id0, id1) = wm(id0, id1) + 1;
        case 2
            %tie
            if count_eq == 1
                wm(id1, id0) = wm(id1, id0) + 1;
                wm(id0, id1) = wm(id0, id1) + 1;
            end
        otherwise
            warning('Unknown cmp result!');
    end
    
end


end

