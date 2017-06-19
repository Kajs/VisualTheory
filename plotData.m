clearvars;
testNumber = '002';
redFirst = 1;
training = 0;

color_correct = 'black';
color_reversed = 'red';

if redFirst
    testNumber = strcat('redFirst/', testNumber);
else
    testNumber = strcat('greenFirst/', testNumber);
end

global maxIter;
maxIter = 1000000000;
options = optimset('MaxFunEvals',maxIter, 'MaxIter', maxIter);

trainingStr = '';
if training; trainingStr = 'training_'; end
    
d_s_r = strcat('results_', trainingStr, 'distinct_single_red');
d_s_g = strcat('results_', trainingStr, 'distinct_single_green');
d_p_r = strcat('results_', trainingStr, 'distinct_partial_red');
d_p_g = strcat('results_', trainingStr, 'distinct_partial_green');
d_w_r = strcat('results_', trainingStr, 'distinct_whole_red_green');
d_w_g = strcat('results_', trainingStr, 'distinct_whole_green_red');

i_s_r = strcat('results_', trainingStr, 'indistinct_single_red');
i_s_g = strcat('results_', trainingStr, 'indistinct_single_green');
i_p_r = strcat('results_', trainingStr, 'indistinct_partial_red');
i_p_g = strcat('results_', trainingStr, 'indistinct_partial_green');
i_w_r = strcat('results_', trainingStr, 'indistinct_whole_red_green');
i_w_g = strcat('results_', trainingStr, 'indistinct_whole_green_red');

xMin = -0.01;
xMax = 0.1;
yMin = -0.01;
yMax = 1.01;

fitX = linspace(0.0, 0.1);
pointSizeOne = 30.0;
pointSizeTwo = pointSizeOne/1.8;

plot_d_s_r = 1;
plot_d_s_g = 1;
plot_d_p_r = 1;
plot_d_p_g = 1;
plot_d_w_r = 1;
plot_d_w_g = 1;

plot_i_s_r = 1;
plot_i_s_g = 1;
plot_i_p_r = 1;
plot_i_p_g = 1;
plot_i_w_r = 1;
plot_i_w_g = 1;

if training
    if redFirst
        plot_d_s_g = 0;
        plot_d_p_g = 0;
        plot_d_w_g = 0;
        
        plot_i_s_g = 0;
        plot_i_p_g = 0;
        plot_i_w_g = 0;
    else
        plot_d_s_r = 0;
        plot_d_p_r = 0;
        plot_d_w_r = 0;
        
        plot_i_s_r = 0;
        plot_i_p_r = 0;
        plot_i_w_r = 0;
    end
end

%disp(results)
if plot_d_s_r; [d_s_r_X, d_s_r_Y_1_1] = countResults(testNumber, d_s_r); end
if plot_d_s_g; [d_s_g_X, d_s_g_Y_1_1] = countResults(testNumber, d_s_g); end
if plot_d_p_r; [d_p_r_X, d_p_r_Y_1_1, d_p_r_Y_1_2] = countResults(testNumber, d_p_r); end
if plot_d_p_g; [d_p_g_X, d_p_g_Y_1_1, d_p_g_Y_1_2] = countResults(testNumber, d_p_g); end
if plot_d_w_r; [d_w_r_X, d_w_r_Y_1_1, d_w_r_Y_1_2, d_w_r_Y_2_2, d_w_r_Y_2_1, d_w_r_Y_both, d_w_r_Y_none] = countResults(testNumber, d_w_r); end
if plot_d_w_g; [d_w_g_X, d_w_g_Y_1_1, d_w_g_Y_1_2, d_w_g_Y_2_2, d_w_g_Y_2_1, d_w_g_Y_both, d_w_g_Y_none] = countResults(testNumber, d_w_g); end

if plot_i_s_r; [i_s_r_X, i_s_r_Y_1_1] = countResults(testNumber, i_s_r); end
if plot_i_s_g; [i_s_g_X, i_s_g_Y_1_1] = countResults(testNumber, i_s_g); end
if plot_i_p_r; [i_p_r_X, i_p_r_Y_1_1, i_p_r_Y_1_2] = countResults(testNumber, i_p_r); end
if plot_i_p_g; [i_p_g_X, i_p_g_Y_1_1, i_p_g_Y_1_2] = countResults(testNumber, i_p_g); end
if plot_i_w_r; [i_w_r_X, i_w_r_Y_1_1, i_w_r_Y_1_2, i_w_r_Y_2_2, i_w_r_Y_2_1, i_w_r_Y_both, i_w_r_Y_none] = countResults(testNumber, i_w_r); end
if plot_i_w_g; [i_w_g_X, i_w_g_Y_1_1, i_w_g_Y_1_2, i_w_g_Y_2_2, i_w_g_Y_2_1, i_w_g_Y_both, i_w_g_Y_none] = countResults(testNumber, i_w_g); end

fitVars_distinct = fitData_all(options, d_s_r_X, d_s_r_Y_1_1, d_s_g_X, d_s_g_Y_1_1,...
            d_p_r_X, d_p_r_Y_1_1, d_p_r_Y_1_2, d_p_g_X, d_p_g_Y_1_1, d_p_g_Y_1_2,...
            d_w_r_X, d_w_r_Y_both, d_w_r_Y_none, d_w_r_Y_1_1, d_w_r_Y_1_2, d_w_r_Y_2_2, d_w_r_Y_2_1,...
            d_w_g_X, d_w_g_Y_both, d_w_g_Y_none, d_w_g_Y_1_1, d_w_g_Y_1_2, d_w_g_Y_2_2, d_w_g_Y_2_1);
