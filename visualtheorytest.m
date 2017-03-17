% Clear the workspace and the screen

close all;
clearvars;
sca;
KbName('UnifyKeyNames');
expDurations = [0.1];

screenDiag = 31.75 * 1.25; %cm
screenPixelsX = 1280.0;
screenPixelsY = 1024.0;
screenPixelsDiag = sqrt(screenPixelsX.^2 + screenPixelsY.^2);
cmPerPixel = screenDiag/screenPixelsDiag;

screenCmX = screenPixelsX * cmPerPixel;
screenCmY = screenPixelsY * cmPerPixel;
letterDisplacement = 10.0; %cm


expTrials = 20;           %number of trials per exposure duration
primeDur = 1.0;          %time to show the priming symbol
%primeToTrialDelay = 2.0; %delay between prime symbol dissapearance and trial
primeChar = '+';
maskDur = 2.0;           %duration the mask is shown
stimulusSize = 70;       %text size for the stimulus letters
stimulusPositionCorrection = 0.47 / cmPerPixel;

data_responses = 1;
data_duration = 2;
data_time = 3;

escapeKey = KbName('ESCAPE');
stopProgram = 0;


letters = ['A' 'E' 'I' 'O' 'U'];
acceptedKeys = [KbName('a') KbName('e') KbName('i') KbName('o') KbName('u') KbName('ESCAPE')];
numLetters = size(letters, 2);

expDurations = expDurations(randperm(size(expDurations, 2)));
typeRedLetter = 'Please press symbol of the RED letter';
typeGreenLetter = 'Please press the symbol of the GREEN letter';

PsychDefaultSetup(2);

screens = Screen('Screens');
screenNumber = max(screens);

% Define COLORS
black = BlackIndex(screenNumber);
white = [1 1 1];
fade_text = 0.87;
fade_stimulus = 0.48;
red = [1.0 0 0];
green = [0 1.0 0];
grey = white / 2;

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);
Priority(1);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);
left = xCenter - letterDisplacement/cmPerPixel - stimulusPositionCorrection;
right = xCenter + letterDisplacement/cmPerPixel - stimulusPositionCorrection;
startingPositions = [left right];
leftToRight = right - left;

data_distinct_single_red = zeros(3, size(expDurations, 2), expTrials);

%MASK
maskSymbols = ['-' '|' '^' '<' '\' '*' '~' '&' '=' '{' '[' ']' '}'];
maskFontSize = 70;

%KEYBOARD Queue
ListenChar(-1);
KbQueueCreate();
testNumber = '002';

%function results = runTrials(window, letters, acceptedKeys, expDurations, startingPositions, yCenter, fade_stimulus, fade_text, stimulusSize, maskSymbols, maskFontSize, stimulusColors, answerBoth, results, questions)

%{
%Distinct SINGLE Green
showTrialInformation('Distinct - single GREEN', window, yCenter*1.4, white*fade_text);
results_distinct_single_green = runTrials(window, letters, acceptedKeys, expDurations, startingPositions, yCenter, fade_text, fade_text, stimulusSize, maskSymbols, maskFontSize, [green], 0, zeros(size(expDurations, 2), expTrials, 4), {'GREEN letter?'});
save(strcat('data/', testNumber, '_results_distinct_single_green'), 'results_distinct_single_green');
%}

%{
%Distinct WHOLE Red-Green
showTrialInformation('Distinct - whole RED-GREEN', window, yCenter*1.4, white*fade_text);
results_distinct_whole_red_green = runTrials(window, letters, acceptedKeys, expDurations, startingPositions, yCenter, fade_text, fade_text, stimulusSize, maskSymbols, maskFontSize, [red; green], 1, zeros(size(expDurations, 2), expTrials, 7), {'RED letter?', 'GREEN letter?'});
save(strcat('data/', testNumber, '_results_distinct_whole_red_green'), 'results_distinct_whole_red_green');
%}

%{
%Indistinct SINGLE Green
showTrialInformation('Indistinct - single GREEN', window, yCenter*1.4, white*fade_text);
results_indistinct_single_green = runTrials(window, letters, acceptedKeys, expDurations, startingPositions, yCenter, fade_stimulus, fade_text, stimulusSize, maskSymbols, maskFontSize, [green], 0, zeros(size(expDurations, 2), expTrials, 4), {'GREEN letter?'});
save(strcat('data/', testNumber, '_results_indistinct_single_green'), 'results_indistinct_single_green');
%}


%Indistinct WHOLE Red-Green
showTrialInformation('Indistinct - whole RED-GREEN', window, yCenter*1.4, white*fade_text);
results_indistinct_whole_red_green = runTrials(window, letters, acceptedKeys, expDurations, startingPositions, yCenter, fade_stimulus, fade_text, stimulusSize, maskSymbols, maskFontSize, mixRedGreen([red; green], fade_stimulus), 1, zeros(size(expDurations, 2), expTrials, 7), {'RED letter?', 'GREEN letter?'});
save(strcat('data/', testNumber, '_results_indistinct_whole_red_green'), 'results_indistinct_whole_red_green');


KbQueueRelease;
%ListenChar(0);
sca;

function mixedRedGreen = mixRedGreen(colors, fade)
r1 = colors(1, 1);
g1 = colors(1, 2);
b1 = colors(1, 3);
r2 = colors(2, 1);
g2 = colors(2, 2);
b2 = colors(2, 3);

if(r1 > g1) %first color is red
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

function results = runTrials(window, letters, acceptedKeys, expDurations, startingPositions, yCenter, fade_stimulus, fade_text, stimulusSize, maskSymbols, maskFontSize, stimulusColors, answerBoth, results, questions)
letterSequence = generateLetterSequence(letters, size(expDurations, 2));
stopProgram = 0;
maskColors = cellstr(['green'; 'red  ']);
letterBoxX = 46;
letterBoxY = 53;

primeToTrialDelay = 1.0; %delay between focus char appearrance and trial
focusChar = '+';
left = startingPositions(1);
right = startingPositions(2);

maskDur = 2.0; 
expTrials = 20;

for e = 1:size(expDurations, 2)
    if(stopProgram); break; end
    for t = 1:expTrials
        if(stopProgram); break; end
        maskImg = generateMask(maskSymbols, maskColors, maskFontSize, letterBoxX, letterBoxY, fade_stimulus);
        dstRects1 = [left - letterBoxX*1.5, yCenter - letterBoxY*1.5, left + letterBoxX*1.5, yCenter + letterBoxY*1.5];
        dstRects2 = [right - letterBoxX*1.5, yCenter - letterBoxY*1.5, right + letterBoxX*1.5, yCenter + letterBoxY*1.5];
        
        textureIndex=Screen('MakeTexture', window, maskImg);      
        
        expduration = expDurations(e); 
        drawFocusChar(window, focusChar, fade_text);
        vbl = Screen('Flip', window);
        drawFocusChar(window, focusChar, fade_text);
        positions = startingPositions(randperm(2));
  
        Screen('TextSize', window, stimulusSize);
        DrawFormattedText(window, letters(letterSequence(e, t, 1)), positions(1), 'center', stimulusColors(1, :));
        if(size(stimulusColors, 1)) == 2
            DrawFormattedText(window, letters(letterSequence(e, t, 2)), positions(2), 'center', stimulusColors(2, :));
        end

        time_start = Screen('Flip', window, vbl + primeToTrialDelay); %SHOW STIMULUS  
        KbQueueStart();
        
        drawFocusChar(window, focusChar, fade_text);
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
    end
end
return
end