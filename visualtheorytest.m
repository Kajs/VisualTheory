% Clear the workspace and the screen

close all;
clearvars;
sca;

screenDiag = 31.75; %cm
screenPixelsX = 1366.0;
screenPixelsY = 768.0;
screenPixelsDiag = sqrt(screenPixelsX.^2 + screenPixelsY.^2);
cmPerPixel = screenDiag/screenPixelsDiag;

disp(screenPixelsDiag);
disp(cmPerPixel);
screenCmX = screenPixelsX * cmPerPixel;
screenCmY = screenPixelsY * cmPerPixel;
disp(screenCmX);
disp(screenCmY);
letterDisplacement = 5.0; %cm


expTrials = 20;           %number of trials per exposure duration
primeDur = 1.0;          %time to show the priming symbol
primeToTrialDelay = 2.0; %delay between prime symbol dissapearance and trial
primeChar = '+';
mask = '-|^<\*';
maskDur = 2.0;           %duration the mask is shown
stimulusSize = 70;       %text size for the stimulus letters
stimulusPositionCorrection = 0.47 / cmPerPixel;

data_responses = 1;
data_duration = 2;
data_time = 3;

enterKey = 10;
escapeKey = KbName('ESCAPE');
stopProgram = 0;


letters = ['A' 'E' 'I' 'O' 'U'];
numLetters = size(letters, 2);
expDurations = [0.1 0.125 0.15 0.175 0.2];
expDurations = expDurations(randperm(size(expDurations, 2)));
typeRedLetter = 'Please press symbol of the RED letter';
typeGreenLetter = 'Please press the symbol of the GREEN letter';

PsychDefaultSetup(2);

screens = Screen('Screens');
screenNumber = max(screens);

% Define black, white and grey
black = BlackIndex(screenNumber);
white = WhiteIndex(screenNumber);
red = [1 0 0];
green = [0 1 0];
grey = white / 2;

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);
left = xCenter - letterDisplacement/cmPerPixel - stimulusPositionCorrection;
right = xCenter + letterDisplacement/cmPerPixel - stimulusPositionCorrection;
startingPositions = [left right];
leftToRight = right - left;

data_distinct_single_red = zeros(3, size(expDurations, 2), expTrials);

%MASK
maskSymbols = ['-' '|' '^' '<' '\' '*' '~' '&' '=' '{' '[' ']' '}'];
maskColors = cellstr(['green'; 'red  ']);
maskFontSize = 70;
letterBoxX = 46;
letterBoxY = 53;

%KEYBOARD Queue
ListenChar(-1);
KbQueueCreate();


vbl = showTrialInformation('Distinct - partial (RED)', window, yCenter*1.4, white, enterKey);
letterSequence = generateLetterSequence(letters, size(expDurations, 2));
for e = 1:size(expDurations, 2)
    if(stopProgram); break; end
    for t = 1:expTrials
        if(stopProgram); break; end
        maskImg = generateMask(maskSymbols, maskColors, maskFontSize, letterBoxX, letterBoxY);
        textureIndex=Screen('MakeTexture', window, maskImg);
        expduration = expDurations(e);   
        vbl = showPrimeChar(window, primeChar, primeDur, white);
        positions = startingPositions(randperm(2));
  
        Screen('TextSize', window, stimulusSize);
        DrawFormattedText(window, letters(letterSequence(e, t, 1)), positions(1), 'center', red);
        DrawFormattedText(window, letters(letterSequence(e, t, 2)), positions(2), 'center', green);   

        vbl = Screen('Flip', window, vbl + primeToTrialDelay); %SHOW STIMULUS
        time_start = GetSecs();
        KbQueueStart();
        
        dstRects = [left - letterBoxX*1.5, yCenter - letterBoxY*1.5, left + letterBoxX*1.5, yCenter + letterBoxY*1.5];
        Screen('DrawTextures', window, textureIndex, [], dstRects, [], [], [], []);
        dstRects = [right - letterBoxX*1.5, yCenter - letterBoxY*1.5, right + letterBoxX*1.5, yCenter + letterBoxY*1.5];
        Screen('DrawTextures', window, textureIndex, [], dstRects, [], [], [], []);
        vbl = Screen('Flip', window, vbl + expDurations(e)); %SHOW MASK
        
        
        firstPress = getResponseOneAnswer(time_start, window, maskDur + expduration, 150, red);      
        KbQueueStop();
        responsetime = firstPress(find(firstPress)) - time_start;
        if(min(find(firstPress)) == escapeKey); stopProgram = 1; end
    end
end

ListenChar(0);
sca;

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

function vbl = showTrialInformation(message, window, position, color, endkey)
Screen('TextSize', window, 100);
DrawFormattedText(window, message, 'center', 'center', color);
Screen('TextSize', window, 90);
DrawFormattedText(window, 'Press ENTER to continue', 'center', position, color);
vbl = Screen('Flip', window);

ch = 0;
while ch ~= endkey
    FlushEvents();
    [ch, when] = GetChar();
end
return
end

function firstPress = getResponseOneAnswer(time_start, window, waitduration, messageSize, messageColor)
time_check = 0;
pressed = 0;
while(time_check - time_start < waitduration & ~pressed)
    [ pressed, firstPress]=KbQueueCheck();
    time_check = GetSecs();
end
vbl = Screen('Flip', window);

if ~pressed
    Screen('TextSize', window, messageSize);
    DrawFormattedText(window, '?', 'center', 'center', messageColor);
    vbl = Screen('Flip', window);
end
        
while(~pressed)
    [ pressed, firstPress]=KbQueueCheck();
end
return
end

function vbl = showPrimeChar(window, primechar, duration, charColor)
Screen('TextSize', window, 200);
DrawFormattedText(window, primechar, 'center', 'center', charColor);
vbl = Screen('Flip', window);
vbl = Screen('Flip', window, vbl + duration);
return
end