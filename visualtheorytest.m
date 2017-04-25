% Clear the workspace and the screen
close all;
clearvars;
sca;
KbName('UnifyKeyNames');

testNumber = '005';
global redFirst;
redFirst = 1;
expTrials = 20;           %number of trials per exposure duration, must be EVEN number

%screenDiag = 31.75; %LAPTOP diagonal in cm
screenDiag = sqrt(34.^2 + 26.^2); %CRT diagonal in cm

screenPixelsX = 1280.0;
screenPixelsY = 1024.0;
screenPixelsDiag = sqrt(screenPixelsX.^2 + screenPixelsY.^2);
cmPerPixel = screenDiag/screenPixelsDiag;

screenCmX = screenPixelsX * cmPerPixel;
screenCmY = screenPixelsY * cmPerPixel;
letterDisplacement = 10.0; %cm

stimulusSize = 70;       %text size for the stimulus letters
%stimulusPositionCorrection = 0.47 / cmPerPixel; %calibrated for LAPTOP 
stimulusPositionCorrection = 0.5875 / cmPerPixel; %calibrated for CRT


PsychDefaultSetup(2);

screens = Screen('Screens');
screenNumber = max(screens);

% Define COLORSexpduration
fade_text = 0.4;
%indistinct_maxValue = 0.7275;
indistinct_maxValue = 1.0;
fade_stimulus = 0.8 * (indistinct_maxValue/2.0);
red_d =   [1.0 0.0 0.0] * fade_text;
green_d = [0.0 1.0 0.0] * fade_text;
red_i =   [1.0 0.0 0.0] * indistinct_maxValue;
green_i = [0.0 1.0 0.0] * indistinct_maxValue;
greyVal = 0.25;

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, [greyVal greyVal greyVal]);
Priority(1);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);
left = xCenter - letterDisplacement/cmPerPixel - stimulusPositionCorrection;
right = xCenter + letterDisplacement/cmPerPixel - stimulusPositionCorrection;
startingPositions = [left right];
hz=Screen('NominalFrameRate', window);
expStep = 1.0/hz;
expFraction = 0.1;

global expFlipSafetyDuration;
expFlipSafetyDuration = (expStep * expFraction);
exp1 = 2.0 * expStep;
exp2 = 3.0 * expStep;
exp3 = 4.0 * expStep;
exp4 = 5.0 * expStep;
exp5 = 6.0 * expStep;
exp6 = 7.0 * expStep;
expDurations = [exp6 exp5 exp4 exp3 exp2 exp1];
trainingExpDurations = [exp6, exp4];
%expDurations = [exp6];

%KEYBOARD Queue
ListenChar(-1);
KbQueueCreate();
HideCursor(screenNumber);
global stopProgram;
stopProgram = 0;

%function results = runTrials(introMsg, window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, stimulusColors, answerBoth, results, questions, saveName, testNumber, expTrials, greyVal)

