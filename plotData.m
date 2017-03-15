testNumber = '002';
load(strcat('data/', testNumber, '_results_indistinct_whole_red_green'), 'results_indistinct_whole_red_green');
[X1, Y1] = dispResults(results_indistinct_whole_red_green(:, :, 2), results_indistinct_whole_red_green(:, :, 3), results_indistinct_whole_red_green(:, :, 1), expDurations);
[X2, Y2] = dispResults(results_indistinct_whole_red_green(:, :, 5), results_indistinct_whole_red_green(:, :, 6), results_indistinct_whole_red_green(:, :, 1), expDurations);
scatter(X1, Y1, 'filled'); hold on;
scatter(X2, Y2, 'filled');

function [X, Y] = dispResults(stimulus, answer, expDurations, keys_in)
val = zeros(1, size(keys_in, 2));
m = containers.Map(keys_in, val);
for e = 1:size(expDurations, 1)
    for t = 1:size(expDurations, 2)
        if expDurations(e, t) > 0
            m(expDurations(e, t)) = m(expDurations(e, t)) + (stimulus(e, t) == answer(e, t));
        end
    end
end
for k = keys_in
    m(k) = m(k) / size(expDurations, 2);
end
X = zeros(1, size(keys_in, 2));
Y = zeros(1, size(keys_in, 2));
for i = 1:size(keys_in, 2)
    X(i) = keys_in(i);
    Y(i) = m(keys_in(i));
end
return
%scatter(X, Y, 'filled');
end