fitVars_indistinct = fitData_all(options, i_s_r_X, i_s_r_Y_1_1, i_s_g_X, i_s_g_Y_1_1,...
            i_p_r_X, i_p_r_Y_1_1, i_p_r_Y_1_2, i_p_g_X, i_p_g_Y_1_1, i_p_g_Y_1_2,...
            i_w_r_X, i_w_r_Y_both, i_w_r_Y_none, i_w_r_Y_1_1, i_w_r_Y_1_2, i_w_r_Y_2_2, i_w_r_Y_2_1,...
            i_w_g_X, i_w_g_Y_both, i_w_g_Y_none, i_w_g_Y_1_1, i_w_g_Y_1_2, i_w_g_Y_2_2, i_w_g_Y_2_1);

figure
%DISTINCT
if plot_d_s_r
    subplot(4,6,1);
    scatter(d_s_r_X, d_s_r_Y_1_1, pointSizeOne, color_correct, 'filled'); hold on;
    %plot(fitX, fitData(d_s_r_X, d_s_r_Y_1_1, options, fitX, @probabilityCorrect_single), color_correct);
    plot(fitX, genYpoints(fitX, fitVars_distinct, @probabilityCorrect_single), color_correct);
    title('D-S-R');
    xlim([xMin xMax]);
    ylim([yMin yMax]);
end

if plot_d_s_g
    subplot(4,6,3);
    scatter(d_s_g_X, d_s_g_Y_1_1, pointSizeOne, color_correct, 'filled'); hold on; 
    %plot (fitX, fitData(d_s_g_X, d_s_g_Y_1_1, options, fitX, @probabilityCorrect_single), color_correct);
    plot(fitX, genYpoints(fitX, fitVars_distinct, @probabilityCorrect_single), color_correct);
    title('D-S-G');
    xlim([xMin xMax]);
    ylim([yMin yMax]);
end

if plot_d_p_r
    subplot(4,6,7);
    scatter(d_p_r_X, d_p_r_Y_1_1, pointSizeOne, color_correct, 'filled'); hold on;
    scatter(d_p_r_X, d_p_r_Y_1_2, pointSizeTwo, color_reversed, 'filled');
    %plot(fitX, fitData(d_p_r_X, d_p_r_Y_1_1, options, fitX, @probabilityCorrect_partial), color_correct);
    %plot(fitX, fitData(d_p_r_X, d_p_r_Y_1_2, options, fitX, @probabilityCorrect_partial_r), color_reversed);
    plot(fitX, genYpoints(fitX, fitVars_distinct, @probabilityCorrect_partial), color_correct);
    plot(fitX, genYpoints(fitX, fitVars_distinct, @probabilityCorrect_partial_r), color_reversed);
    title('D-P-R');
    xlim([xMin xMax]);
    ylim([yMin yMax]);
end

if plot_d_p_g
    subplot(4,6,9);
    scatter(d_p_g_X, d_p_g_Y_1_1, pointSizeOne, color_correct, 'filled'); hold on;
    scatter(d_p_g_X, d_p_g_Y_1_2, pointSizeTwo, color_reversed, 'filled');
    %plot(fitX, fitData(d_p_g_X, d_p_g_Y_1_1, options, fitX, @probabilityCorrect_partial), color_correct); 
    %plot(fitX, fitData(d_p_g_X, d_p_g_Y_1_2, options, fitX, @probabilityCorrect_partial_r), color_reversed);
    plot(fitX, genYpoints(fitX, fitVars_distinct, @probabilityCorrect_partial), color_correct);
    plot(fitX, genYpoints(fitX, fitVars_distinct, @probabilityCorrect_partial_r), color_reversed);
    title('D-P-G');
    xlim([xMin xMax]);
    ylim([yMin yMax]);
end