if redFirst
    %results_training_distinct_whole_red_green = training('TRAINING: Distinct RED-GREEN', window, trainingExpDurations, startingPositions, yCenter, fade_text, stimulusSize, [red_d; green_d], 1, zeros(size(expDurations, 2), expTrials, 7), {'RED letter?', 'GREEN letter?'}, '_results_training_distinct_whole_red_green', testNumber, expTrials, greyVal, 1, 1);
    
    results_distinct_single_red = runTrials('Distinct - single RED', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, [red_d; green_d], 0, zeros(size(expDurations, 2), expTrials, 4), {'RED letter?'}, '_results_distinct_single_red', testNumber, expTrials, greyVal, 0, 0);
    results_distinct_single_green = runTrials('Distinct - single GREEN', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, [green_d; red_d], 0, zeros(size(expDurations, 2), expTrials, 4), {'GREEN letter?'}, '_results_distinct_single_green', testNumber, expTrials, greyVal, 0, 0);
    results_distinct_partial_red = runTrials('Distinct - partial RED', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, [red_d; green_d], 0, zeros(size(expDurations, 2), expTrials, 5), {'RED letter?'}, '_results_distinct_partial_red', testNumber, expTrials, greyVal, 1, 0);
    results_distinct_partial_green = runTrials('Distinct - partial GREEN', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, [green_d; red_d], 0, zeros(size(expDurations, 2), expTrials, 5), {'GREEN letter?'}, '_results_distinct_partial_green', testNumber, expTrials, greyVal, 1, 0);
    results_distinct_whole_red_green = runTrials('Distinct - whole RED-GREEN', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, [red_d; green_d], 1, zeros(size(expDurations, 2), expTrials, 7), {'RED letter?', 'GREEN letter?'}, '_results_distinct_whole_red_green', testNumber, expTrials, greyVal, 1, 0);
    results_distinct_whole_green_red = runTrials('Distinct - whole GREEN-RED', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, [green_d; red_d], 1, zeros(size(expDurations, 2), expTrials, 7), {'GREEN letter?', 'RED letter?'}, '_results_distinct_whole_green_red', testNumber, expTrials, greyVal, 1, 0);
 
    results_training_indistinct_whole_red_green = training('TRAINING: Indistinct RED-GREEN', window, trainingExpDurations, startingPositions, yCenter, fade_text, stimulusSize, mixRedGreen([red_i; green_i], fade_stimulus), 1, zeros(size(expDurations, 2), expTrials, 7), {'RED letter?', 'GREEN letter?'}, '_results_training_indistinct_whole_red_green', testNumber, expTrials, greyVal, 1, 1);
    
    results_indistinct_single_red = runTrials('Indistinct - single RED', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, mixRedGreen([red_i; green_i], fade_stimulus), 0, zeros(size(expDurations, 2), expTrials, 4), {'RED letter?'}, '_results_indistinct_single_red', testNumber, expTrials, greyVal, 0, 0);
    results_indistinct_single_green = runTrials('Indistinct - single GREEN', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, mixRedGreen([green_i; red_i], fade_stimulus), 0, zeros(size(expDurations, 2), expTrials, 4), {'GREEN letter?'}, '_results_indistinct_single_green', testNumber, expTrials, greyVal, 0, 0);
    results_indistinct_partial_red = runTrials('Indistinct - partial RED', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, mixRedGreen([red_i; green_i], fade_stimulus), 0, zeros(size(expDurations, 2), expTrials, 5), {'RED letter?'}, '_results_indistinct_partial_red', testNumber, expTrials, greyVal, 1, 0);
    results_indistinct_partial_green = runTrials('Indistinct - partial GREEN', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, mixRedGreen([green_i; red_i], fade_stimulus), 0, zeros(size(expDurations, 2), expTrials, 5), {'GREEN letter?'}, '_results_indistinct_partial_green', testNumber, expTrials, greyVal, 1, 0);
    results_indistinct_whole_red_green = runTrials('Indistinct - whole RED-GREEN', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, mixRedGreen([red_i; green_i], fade_stimulus), 1, zeros(size(expDurations, 2), expTrials, 7), {'RED letter?', 'GREEN letter?'}, '_results_indistinct_whole_red_green', testNumber, expTrials, greyVal, 1, 0);
    results_indistinct_whole_green_red = runTrials('Indistinct - whole GREEN-RED', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, mixRedGreen([green_i; red_i], fade_stimulus), 1, zeros(size(expDurations, 2), expTrials, 7), {'GREEN letter?', 'RED letter?'}, '_results_indistinct_whole_green_red', testNumber, expTrials, greyVal, 1, 0);
