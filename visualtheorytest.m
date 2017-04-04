% Clear the workspace and the screen
close all;
clearvars;
sca;
KbName('UnifyKeyNames');

testNumber = '001';
expTrials = 20;           %number of trials per exposure duration

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

% Define COLORS
fade_text = 0.4;
fade_stimulus = 0.3050;
indistinct_maxValue = 0.7275;
red_d =   [1.0 0 0] * fade_text;
green_d = [0 1.0 0] * fade_text;
red_i =   [1.0 0 0] * indistinct_maxValue;
green_i = [0 1.0 0] * indistinct_maxValue;
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
expFraction = 0.95;

exp1 = 3.0 * expStep * expFraction;
exp2 = 4.0 * expStep * expFraction;
exp3 = 5.0 * expStep * expFraction;
exp4 = 6.0 * expStep * expFraction;
exp5 = 8.0 * expStep * expFraction;
expDurations = [exp5 exp4 exp3 exp2 exp1];
%expDurations = expDurations(randperm(size(expDurations, 2)));

%KEYBOARD Queue
ListenChar(-1);
KbQueueCreate();
HideCursor(screenNumber)
%function results = runTrials(introMsg, window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, stimulusColors, answerBoth, results, questions, saveName, testNumber, expTrials, greyVal)

results_distinct_single_red = runTrials('Distinct - single RED', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, [red_d; green_d], 0, zeros(size(expDurations, 2), expTrials, 4), {'RED letter?'}, '_results_distinct_single_red', testNumber, expTrials, greyVal, 0);
results_distinct_single_green = runTrials('Distinct - single GREEN', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, [green_d; red_d], 0, zeros(size(expDurations, 2), expTrials, 4), {'GREEN letter?'}, '_results_distinct_single_green', testNumber, expTrials, greyVal, 0);
results_distinct_partial_red = runTrials('Distinct - partial RED', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, [red_d; green_d], 0, zeros(size(expDurations, 2), expTrials, 5), {'RED letter?'}, '_results_distinct_partial_red', testNumber, expTrials, greyVal, 1);
results_distinct_partial_green = runTrials('Distinct - partial GREEN', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, [green_d; red_d], 0, zeros(size(expDurations, 2), expTrials, 5), {'GREEN letter?'}, '_results_distinct_partial_green', testNumber, expTrials, greyVal, 1);
results_distinct_whole_red_green = runTrials('Distinct - whole RED-GREEN', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, [red_d; green_d], 1, zeros(size(expDurations, 2), expTrials, 7), {'RED letter?', 'GREEN letter?'}, '_results_distinct_whole_red_green', testNumber, expTrials, greyVal, 1);
results_distinct_whole_green_red = runTrials('Distinct - whole GREEN-RED', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, [green_d; red_d], 1, zeros(size(expDurations, 2), expTrials, 7), {'GREEN letter?', 'RED letter?'}, '_results_distinct_whole_green_red', testNumber, expTrials, greyVal, 1);

results_indistinct_single_red = runTrials('Indistinct - single RED', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, mixRedGreen([red_i; green_i], fade_stimulus), 0, zeros(size(expDurations, 2), expTrials, 4), {'RED letter?'}, '_results_indistinct_single_red', testNumber, expTrials, greyVal, 0);
results_indistinct_single_green = runTrials('Indistinct - single GREEN', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, mixRedGreen([green_i; red_i], fade_stimulus), 0, zeros(size(expDurations, 2), expTrials, 4), {'GREEN letter?'}, '_results_indistinct_single_green', testNumber, expTrials, greyVal, 0);
results_indistinct_partial_red = runTrials('Indistinct - partial RED', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, mixRedGreen([red_i; green_i], fade_stimulus), 0, zeros(size(expDurations, 2), expTrials, 5), {'RED letter?'}, '_results_indistinct_partial_red', testNumber, expTrials, greyVal, 1);
results_indistinct_partial_green = runTrials('Indistinct - partial GREEN', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, mixRedGreen([green_i; red_i], fade_stimulus), 0, zeros(size(expDurations, 2), expTrials, 5), {'GREEN letter?'}, '_results_indistinct_partial_green', testNumber, expTrials, greyVal, 1);
results_indistinct_whole_red_green = runTrials('Indistinct - whole RED-GREEN', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, mixRedGreen([red_i; green_i], fade_stimulus), 1, zeros(size(expDurations, 2), expTrials, 7), {'RED letter?', 'GREEN letter?'}, '_results_indistinct_whole_red_green', testNumber, expTrials, greyVal, 1);
results_indistinct_whole_green_red = runTrials('Indistinct - whole GREEN-RED', window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, mixRedGreen([green_i; red_i], fade_stimulus), 1, zeros(size(expDurations, 2), expTrials, 7), {'GREEN letter?', 'RED letter?'}, '_results_indistinct_whole_green_red', testNumber, expTrials, greyVal, 1);