if plot_d_w_r
    subplot(4,6,13);
    scatter(d_w_r_X, d_w_r_Y_1_1, pointSizeOne, color_correct, 'filled'); hold on;
    scatter(d_w_r_X, d_w_r_Y_1_2, pointSizeTwo, color_reversed, 'filled');
    %plot(fitX, fitData(d_w_r_X, d_w_r_Y_1_1, options, fitX, @probabilityCorrect_whole_one), color_correct); 
    %plot(fitX, fitData(d_w_r_X, d_w_r_Y_1_2, options, fitX, @probabilityCorrect_whole_one_r), color_reversed); 
    plot(fitX, genYpoints(fitX, fitVars_distinct, @probabilityCorrect_whole_one), color_correct);
    plot(fitX, genYpoints(fitX, fitVars_distinct, @probabilityCorrect_whole_one_r), color_reversed);
    title('D-W-R-G');
    xlim([xMin xMax]);
    ylim([yMin yMax]);
    
    subplot(4,6,14);
    scatter(d_w_r_X, d_w_r_Y_both, pointSizeOne, color_correct, 'filled'); hold on;
    scatter(d_w_r_X, d_w_r_Y_none, pointSizeTwo, color_reversed, 'filled');  
    %plot(fitX, fitData(d_w_r_X, d_w_r_Y_both, options, fitX, @probabilityCorrect_whole_both), color_correct); 
    %plot(fitX, fitData(d_w_r_X, d_w_r_Y_none, options, fitX, @probabilityCorrect_whole_both_r), color_reversed); 
    plot(fitX, genYpoints(fitX, fitVars_distinct, @probabilityCorrect_whole_both), color_correct);
    plot(fitX, genYpoints(fitX, fitVars_distinct, @probabilityCorrect_whole_both_r), color_reversed);
    title('D-W-R-G');
    xlim([xMin xMax]);
    ylim([yMin yMax]);
    
    subplot(4,6,15);
    scatter(d_w_r_X, d_w_r_Y_2_2, pointSizeOne, color_correct, 'filled'); hold on;
    scatter(d_w_r_X, d_w_r_Y_2_1, pointSizeTwo, color_reversed, 'filled');
    %plot(fitX, fitData(d_w_r_X, d_w_r_Y_2_2, options, fitX, @probabilityCorrect_whole_one), color_correct); 
    %plot(fitX, fitData(d_w_r_X, d_w_r_Y_2_1, options, fitX, @probabilityCorrect_whole_one_r), color_reversed); 
    plot(fitX, genYpoints(fitX, fitVars_distinct, @probabilityCorrect_whole_one), color_correct);
    plot(fitX, genYpoints(fitX, fitVars_distinct, @probabilityCorrect_whole_one_r), color_reversed);
    title('D-W-R-G');
    xlim([xMin xMax]);
    ylim([yMin yMax]);
end

if plot_d_w_g
    subplot(4,6,19);
    scatter(d_w_g_X, d_w_g_Y_1_1, pointSizeOne, color_correct, 'filled'); hold on;
    scatter(d_w_g_X, d_w_g_Y_1_2, pointSizeTwo, color_reversed, 'filled');
    %plot(fitX, fitData(d_w_g_X, d_w_g_Y_1_1, options, fitX, @probabilityCorrect_whole_one), color_correct); 
    %plot(fitX, fitData(d_w_g_X, d_w_g_Y_1_2, options, fitX, @probabilityCorrect_whole_one_r), color_reversed); 
    plot(fitX, genYpoints(fitX, fitVars_distinct, @probabilityCorrect_whole_one), color_correct);
    plot(fitX, genYpoints(fitX, fitVars_distinct, @probabilityCorrect_whole_one_r), color_reversed);
    title('D-W-G-R');
    xlim([xMin xMax]);
    ylim([yMin yMax]);
    
    subplot(4,6,20);
    scatter(d_w_g_X, d_w_g_Y_both, pointSizeOne, color_correct, 'filled'); hold on;
    scatter(d_w_g_X, d_w_g_Y_none, pointSizeTwo, color_reversed, 'filled');
    %plot(fitX, fitData(d_w_g_X, d_w_g_Y_both, options, fitX, @probabilityCorrect_whole_both), color_correct); 
    %plot(fitX, fitData(d_w_g_X, d_w_g_Y_none, options, fitX, @probabilityCorrect_whole_both_r), color_reversed); 
    plot(fitX, genYpoints(fitX, fitVars_distinct, @probabilityCorrect_whole_both), color_correct);
    plot(fitX, genYpoints(fitX, fitVars_distinct, @probabilityCorrect_whole_both_r), color_reversed);
    title('D-W-G-R');
    xlim([xMin xMax]);
    ylim([yMin yMax]);
    
    subplot(4,6,21);
    scatter(d_w_g_X, d_w_g_Y_2_2, pointSizeOne, color_correct, 'filled'); hold on;
    scatter(d_w_g_X, d_w_g_Y_2_1, pointSizeTwo, color_reversed, 'filled');
    %plot(fitX, fitData(d_w_g_X, d_w_g_Y_2_2, options, fitX, @probabilityCorrect_whole_one), color_correct); 
    %plot(fitX, fitData(d_w_g_X, d_w_g_Y_2_1, options, fitX, @probabilityCorrect_whole_one_r), color_reversed); 
    plot(fitX, genYpoints(fitX, fitVars_distinct, @probabilityCorrect_whole_one), color_correct);
    plot(fitX, genYpoints(fitX, fitVars_distinct, @probabilityCorrect_whole_one_r), color_reversed);
    title('D-W-G-R');
    xlim([xMin xMax]);
    ylim([yMin yMax]);
end

%INDISTINCT
if plot_i_s_r
    subplot(4,6,4);
    scatter(i_s_r_X, i_s_r_Y_1_1, pointSizeOne, color_correct, 'filled'); hold on;
    %plot(fitX, fitData(i_s_r_X, i_s_r_Y_1_1, options, fitX, @probabilityCorrect_single), color_correct);
    plot(fitX, genYpoints(fitX, fitVars_indistinct, @probabilityCorrect_single), color_correct);
    title('I-S-R');
    xlim([xMin xMax]);
    ylim([yMin yMax]);
end

if plot_i_s_g
    subplot(4,6,6);
    scatter(i_s_g_X, i_s_g_Y_1_1, pointSizeOne, color_correct, 'filled'); hold on;
    %plot(fitX, fitData(i_s_g_X, i_s_g_Y_1_1, options, fitX, @probabilityCorrect_single), color_correct);
    plot(fitX, genYpoints(fitX, fitVars_indistinct, @probabilityCorrect_single), color_correct);
    title('I-S-G');
    xlim([xMin xMax]);
    ylim([yMin yMax]);