else
    results_training_distinct_whole_green_red = training('TRAINING: Distinct GREEN-RED', window, trainingExpDurations, startingPositions, yCenter, fade_text, stimulusSize, [green_d; red_d], 1, zeros(size(expDurations, 2), expTrials, 7), {'GREEN letter?', 'RED letter?'}, '_results_training_distinct_whole_green_red', testNumber, expTrials, greyVal, 1, 1);
    
    results_distinct_single_green = runTrials('Distinct - single GREEN', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, [green_d; red_d], 0, zeros(size(expDurations, 2), expTrials, 4), {'GREEN letter?'}, '_results_distinct_single_green', testNumber, expTrials, greyVal, 0, 0);
    results_distinct_single_red = runTrials('Distinct - single RED', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, [red_d; green_d], 0, zeros(size(expDurations, 2), expTrials, 4), {'RED letter?'}, '_results_distinct_single_red', testNumber, expTrials, greyVal, 0, 0);
    results_distinct_partial_green = runTrials('Distinct - partial GREEN', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, [green_d; red_d], 0, zeros(size(expDurations, 2), expTrials, 5), {'GREEN letter?'}, '_results_distinct_partial_green', testNumber, expTrials, greyVal, 1, 0);
    results_distinct_partial_red = runTrials('Distinct - partial RED', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, [red_d; green_d], 0, zeros(size(expDurations, 2), expTrials, 5), {'RED letter?'}, '_results_distinct_partial_red', testNumber, expTrials, greyVal, 1, 0);
    results_distinct_whole_green_red = runTrials('Distinct - whole GREEN-RED', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, [green_d; red_d], 1, zeros(size(expDurations, 2), expTrials, 7), {'GREEN letter?', 'RED letter?'}, '_results_distinct_whole_green_red', testNumber, expTrials, greyVal, 1, 0);
    results_distinct_whole_red_green = runTrials('Distinct - whole RED-GREEN', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, [red_d; green_d], 1, zeros(size(expDurations, 2), expTrials, 7), {'RED letter?', 'GREEN letter?'}, '_results_distinct_whole_red_green', testNumber, expTrials, greyVal, 1, 0);
    
    results_training_indistinct_whole_green_red = training('TRAINING: Indistinct GREEN-RED', window, trainingExpDurations, startingPositions, yCenter, fade_text, stimulusSize, mixRedGreen([green_i; red_i], fade_stimulus), 1, zeros(size(expDurations, 2), expTrials, 7), {'GREEN letter?', 'RED letter?'}, '_results_training_indistinct_whole_green_red', testNumber, expTrials, greyVal, 1, 1);
    
    results_indistinct_single_green = runTrials('Indistinct - single GREEN', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, mixRedGreen([green_i; red_i], fade_stimulus), 0, zeros(size(expDurations, 2), expTrials, 4), {'GREEN letter?'}, '_results_indistinct_single_green', testNumber, expTrials, greyVal, 0, 0);
    results_indistinct_single_red = runTrials('Indistinct - single RED', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, mixRedGreen([red_i; green_i], fade_stimulus), 0, zeros(size(expDurations, 2), expTrials, 4), {'RED letter?'}, '_results_indistinct_single_red', testNumber, expTrials, greyVal, 0, 0);
    results_indistinct_partial_green = runTrials('Indistinct - partial GREEN', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, mixRedGreen([green_i; red_i], fade_stimulus), 0, zeros(size(expDurations, 2), expTrials, 5), {'GREEN letter?'}, '_results_indistinct_partial_green', testNumber, expTrials, greyVal, 1, 0);
    results_indistinct_partial_red = runTrials('Indistinct - partial RED', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, mixRedGreen([red_i; green_i], fade_stimulus), 0, zeros(size(expDurations, 2), expTrials, 5), {'RED letter?'}, '_results_indistinct_partial_red', testNumber, expTrials, greyVal, 1, 0);
    results_indistinct_whole_green_red = runTrials('Indistinct - whole GREEN-RED', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, mixRedGreen([green_i; red_i], fade_stimulus), 1, zeros(size(expDurations, 2), expTrials, 7), {'GREEN letter?', 'RED letter?'}, '_results_indistinct_whole_green_red', testNumber, expTrials, greyVal, 1, 0);
    results_indistinct_whole_red_green = runTrials('Indistinct - whole RED-GREEN', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, mixRedGreen([red_i; green_i], fade_stimulus), 1, zeros(size(expDurations, 2), expTrials, 7), {'RED letter?', 'GREEN letter?'}, '_results_indistinct_whole_red_green', testNumber, expTrials, greyVal, 1, 0);   
end

ShowCursor(screenNumber);
KbQueueRelease;
%ListenChar(0);
sca;
%disp(expDurations);


function mixedRedGreen = mixRedGreen(colors, fade)
r1 = colors(1, 1);
g1 = colors(1, 2);
b1 = colors(1, 3);
r2 = colors(2, 1);
g2 = colors(2, 2);
b2 = colors(2, 3);
if (r1 > r2) %first color is red
    mixedRedGreen = [[r1-fade g1+fade b1]; [r2+fade g2-fade b2]];