ShowCursor(screenNumber)
KbQueueRelease;
%ListenChar(0);
sca;
disp(expDurations);


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

function letterSequence = generateLetterSequence(letters, expdurations)
numLetters = size(letters, 2);
letterSequence = zeros(expdurations, numLetters*(numLetters-1), 2);
for i = 1:expdurations
    for a = 1:numLetters
        count = 1;
        for b = 1:numLetters - 1      
            letterSequence(i, b + (a-1)*(numLetters-1), 1) = a;
            if count == a; count = count + 1; end
            letterSequence(i, b + (a-1)*(numLetters-1), 2) = count;
            count = count + 1;
        end
    end
    perm = randperm(numLetters*(numLetters-1));
    letterSequence(i, :, 1) = letterSequence(i, perm, 1);
    letterSequence(i, :, 2) = letterSequence(i, perm, 2);
end
return
end

function vbl = showTrialInformation(message, window, position, color)
KbQueueStart();
Screen('TextSize', window, 80);
DrawFormattedText(window, message, 'center', 'center', color);
Screen('TextSize', window, 70);
DrawFormattedText(window, 'Press ENTER to continue', 'center', position, color);
vbl = Screen('Flip', window);

getKeys([KbName('return')], 0);
KbQueueStop();
return
end

function [key, time] = getResponseOneAnswer(window, waitduration, messageSize, fade_text, acceptedKeys, questionText)
if waitduration > 0
    [key, time] = getKeys(acceptedKeys, waitduration);
    if time > 0; return; end
end
Screen('Flip', window);
Screen('TextSize', window, messageSize);
DrawFormattedText(window, questionText, 'center', 'center', [1 1 1]*fade_text);
Screen('Flip', window);

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
                if pressedCodes(i) == acceptedKey
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

function results = runTrials(introMsg, window, expDurations, startingPositions, yCenter, fade_text, stimulusSize, stimulusColors, answerBoth, results, questions, saveName, testNumber, expTrials, greyVal, twoColors)
white = [1 1 1];
showTrialInformation(introMsg, window, yCenter*1.4, white*fade_text);

letters = ['A' 'E' 'I' 'O' 'U'];
acceptedKeys = [KbName('a') KbName('e') KbName('i') KbName('o') KbName('u') KbName('ESCAPE')];
letterSequence = generateLetterSequence(letters, size(expDurations, 2));

stopProgram = 0;
letterBoxX = 46;
letterBoxY = 53;

primeToTrialDelay = 1.0; %delay between focus char appearrance and trial
focusChar = '+';
focusCharColor = fade_text * [1.0 1.0 1.0];
left = startingPositions(1);
right = startingPositions(2);

maskSymbols = ['-' '|' '^' '<' '\' '*' '~' '&' '=' '{' '[' ']' '}'];
maskFontSize = 70;
maskDur = 2.0; 

for e = 1:size(expDurations, 2)
    if(stopProgram); break; end
    for t = 1:expTrials
        if(stopProgram); break; end
        maskImg = generateMask(maskSymbols, stimulusColors, maskFontSize, letterBoxX, letterBoxY, greyVal);
        dstRects1 = [left - letterBoxX*1.5, yCenter - letterBoxY*1.5, left + letterBoxX*1.5, yCenter + letterBoxY*1.5];
        dstRects2 = [right - letterBoxX*1.5, yCenter - letterBoxY*1.5, right + letterBoxX*1.5, yCenter + letterBoxY*1.5];
        
        positions = startingPositions(randperm(2));
        %twoColors = size(stimulusColors, 1) == 2;
        expduration = expDurations(e);
        
        L1 = letters(letterSequence(e, t, 1));
        P1 = positions(1);
        C1 = stimulusColors(1, :);
        
        if twoColors
            L2 = letters(letterSequence(e, t, 2));
            P2 = positions(2);
            C2 = stimulusColors(2, :);
        end
        
        textureIndex=Screen('MakeTexture', window, maskImg);      
         
        Screen('TextSize', window, 50);
        DrawFormattedText(window, focusChar, 'center', 'center', focusCharColor);
        vbl = Screen('Flip', window); %SHOW FOCUS
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
        
        results(e, t, 1) = expDurations(e); %exposure duration
        results(e, t, 2) = lower(letters(letterSequence(e, t, 1))); %stimulus 1
        results(e, t, 3) = key1; %answer 1
        results(e, t, 4) = time1 - time_start; %response time 1
        if (size(stimulusColors, 1)) == 2
            results(e, t, 5) = lower(letters(letterSequence(e, t, 2))); %stimulus 2
        end
        if(answerBoth)
            results(e, t, 6) = key2; %answer 2
            results(e, t, 7) = time2 - time_start;  %response time 2   
        end
        Screen('Close', [textureIndex]);
    end
end
save(strcat('data/', testNumber, saveName), 'results');
return
end