end

if plot_i_p_r
    subplot(4,6,10);
    scatter(i_p_r_X, i_p_r_Y_1_1, pointSizeOne, color_correct, 'filled'); hold on;
    scatter(i_p_r_X, i_p_r_Y_1_2, pointSizeTwo, color_reversed, 'filled');
    %plot(fitX, fitData(i_p_r_X, i_p_r_Y_1_1, options, fitX, @probabilityCorrect_partial), color_correct); 
    %plot(fitX, fitData(i_p_r_X, i_p_r_Y_1_2, options, fitX, @probabilityCorrect_partial_r), color_reversed);
    plot(fitX, genYpoints(fitX, fitVars_indistinct, @probabilityCorrect_partial), color_correct);
    plot(fitX, genYpoints(fitX, fitVars_indistinct, @probabilityCorrect_partial_r), color_reversed);
    title('I-P-R');
    xlim([xMin xMax]);
    ylim([yMin yMax]);
end

if plot_i_p_g
    subplot(4,6,12);
    scatter(i_p_g_X, i_p_g_Y_1_1, pointSizeOne, color_correct, 'filled'); hold on;
    scatter(i_p_g_X, i_p_g_Y_1_2, pointSizeTwo, color_reversed, 'filled');
    %plot(fitX, fitData(i_p_g_X, i_p_g_Y_1_1, options, fitX, @probabilityCorrect_partial), color_correct); 
    %plot(fitX, fitData(i_p_g_X, i_p_g_Y_1_2, options, fitX, @probabilityCorrect_partial_r), color_reversed);
    plot(fitX, genYpoints(fitX, fitVars_indistinct, @probabilityCorrect_partial), color_correct);
    plot(fitX, genYpoints(fitX, fitVars_indistinct, @probabilityCorrect_partial_r), color_reversed);
    title('I-P-G');
    xlim([xMin xMax]);
    ylim([yMin yMax]);
end

if plot_i_w_r
    subplot(4,6,16);
    scatter(i_w_r_X, i_w_r_Y_1_1, pointSizeOne, color_correct, 'filled'); hold on;
    scatter(i_w_r_X, i_w_r_Y_1_2, pointSizeTwo, color_reversed, 'filled');
    %plot(fitX, fitData(i_w_r_X, i_w_r_Y_1_1, options, fitX, @probabilityCorrect_whole_one), color_correct); 
    %plot(fitX, fitData(i_w_r_X, i_w_r_Y_1_2, options, fitX, @probabilityCorrect_whole_one_r), color_reversed);
    plot(fitX, genYpoints(fitX, fitVars_indistinct, @probabilityCorrect_whole_one), color_correct);
    plot(fitX, genYpoints(fitX, fitVars_indistinct, @probabilityCorrect_whole_one_r), color_reversed);
    title('I-W-R-G');
    xlim([xMin xMax]);
    ylim([yMin yMax]);
    
    subplot(4,6,17);
    scatter(i_w_r_X, i_w_r_Y_both, pointSizeOne, color_correct, 'filled'); hold on;
    scatter(i_w_r_X, i_w_r_Y_none, pointSizeTwo, color_reversed, 'filled');
    %plot(fitX, fitData(i_w_r_X, i_w_r_Y_both, options, fitX, @probabilityCorrect_whole_both), color_correct); 
    %plot(fitX, fitData(i_w_r_X, i_w_r_Y_none, options, fitX, @probabilityCorrect_whole_both_r), color_reversed); 
    plot(fitX, genYpoints(fitX, fitVars_indistinct, @probabilityCorrect_whole_both), color_correct);
    plot(fitX, genYpoints(fitX, fitVars_indistinct, @probabilityCorrect_whole_both_r), color_reversed);
    title('I-W-R-G');
    xlim([xMin xMax]);
    ylim([yMin yMax]);
    
    subplot(4,6,18);
    scatter(i_w_r_X, i_w_r_Y_2_2, pointSizeOne, color_correct, 'filled'); hold on;
    scatter(i_w_r_X, i_w_r_Y_2_1, pointSizeTwo, color_reversed, 'filled');
    %plot(fitX, fitData(i_w_r_X, i_w_r_Y_2_2, options, fitX, @probabilityCorrect_whole_one), color_correct); 
    %plot(fitX, fitData(i_w_r_X, i_w_r_Y_2_1, options, fitX, @probabilityCorrect_whole_one_r), color_reversed);
    plot(fitX, genYpoints(fitX, fitVars_indistinct, @probabilityCorrect_whole_one), color_correct);
    plot(fitX, genYpoints(fitX, fitVars_indistinct, @probabilityCorrect_whole_one_r), color_reversed);
    title('I-W-R-G');
    xlim([xMin xMax]);
    ylim([yMin yMax]);
end