else %first color is green
    mixedRedGreen = [[r1+fade g1-fade b1]; [r2-fade g2+fade b2]];
end
return
end

function trialSequence = generateTrialSequence(letters, expDurations, expTrials, startingPositions)
left = startingPositions(1);
right = startingPositions(2);
numLetters = size(letters, 2);
numExpDurations = size(expDurations, 2);
trialSequence = zeros(numExpDurations * expTrials, 5);

%Insert Letter Sequence
for i = 1:numExpDurations
    for a = 1:numLetters
        count = 1;
        for b = 1:numLetters - 1      
            trialSequence(b + (a-1)*(numLetters-1) + (i-1)*expTrials, 1) = a;
            if count == a; count = count + 1; end
            trialSequence(b + (a-1)*(numLetters-1) + (i-1)*expTrials, 2) = count;
            count = count + 1;
        end
    end
end

%Insert positions (needs additional randomization)
for e = 1:numExpDurations*expTrials
    if e <= numExpDurations*expTrials/2
        trialSequence(e, 3) = left;
        trialSequence(e, 4) = right;
    else
        trialSequence(e, 3) = right;
        trialSequence(e, 4) = left;
    end
end

%Insert exposure duration
for i = 1:numExpDurations
    for t = 1:expTrials
        trialSequence(t + (i-1)*expTrials, 5) = expDurations(i);
    end
end
permPositions = randperm(numExpDurations*expTrials);
trialSequence(:, 3) = trialSequence(permPositions, 3);
trialSequence(:, 4) = trialSequence(permPositions, 4);

permGeneral = randperm(numExpDurations*expTrials);
trialSequence(:, 1) = trialSequence(permGeneral, 1);
trialSequence(:, 2) = trialSequence(permGeneral, 2);
trialSequence(:, 3) = trialSequence(permGeneral, 3);
trialSequence(:, 4) = trialSequence(permGeneral, 4);
trialSequence(:, 5) = trialSequence(permGeneral, 5);
return
end

function vbl = showTrialInformation(message, window, position, color)
ifi = Screen('GetFlipInterval', window);
KbQueueStart();
Screen('TextSize', window, 80);
DrawFormattedText(window, message, 'center', 'center', color);
Screen('TextSize', window, 70);
DrawFormattedText(window, 'Press ENTER to continue', 'center', position, color);
vbl = GetSecs();
vbl = Screen('Flip', window, vbl + ifi*0.75);

getKeys([KbName('return')], 0);
KbQueueStop();
return
end

function [key, time] = getResponseOneAnswer(window, waitduration, messageSize, fade_text, acceptedKeys, questionText)
if waitduration > 0
    [key, time] = getKeys(acceptedKeys, waitduration);
    if time > 0; return; end
end
ifi = Screen('GetFlipInterval', window);
vbl = GetSecs();
vbl = Screen('Flip', window, vbl + ifi*0.75);
Screen('TextSize', window, messageSize);
DrawFormattedText(window, questionText, 'center', 'center', [1 1 1]*fade_text);
Screen('Flip', window, vbl + ifi*0.75);

[key, time] = getKeys(acceptedKeys, 0);
return;
end

function drawFocusChar(window, focusChar, focusCharColor)
Screen('TextSize', window, 50);
DrawFormattedText(window, focusChar, 'center', 'center', focusCharColor);
end

function [key, time] = getKeys(acceptedKeys, maxWait)
timeStart = GetSecs();
pressed = 0;
keyAccepted = 0;
key = 0;
time = 0;

while (~pressed)
    [pressed, firstPress]=KbQueueCheck;
    if pressed
        pressedCodes=find(firstPress);
        for i=1:size(pressedCodes,2)
            for acceptedKey = acceptedKeys
                if (pressedCodes(i) == acceptedKey)
                    key = KbName(pressedCodes(i));
                    time = firstPress(pressedCodes(i));
                    keyAccepted = 1;
                    break;
                end
            end
        end
    end
    if ~keyAccepted; pressed = 0; end
    if maxWait > 0 & GetSecs() - timeStart >= maxWait;
        break;
    end
end
return
end

