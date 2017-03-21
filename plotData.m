testNumber = '002';
%testType = 'results_distinct_single_red';
%testType = 'results_distinct_single_green';
%testType = 'results_distinct_partial_red';
%testType = 'results_distinct_partial_green';
%testType = 'results_distinct_whole_red_green';
%testType = 'results_distinct_whole_green_red';

%testType = 'results_indistinct_single_red';
%testType = 'results_indistinct_single_green';
%testType = 'results_indistinct_partial_red';
%testType = 'results_indistinct_partial_green';
%testType = 'results_indistinct_whole_red_green';
testType = 'results_indistinct_whole_green_red';

load(strcat('data/', testNumber, '_', testType), 'results');
resultSize = size(results, 3);

expDurations = results(:, :, 1);
expKeys = transpose(unique(results(:, :, 1)));
disp(expKeys);

stimulus1 = results(:, :, 2);
answer1 = results(:, :, 3);
responseTime1 = results(:, :, 4);
if resultSize >= 5
    stimulus2 = results(:, :, 5);
end
if resultSize == 7
    answer2 = results(:, :, 6);
    responseTime2 = results(:, :, 7);
end
%disp(results)
[correct_X1, correct_Y1] = dispResults(stimulus1, answer1, expDurations, expKeys);
if resultSize >= 5
    [switched_X1, switched_Y1] = dispResults(stimulus2, answer1, expDurations, expKeys);
end
if resultSize == 7
    [correct_X2, correct_Y2] = dispResults(stimulus2, answer2, expDurations, expKeys);
    [switched_X2, switched_Y2] = dispResults(stimulus1, answer2, expDurations, expKeys);
end

%scatter(correct_X1, correct_Y1, 'filled'); hold on;
if resultSize >= 5
    %scatter(switched_X1, switched_Y1, 'filled');
end

if resultSize == 7
    scatter(correct_X2, correct_Y2, 'filled'); hold on;
    scatter(switched_X2, switched_Y2, 'filled');
end
xlim([-0.01 0.2]);
ylim([-0.1 1.1]);

function [X, Y] = dispResults(stimulus, answer, expDurations, keys_in)
val = zeros(1, size(keys_in, 2));
%disp(size(keys_in))
%disp(size(val))
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