if plot_i_w_g
    subplot(4,6,22);
    scatter(i_w_g_X, i_w_g_Y_1_1, pointSizeOne, color_correct, 'filled'); hold on;
    scatter(i_w_g_X, i_w_g_Y_1_2, pointSizeTwo, color_reversed, 'filled');
    %plot(fitX, fitData(i_w_g_X, i_w_g_Y_1_1, options, fitX, @probabilityCorrect_whole_one), color_correct); 
    %plot(fitX, fitData(i_w_g_X, i_w_g_Y_1_2, options, fitX, @probabilityCorrect_whole_one_r), color_reversed);
    plot(fitX, genYpoints(fitX, fitVars_indistinct, @probabilityCorrect_whole_one), color_correct);
    plot(fitX, genYpoints(fitX, fitVars_indistinct, @probabilityCorrect_whole_one_r), color_reversed);
    title('I-W-G-R');
    xlim([xMin xMax]);
    ylim([yMin yMax]);
    
    subplot(4,6,23);
    scatter(i_w_g_X, i_w_g_Y_both, pointSizeOne, color_correct, 'filled'); hold on;
    scatter(i_w_g_X, i_w_g_Y_none, pointSizeTwo, color_reversed, 'filled');
    %plot(fitX, fitData(i_w_g_X, i_w_g_Y_both, options, fitX, @probabilityCorrect_whole_both), color_correct); 
    %plot(fitX, fitData(i_w_g_X, i_w_g_Y_none, options, fitX, @probabilityCorrect_whole_both_r), color_reversed); 
    plot(fitX, genYpoints(fitX, fitVars_indistinct, @probabilityCorrect_whole_both), color_correct);
    plot(fitX, genYpoints(fitX, fitVars_indistinct, @probabilityCorrect_whole_both_r), color_reversed);
    title('I-W-G-R');
    xlim([xMin xMax]);
    ylim([yMin yMax]);
    
    subplot(4,6,24);
    scatter(i_w_g_X, i_w_g_Y_2_2, pointSizeOne, color_correct, 'filled'); hold on;
    scatter(i_w_g_X, i_w_g_Y_2_1, pointSizeTwo, color_reversed, 'filled');
    %plot(fitX, fitData(i_w_g_X, i_w_g_Y_2_2, options, fitX, @probabilityCorrect_whole_one), color_correct); 
    %plot(fitX, fitData(i_w_g_X, i_w_g_Y_2_1, options, fitX, @probabilityCorrect_whole_one_r), color_reversed);
    plot(fitX, genYpoints(fitX, fitVars_indistinct, @probabilityCorrect_whole_one), color_correct);
    plot(fitX, genYpoints(fitX, fitVars_indistinct, @probabilityCorrect_whole_one_r), color_reversed);
    title('I-W-G-R');
    xlim([xMin xMax]);
    ylim([yMin yMax]);
end

disp(fitVars_distinct);
disp(fitVars_indistinct);

function [X, Y_1_1, Y_1_2, Y_2_2, Y_2_1, Y_both, Y_none] = countResults(testNumber, testType)
load(strcat('data/', testNumber, '_', testType), 'results');
resultSize = size(results, 3);
expDurations = results(:, :, 1);
expKeys = transpose(unique(results(:, :, 1)));

stimulus1 = results(:, :, 2);
answer1 = results(:, :, 3);
responseTime1 = results(:, :, 4);
if resultSize >= 5; stimulus2 = results(:, :, 5); end
if resultSize == 7
    answer2 = results(:, :, 6);
    responseTime2 = results(:, :, 7);
end
val = zeros(1, size(expKeys, 2));
%disp(size(keys_in))
%disp(size(val))
m_1_1 = containers.Map(expKeys, val);
if resultSize >= 5; m_1_2 = containers.Map(expKeys, val); end
if resultSize == 7
    m_2_2 = containers.Map(expKeys, val);
    m_2_1 = containers.Map(expKeys, val);
    m_both = containers.Map(expKeys, val);
    m_none = containers.Map(expKeys, val);
end
for e = 1:size(expDurations, 1)
    for t = 1:size(expDurations, 2)
        if expDurations(e, t) > 0
            if resultSize < 5 % SINGLE
                m_1_1(expDurations(e, t)) = m_1_1(expDurations(e, t)) + (answer1(e, t) == stimulus1(e, t));
            end
            if resultSize == 5 % PARTIAL
                m_1_1(expDurations(e, t)) = m_1_1(expDurations(e, t)) + (answer1(e, t) == stimulus1(e, t));
                m_1_2(expDurations(e, t)) = m_1_2(expDurations(e, t)) + (answer1(e, t) == stimulus2(e, t));
            end
            if resultSize == 7 % WHOLE
                m_1_1(expDurations(e, t)) = m_1_1(expDurations(e, t))   + (answer1(e, t) == stimulus1(e, t) & answer2(e, t) ~= stimulus2(e, t));
                m_1_2(expDurations(e, t)) = m_1_2(expDurations(e, t))   + (answer1(e, t) == stimulus2(e, t) & answer2(e, t) ~= stimulus1(e, t));
                m_2_2(expDurations(e, t)) = m_2_2(expDurations(e, t))   + (answer2(e, t) == stimulus2(e, t) & answer1(e, t) ~= stimulus1(e, t));
                m_2_1(expDurations(e, t)) = m_2_1(expDurations(e, t))   + (answer2(e, t) == stimulus1(e, t) & answer1(e, t) ~= stimulus2(e, t));
                m_both(expDurations(e, t)) = m_both(expDurations(e, t)) + (answer1(e, t) == stimulus1(e, t) & answer2(e, t) == stimulus2(e, t));
                m_none(expDurations(e, t)) = m_none(expDurations(e, t)) + (answer1(e, t) == stimulus2(e, t) & answer2(e, t) == stimulus1(e, t));
            end
        end
    end