function results = training(introMsg, window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, stimulusColors, answerBoth, results, questions, saveName, testNumber, expTrials, greyVal, twoColors, giveFeedback)
global stopProgram;
global redFirst;
if ~stopProgram
    white = [1 1 1];
    letters = ['A' 'E' 'I' 'O' 'U'];
    
    letterBoxX = 46;
    letterBoxY = 53;
    
    focusChar = '+';
    focusCharColor = fade_text * [1.0 1.0 1.0];
    left = startingPositions(1);
    right = startingPositions(2);
    
    maskSymbols = ['|' '^' '<' '>' '\' '/' '*' '~' '&' '=' '[' ']' '{' '}' '§' '¢' '×' '╬' 'X' '¤' 'Δ' 'љ' 'α' 'ж' 'Д' 'Њ' 'ф'];
    maskFontSize = 70; 
    
    dstRects1 = [left - letterBoxX*1.5, yCenter - letterBoxY*1.5, left + letterBoxX*1.5, yCenter + letterBoxY*1.5];
    dstRects2 = [right - letterBoxX*1.5, yCenter - letterBoxY*1.5, right + letterBoxX*1.5, yCenter + letterBoxY*1.5];
    
    trainingInfoSize = 60;
    
    maskImg = generateMask(maskSymbols, stimulusColors, maskFontSize, letterBoxX, letterBoxY, greyVal);
    textureIndex=Screen('MakeTexture', window, maskImg); 
    
    KbQueueStart();
    Screen('TextSize', window, trainingInfoSize);
    DrawFormattedText(window, introMsg, 'center', yCenter*0.6, white*fade_text);
    DrawFormattedText(window, 'Hello and welcome to the training session.\nOn the following screens, you can press\nENTER to continue.', 'center', yCenter*1.4, white*fade_text);
    Screen('Flip', window);
    getKeys([KbName('return')], 0);
    KbQueueStop();

    KbQueueStart();
    Screen('TextSize', window, trainingInfoSize);
    DrawFormattedText(window, 'The first thing you will see is the + sign\nas shown below:', 'center', yCenter*0.6, white*fade_text);
    DrawFormattedText(window, 'During the session, you need to\nlook directly at it.', 'center', yCenter*1.4, white*fade_text);
    Screen('TextSize', window, 50);
    DrawFormattedText(window, focusChar, 'center', 'center', focusCharColor);
    Screen('Flip', window);
    getKeys([KbName('return')], 0);
    KbQueueStop();

    KbQueueStart();
    Screen('TextSize', window, trainingInfoSize);
    DrawFormattedText(window, 'After 1 second, a letter appears\nboth to the left and right\nof the + sign', 'center', yCenter*0.6, white*fade_text);
    DrawFormattedText(window, 'One letter is green, the other red', 'center', yCenter*1.4, white*fade_text);
    Screen('TextSize', window, 50);
    DrawFormattedText(window, focusChar, 'center', 'center', focusCharColor);
    Screen('TextSize', window, stimulusSize);
    randomLetters = letters(randperm(size(letters, 2)));
    DrawFormattedText(window, randomLetters(1), left, 'center', stimulusColors(1, :));
    DrawFormattedText(window, randomLetters(2), right, 'center', stimulusColors(2, :));
    Screen('Flip', window);
    getKeys([KbName('return')], 0);
    KbQueueStop();

    KbQueueStart();
    Screen('TextSize', window, trainingInfoSize);
    DrawFormattedText(window, 'But whether red/green is left/right\nis random each time!', 'center', yCenter*0.6, white*fade_text);
    DrawFormattedText(window, 'In this test, the goal is to identify\nboth letters in the correct order', 'center', yCenter*1.4, white*fade_text);
    Screen('TextSize', window, 50);
    DrawFormattedText(window, focusChar, 'center', 'center', focusCharColor);
    Screen('TextSize', window, stimulusSize);
    DrawFormattedText(window, randomLetters(3), right, 'center', stimulusColors(1, :));
    DrawFormattedText(window, randomLetters(4), left, 'center', stimulusColors(2, :));
    Screen('Flip', window);
    getKeys([KbName('return')], 0);
    KbQueueStop();
    
    KbQueueStart();
    Screen('TextSize', window, 50);
    DrawFormattedText(window, 'You can tell the order from the name of the test:', 'center', yCenter*0.6, white*fade_text);
    DrawFormattedText(window, 'If it says RED              , report ONLY the red letter\nIf it says GREEN     , report ONLY the green letter\nIf it says RED-GREEN, report red first, then green\nIf it says GREEN-RED, report green first, then red', 'center', yCenter*1.4, white*fade_text);
    Screen('TextSize', window, trainingInfoSize);
    DrawFormattedText(window, introMsg, 'center', 'center', white*fade_text);
    Screen('Flip', window);
    getKeys([KbName('return')], 0);
    KbQueueStop();
    
    KbQueueStart();
    Screen('TextSize', window, trainingInfoSize);
    DrawFormattedText(window, 'The letters are followed by a mask', 'center', yCenter*0.6, white*fade_text);
    DrawFormattedText(window, 'The mask is not related to the letters shown', 'center', yCenter*1.4, white*fade_text);
    Screen('TextSize', window, 50);
    DrawFormattedText(window, focusChar, 'center', 'center', focusCharColor);
    Screen('DrawTextures', window, textureIndex, [], dstRects1, [], [], [], []);
    Screen('DrawTextures', window, textureIndex, [], dstRects2, [], [], [], []);
    Screen('Flip', window);
    getKeys([KbName('return')], 0);
    KbQueueStop();
    Screen('Close', [textureIndex]);
    
    KbQueueStart();
    Screen('TextSize', window, stimulusSize);
    DrawFormattedText(window, 'A E U I O', 'center', yCenter*0.9, stimulusColors(1, :));
    DrawFormattedText(window, 'A E U I O', 'center', yCenter*1.1, stimulusColors(2, :));
    Screen('TextSize', window, trainingInfoSize);
    DrawFormattedText(window, 'This is what the letters look like', 'center', yCenter*0.6, white*fade_text);
    Screen('Flip', window);
    getKeys([KbName('return')], 0);
    KbQueueStop();
    
    KbQueueStart();
    Screen('TextSize', window, trainingInfoSize);
    DrawFormattedText(window, 'Remember to focus on the + sign', 'center', yCenter*0.6, white*fade_text);
    DrawFormattedText(window, 'Ok then, lets start the test!', 'center', yCenter*1.4, white*fade_text);
    Screen('TextSize', window, 50);
    DrawFormattedText(window, focusChar, 'center', 'center', focusCharColor);
    Screen('Flip', window);
    getKeys([KbName('return')], 0);
    KbQueueStop();
end
results = runTrials(introMsg, window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, stimulusColors, answerBoth, results, questions, saveName, testNumber, expTrials, greyVal, twoColors, giveFeedback);
return
end

function results = runTrials(introMsg, window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, stimulusColors, answerBoth, results, questions, saveName, testNumber, expTrials, greyVal, twoColors, giveFeedback)
global stopProgram;
global redFirst;
global expFlipSafetyDuration;
white = [1 1 1];
if ~stopProgram
    showTrialInformation(introMsg, window, yCenter*1.4, white*fade_text);
end

letters = ['A' 'E' 'I' 'O' 'U'];
acceptedKeys = [KbName('a') KbName('e') KbName('i') KbName('o') KbName('u') KbName('ESCAPE')];
trialSequence = generateTrialSequence(letters, expDurations, expTrials, startingPositions);

letterBoxX = 46;
letterBoxY = 53;


primeToTrialDelay = 1.0; %delay between focus char appearrance and trial
focusChar = '+';
focusCharColor = fade_text * [1.0 1.0 1.0];
left = startingPositions(1);
right = startingPositions(2);

maskSymbols = ['|' '^' '<' '>' '\' '/' '*' '~' '&' '=' '[' ']' '{' '}' '§' '¢' '×' '╬' 'X' '¤' 'Δ' 'љ' 'α' 'ж' 'Д' 'Њ' 'ф'];
maskFontSize = 70;
maskDur = 2.0; 

dstRects1 = [left - letterBoxX*1.5, yCenter - letterBoxY*1.5, left + letterBoxX*1.5, yCenter + letterBoxY*1.5];
dstRects2 = [right - letterBoxX*1.5, yCenter - letterBoxY*1.5, right + letterBoxX*1.5, yCenter + letterBoxY*1.5];

for e = 1:size(expDurations, 2)
    if(stopProgram); break; end
    for t = 1:expTrials
        if(stopProgram); break; end
        ifi = Screen('GetFlipInterval', window);
        maskImg = generateMask(maskSymbols, stimulusColors, maskFontSize, letterBoxX, letterBoxY, greyVal);
        
        sequencePos = t + (e-1) * expTrials;
        expduration = trialSequence(sequencePos, 5) - expFlipSafetyDuration;
        L1 = letters(trialSequence(sequencePos, 1));
        P1 = trialSequence(sequencePos, 3);
        C1 = stimulusColors(1, :);
        
        if twoColors
            L2 = letters(trialSequence(sequencePos, 2));
            P2 = trialSequence(sequencePos, 4);
            C2 = stimulusColors(2, :);
        end
        
        textureIndex=Screen('MakeTexture', window, maskImg);      
         
        Screen('TextSize', window, 50);
        vbl = GetSecs();
        DrawFormattedText(window, focusChar, 'center', 'center', focusCharColor);
        vbl = Screen('Flip', window, vbl + ifi*0.75); %SHOW FOCUS
        DrawFormattedText(window, focusChar, 'center', 'center', focusCharColor);              
        
        Screen('TextSize', window, stimulusSize);
        DrawFormattedText(window, L1, P1, 'center', C1);
        if twoColors
            DrawFormattedText(window, L2, P2, 'center', C2);
        end

        time_start = Screen('Flip', window, vbl + primeToTrialDelay); %SHOW STIMULUS  
        KbQueueStart();
        
        Screen('TextSize', window, 50);
        DrawFormattedText(window, focusChar, 'center', 'center', focusCharColor);
        Screen('DrawTextures', window, textureIndex, [], dstRects1, [], [], [], []);
        Screen('DrawTextures', window, textureIndex, [], dstRects2, [], [], [], []);
        vbl = Screen('Flip', window, time_start + expduration); %SHOW MASK
        
        [key1, time1] = getResponseOneAnswer(window, maskDur, 100, fade_text, acceptedKeys, questions{1});
        if(key1 == KbName(KbName('ESCAPE'))); stopProgram = 1; break; end
        if answerBoth
            KbQueueStop();
            KbQueueStart();
            [key2, time2] = getResponseOneAnswer(window, maskDur - (time1 - time_start), 100, fade_text, acceptedKeys, questions{2});
            if(key2 == KbName(KbName('ESCAPE'))); stopProgram = 1; break; end
        end
        KbQueueStop();
        
        results(e, t, 1) = trialSequence(sequencePos, 5); %exposure duration
        results(e, t, 2) = lower(L1); %stimulus 1
        results(e, t, 3) = key1; %answer 1
        results(e, t, 4) = time1 - time_start; %response time 1
        if (twoColors)
            results(e, t, 5) = lower(L2); %stimulus 2
        end
        if(answerBoth)
            results(e, t, 6) = key2; %answer 2
            results(e, t, 7) = time2 - time_start;  %response time 2   
        end
        Screen('Close', [textureIndex]);
        
        if giveFeedback
            Screen('TextSize', window, stimulusSize);
            if key1 == lower(L1)
                DrawFormattedText(window, '1st letter: Correct!', 'center', yCenter*0.9, white*fade_text);
            elseif twoColors & key1 == lower(L2);
                DrawFormattedText(window, '1st letter: Reversed.', 'center', yCenter*0.9, white*fade_text);
            else
                DrawFormattedText(window, '1st letter: Incorrect.', 'center', yCenter*0.9, white*fade_text);
            end
            if answerBoth
                if key2 == lower(L2)
                    DrawFormattedText(window, '2nd letter: Correct!', 'center', yCenter*1.1, white*fade_text);
                elseif key2 == lower(L1);
                    DrawFormattedText(window, '2nd letter: Reversed.', 'center', yCenter*1.1, white*fade_text);
                else
                    DrawFormattedText(window, '2nd letter: Incorrect.', 'center', yCenter*1.1, white*fade_text);
                end
            end
            vbl = Screen('Flip', window);
            Screen('Flip', window, vbl + 1.0);
        end
    end
end

if redFirst
    save(strcat('data/redFirst/', testNumber, saveName), 'results');
else
    save(strcat('data/greenFirst/', testNumber, saveName), 'results');
end
return
end