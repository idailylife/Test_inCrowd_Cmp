function [ hit_records, cmp_records ] = rand_comparison_gen_batch( general_pic, eval_pic, hit_size, level_min )
%RAND_COMPARISON_GEN_BATCH Generate a batch of hit_records
%   hit_size: Size of hit records
%   level_min: Minimum size of level (max. = 7)
hit_records = cell(0, 14);
cmp_records = zeros(0, 8);
start_cmp_id = 50000;
start_hit_id = 8000;
for i = 1:hit_size
    cmp_size = 15 * (level_min + randi([0 7-level_min]));
    disp(['Cmp size=', num2str(cmp_size)]);
    [h, c] = rand_comparison_generator(general_pic, eval_pic, cmp_size, start_cmp_id, start_hit_id);
    hit_records = [hit_records; h];
    cmp_records = [cmp_records; c];
    start_hit_id = start_hit_id + 1;
    start_cmp_id = start_cmp_id + h{1, 7};
end

end