end
for k = expKeys
    m_1_1(k) = m_1_1(k) / size(expDurations, 2);
    if resultSize >= 5
        m_1_2(k) = m_1_2(k) / size(expDurations, 2);
    end
    if resultSize == 7
        m_2_2(k) = m_2_2(k) / size(expDurations, 2);
        m_2_1(k) = m_2_1(k) / size(expDurations, 2);
        m_both(k) = m_both(k) / size(expDurations, 2);
        m_none(k) = m_none(k) / size(expDurations, 2);
    end
end
X = zeros(1, size(expKeys, 2));
Y_1_1 = zeros(1, size(expKeys, 2));
Y_1_2 = zeros(1, size(expKeys, 2));
Y_2_1 = zeros(1, size(expKeys, 2));
Y_2_2 = zeros(1, size(expKeys, 2));
Y_both = zeros(1, size(expKeys, 2));
Y_none = zeros(1, size(expKeys, 2));

for i = 1:size(expKeys, 2)
    X(i) = expKeys(i);
    Y_1_1(i) = m_1_1(expKeys(i));
    if resultSize >= 5
        Y_1_2(i) = m_1_2(expKeys(i));
    end
    if resultSize == 7
        Y_2_2(i) = m_2_2(expKeys(i));
        Y_2_1(i) = m_2_1(expKeys(i));
        Y_both(i) = m_both(expKeys(i));
        Y_none(i) = m_none(expKeys(i));
    end
end

return
end

function fitvars = fitData_all(options, s_r_x, s_r_y, s_g_x, s_g_y, p_r_x, p_r_y, p_r_rev, p_g_x, p_g_y, p_g_rev, w_r_x, w_r_both, w_r_none, w_r_single_r, w_r_single_r_rev, w_r_single_g, w_r_single_g_rev, w_g_x, w_g_both, w_g_none, w_g_single_r, w_g_single_r_rev, w_g_single_g, w_g_single_g_rev)
    fitVariables = rand(3,1);
    fitVariables(1, 1) = 150.0; %k
    fitVariables(2, 1) = 0.05;  %e0
    fitVariables(3, 1) = 0.0;   %lapse
    fun = @(x)getR2_all(x, s_r_x, s_r_y, s_g_x, s_g_y, p_r_x, p_r_y, p_r_rev, p_g_x, p_g_y, p_g_rev, w_r_x, w_r_both, w_r_none, w_r_single_r, w_r_single_r_rev, w_r_single_g, w_r_single_g_rev, w_g_x, w_g_both, w_g_none, w_g_single_r, w_g_single_r_rev, w_g_single_g, w_g_single_g_rev);
    fitvars = fminsearch(fun,fitVariables, options);
    return
end

function R2_all = getR2_all(vars, s_r_x, s_r_y, s_g_x, s_g_y, p_r_x, p_r_y, p_r_rev, p_g_x, p_g_y, p_g_rev, w_r_x, w_r_both, w_r_none, w_r_single_r, w_r_single_r_rev, w_r_single_g, w_r_single_g_rev, w_g_x, w_g_both, w_g_none, w_g_single_r, w_g_single_r_rev, w_g_single_g, w_g_single_g_rev)
R2_s_r = getR2(vars, s_r_x, s_r_y, @probabilityCorrect_single);
R2_s_g = getR2(vars, s_g_x, s_g_y, @probabilityCorrect_single);
R2_p_r = getR2(vars, p_r_x, p_r_y, @probabilityCorrect_partial);
R2_p_r_rev = getR2(vars, p_r_x, p_r_rev, @probabilityCorrect_partial_r);
R2_p_g = getR2(vars, p_g_x, p_g_y, @probabilityCorrect_partial);
R2_p_g_rev = getR2(vars, p_g_x, p_g_rev, @probabilityCorrect_partial_r);
R2_w_r_both = getR2(vars, w_r_x, w_r_both, @probabilityCorrect_whole_both);
R2_w_r_both_r = getR2(vars, w_r_x, w_r_none, @probabilityCorrect_whole_both_r);
R2_w_r_single_r = getR2(vars, w_r_x, w_r_single_r, @probabilityCorrect_whole_one);
R2_w_r_single_r_rev = getR2(vars, w_r_x, w_r_single_r_rev, @probabilityCorrect_whole_one_r);
R2_w_r_single_g = getR2(vars, w_r_x, w_r_single_g, @probabilityCorrect_whole_one);
R2_w_r_single_g_rev = getR2(vars, w_r_x, w_r_single_g_rev, @probabilityCorrect_whole_one_r);
R2_w_g_both = getR2(vars, w_g_x, w_g_both, @probabilityCorrect_whole_both);
R2_w_g_both_r = getR2(vars, w_g_x, w_g_none, @probabilityCorrect_whole_both_r);
R2_w_g_single_r = getR2(vars, w_g_x, w_g_single_r, @probabilityCorrect_whole_one);
R2_w_g_single_r_rev = getR2(vars, w_g_x, w_g_single_r_rev, @probabilityCorrect_whole_one_r);
R2_w_g_single_g = getR2(vars, w_g_x, w_g_single_g, @probabilityCorrect_whole_one);
R2_w_g_single_g_rev = getR2(vars, w_g_x, w_g_single_g_rev, @probabilityCorrect_whole_one_r);

