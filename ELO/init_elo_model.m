function [ elo_model ] = init_elo_model( general_pics, manual_size )
%INIT_ELO_MODEL Initialize ELO models for every picture to be judged
%   Detailed explanation goes here
if nargin < 2
    manual_size = 0;
end

disp('Initializing ELO models...');
if manual_size == 0
    model_size = length(general_pics);
    offset = general_pics{1,1};
else
    model_size = manual_size;
    offset = 1;
end


elo_model = cell(model_size, 1);
for row = 1 : model_size
    if manual_size == 0
        img = general_pics(row, :);
        model.id = img{1,1};
    else
        model.id = row;
    end
    model.R = 100;
    model.sigma2 = 100;
    elo_model{row + offset - 1, 1} = model;
end
disp([int2str(model_size), ' ELO models initialized.' ]);

end