R2_all = R2_s_r + R2_s_g + R2_p_r + R2_p_r_rev + R2_p_g + R2_p_g_rev;
R2_all = R2_all + R2_w_r_both + R2_w_r_both_r + R2_w_r_single_r + R2_w_r_single_r_rev + R2_w_r_single_g + R2_w_r_single_g_rev;
R2_all = R2_all + R2_w_g_both + R2_w_g_both_r + R2_w_g_single_r + R2_w_g_single_r_rev + R2_w_g_single_g + R2_w_g_single_g_rev;
return
end

function predicted = genYpoints(fitX, vars, probabilityFunction)
k = vars(1);
e0 = vars(2);
lapse = vars(3);

predicted = zeros(1, size(fitX, 2));
for i = 1:size(fitX, 2)
    predicted(i) = probabilityFunction(@logistic, [fitX(i), e0, k], 0.2, lapse);
end
return
end

function predicted = fitData(xdata, ydata, options, fitX, probabilityFunction)
    global maxIter;
    fitVariables = rand(3,1);
    fitVariables(1, 1) = 150.0; %k
    fitVariables(2, 1) = 0.05;  %e0
    fitVariables(3, 1) = 0.0;   %lapse
    fun = @(x)getR2(x, xdata, ydata, probabilityFunction);
    vars = fminsearch(fun,fitVariables, options);
    
    k = vars(1);
    e0 = vars(2);
    %if(e0 < 0) e0 = 0; end
    lapse = vars(3);
    if (lapse < 0.0) lapse = 0.0; end
    if (lapse > 1.0) lapse = 1.0; end
    lapse = 0.0; %LAPSE OFF
    fprintf('e0 = %d, k = %d, lapse = %d\n', e0, k, lapse);

    predicted = zeros(1, size(fitX, 2));
    for i = 1:size(fitX, 2)
        predicted(i) = probabilityFunction(@logistic, [fitX(i), e0, k], 0.2, lapse);
    end
end

function R2 = getR2(vars, xdata, ydata, fun)
    k = vars(1);
    e0 = vars(2);
    %if(e0 < 0) e0 = 0; end
    lapse = vars(3);
    if (lapse < 0.0) lapse = 0.0; end
    if (lapse > 1.0) lapse = 1.0; end
    lapse = 0.0; %LAPSE OFF
    m = mean(ydata);
    
    SStot = 0.0;
    SSres = 0.0;
    for i = 1:size(xdata, 2)
        f = fun(@logistic, [xdata(i), e0, k], 0.2, lapse);
        SStot = SStot + (ydata(i) - m).^2;
        SSres = SSres + (ydata(i) - f).^2;
    end
    R2 = -(1.0 - SSres/SStot);
end

function p = probabilityCorrect_single(probFun, fitVariables, guess, lapse)
p_l1 = probFun(fitVariables);

case1 = p_l1;
case2 = (1.0 - p_l1) * 0.2;

p = case1 + case2;
p = p * (1.0 - lapse) + lapse * guess;
return
end

function p = probabilityCorrect_partial(probFun, fitVariables, guess, lapse)
p_l1 = probFun(fitVariables);
p_l2 = probFun(fitVariables);
p_c = probFun(fitVariables);

case1 = p_l1 * p_l2 * p_c;
case2 = p_l1 * p_l2 * (1.0 - p_c)         * 0.5;                %guess color
case3 = p_l1 * (1.0 - p_l2) * p_c;
case4 = p_l1 * (1.0 - p_l2) * (1.0 - p_c) * 0.5;                %guess color
case5 = (1.0 - p_l1) * p_l2 * p_c         * 0.25;               %guess letter out of 4
case6 = (1.0 - p_l1) * p_l2 * (1.0 - p_c) * 0.5 * 0.25;         %guess color, letter out of 4
case7 = (1.0 - p_l1) * (1.0 - p_l2) * p_c * 0.2;                %guess letter out of 5
case8 = (1.0 - p_l1) * (1.0 - p_l2) * (1.0 - p_c) * 0.5 * 0.2;  %guess color, letter out of 5

p = case1 + case2 + case3 + case4 + case5 + case6 + case7 + case8;
p = p * (1.0 - lapse) + lapse * guess;
return
end

function p = probabilityCorrect_partial_r(probFun, fitVariables, guess, lapse)
p_l1 = probFun(fitVariables);
p_l2 = probFun(fitVariables);
p_c = probFun(fitVariables);

case1 = p_l1 * p_l2 * p_c                 * 0;
case2 = p_l1 * p_l2 * (1.0 - p_c)         * 0.5;                %guess color
case3 = p_l1 * (1.0 - p_l2) * p_c         * 0;
case4 = p_l1 * (1.0 - p_l2) * (1.0 - p_c) * 0.5 * 0.25;         %guess color, letter out of 4
case5 = (1.0 - p_l1) * p_l2 * p_c         * 0;
case6 = (1.0 - p_l1) * p_l2 * (1.0 - p_c) * 0.5;                %guess color
case7 = (1.0 - p_l1) * (1.0 - p_l2) * p_c * 0;
case8 = (1.0 - p_l1) * (1.0 - p_l2) * (1.0 - p_c) * 0.5 * 0.2;  %guess color, letter out of 5

p = case1 + case2 + case3 + case4 + case5 + case6 + case7 + case8;
p = p * (1.0 - lapse) + lapse * guess;
return
end

function p = probabilityCorrect_whole_both(probFun, fitVariables, guess, lapse)
p_l1 = probFun(fitVariables);
p_l2 = probFun(fitVariables);
p_c = probFun(fitVariables);

case1 = p_l1 * p_l2 * p_c;
case2 = p_l1 * p_l2 * (1.0 - p_c)         * 0.5;                %guess color
case3 = p_l1 * (1.0 - p_l2) * p_c         * 0.25;               %guess letter out of 4
case4 = p_l1 * (1.0 - p_l2) * (1.0 - p_c) * 0.5 * 0.25;         %guess color, letter out of 4
case5 = (1.0 - p_l1) * p_l2 * p_c         * 0.25;               %guess letter out of 4
case6 = (1.0 - p_l1) * p_l2 * (1.0 - p_c) * 0.5 * 0.25;         %guess color, letter out of 4
case7 = (1.0 - p_l1) * (1.0 - p_l2) * p_c * 0.2 * 0.25;         %guess letter out of 5, letter out of 4
case8 = (1.0 - p_l1) * (1.0 - p_l2) * (1.0 - p_c) * 0.5 * 0.2 * 0.25;  %guess color, letter out of 5, letter out of 4

p = case1 + case2 + case3 + case4 + case5 + case6 + case7 + case8;

p = p * (1.0 - lapse) + lapse * guess;
return
end

function p = probabilityCorrect_whole_both_r(probFun, fitVariables, guess, lapse)
p_l1 = probFun(fitVariables);
p_l2 = probFun(fitVariables);
p_c = probFun(fitVariables);

case1 = p_l1 * p_l2 * p_c                 * 0;
case2 = p_l1 * p_l2 * (1.0 - p_c)         * 0.5;                %guess color
case3 = p_l1 * (1.0 - p_l2) * p_c         * 0;
case4 = p_l1 * (1.0 - p_l2) * (1.0 - p_c) * 0.5 * 0.25;         %guess color, letter out of 4
case5 = (1.0 - p_l1) * p_l2 * p_c         * 0;
case6 = (1.0 - p_l1) * p_l2 * (1.0 - p_c) * 0.5 * 0.25;         %guess color, letter out of 4
case7 = (1.0 - p_l1) * (1.0 - p_l2) * p_c * 0;
case8 = (1.0 - p_l1) * (1.0 - p_l2) * (1.0 - p_c) * 0.5 * 0.2 * 0.25;  %guess color, letter out of 5, letter out of 4

p = case1 + case2 + case3 + case4 + case5 + case6 + case7 + case8;
p = p * (1.0 - lapse) + lapse * guess;
return
end

function p = probabilityCorrect_whole_one(probFun, fitVariables, guess, lapse)
p_l1 = probFun(fitVariables);
p_l2 = probFun(fitVariables);
p_c = probFun(fitVariables);

case1 = p_l1 * p_l2 * p_c                 * 0;
case2 = p_l1 * p_l2 * (1.0 - p_c)         * 0;
case3 = p_l1 * (1.0 - p_l2) * p_c         * 0.75;               %miss other letter
case4 = p_l1 * (1.0 - p_l2) * (1.0 - p_c) * 0.5 * 0.75;         %miss color, miss other letter
case5 = (1.0 - p_l1) * p_l2 * p_c         * 0;
case6 = (1.0 - p_l1) * p_l2 * (1.0 - p_c) * 0;
case7 = (1.0 - p_l1) * (1.0 - p_l2) * p_c * 0.25 * 0.8;         %guess letter out of 4, miss letter out of 5 ORDER MATTERS?
case8 = (1.0 - p_l1) * (1.0 - p_l2) * (1.0 - p_c) * 0.5 * 0.25 * 0.8;  %miss color, guess letter out of 4, miss letter out of 5

p = case1 + case2 + case3 + case4 + case5 + case6 + case7 + case8;

p = p * (1.0 - lapse) + lapse * guess;
return
end

function p = probabilityCorrect_whole_one_r(probFun, fitVariables, guess, lapse)
p_l1 = probFun(fitVariables);
p_l2 = probFun(fitVariables);
p_c = probFun(fitVariables);

case1 = p_l1 * p_l2 * p_c                 * 0;
case2 = p_l1 * p_l2 * (1.0 - p_c)         * 0;
case3 = p_l1 * (1.0 - p_l2) * p_c         * 0;
case4 = p_l1 * (1.0 - p_l2) * (1.0 - p_c) * 0;
case5 = (1.0 - p_l1) * p_l2 * p_c         * 0;
case6 = (1.0 - p_l1) * p_l2 * (1.0 - p_c) * 0.5 * 0.75;         %miss color, miss letter out of 4
case7 = (1.0 - p_l1) * (1.0 - p_l2) * p_c * 0;
case8 = (1.0 - p_l1) * (1.0 - p_l2) * (1.0 - p_c) * 0.5 * 0.25 * 0.8;  %miss color, guess letter out of 4, miss letter out of 5

p = case1 + case2 + case3 + case4 + case5 + case6 + case7 + case8;

p = p * (1.0 - lapse) + lapse * guess;
return
end

function p = logistic(fitVariables)
e = fitVariables(1);
e0 = fitVariables(2);
k = fitVariables(3);
p = 1.0/(1.0 + exp(-k*(e-e0)));
return
end

