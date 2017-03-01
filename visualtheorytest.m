% Clear the workspace and the screen

close all;
clearvars;
sca;

exptrials = 5;           %number of trials per exposure duration
primedur = 1.0;          %time to show the priming symbol
primetotrialdelay = 2.0; %delay between prime symbol dissapearance and trial
primechar = '*';
mask = '-|^<\*';
maskdur = 2.0;           %duration the mask is shown
stimulussize = 70;       %text size for the stimulus letters

stopprogram = 0;
enterkey = 10;
escapekey = KbName('ESCAPE');
data_responses = 1;
data_duration = 2;
data_time = 3;


letters = ['A' 'E' 'I' 'O' 'U'];
numletters = size(letters, 2);
expdurations = [0.5 0.15];
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

letterspacing = 0.20;

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);
left = xCenter * (1.0 - letterspacing);
right = xCenter * (1.0 + letterspacing);
startingpositions = [left right];
leftToRight = right - left;

data_distinct_single_red = zeros(3, size(expdurations, 2), exptrials);

ListenChar(-1);
KbQueueCreate();

%{
%distinct SINGLE red **********************************
vbl = showTrialInformation('Distinct - single (RED)', window, yCenter*1.4, white, enterkey);
letterSequence = generateLetterSequence(letters, size(expdurations, 2), exptrials);
for e = 1:size(expdurations, 2)
    if(stopprogram); break; end
    for t = 1:exptrials
        if(stopprogram); break; end
        expduration = expdurations(e);
        vbl = showPrimeChar(window, primechar, primedur, white);
    
        screenpos = left + (randi(2) - 1) * leftToRight;
        Screen('TextSize', window, stimulussize);
        DrawFormattedText(window, letterSequence(e, t), screenpos, 'center', red);
        vbl = Screen('Flip', window, vbl + primetotrialdelay); %SHOW STIMULUS
        time_start = GetSecs();
        KbQueueStart();
        
        Screen('TextSize', window, stimulussize);
        DrawFormattedText(window, mask, screenpos, 'center', white);    
        vbl = Screen('Flip', window, vbl + expduration); %#ok<NASGU> %SHOW MASK  
        
        firstPress = getResponseOneAnswer(time_start, window, maskdur + expduration, typeRedLetter, white);      
        KbQueueStop();
        responsetime = firstPress(find(firstPress)) - time_start;
        if(min(find(firstPress)) == escapekey); stopprogram = 1; end
    end
end
%}

%distinct PARTIAL red **********************************
vbl = showTrialInformation('Distinct - partial (RED)', window, yCenter*1.4, white, enterkey);
letterSequenceRed = generateLetterSequence(letters, size(expdurations, 2), exptrials);
letterSequenceGreen = generateLetterSequence(letters, size(expdurations, 2), exptrials);
for e = 1:size(expdurations, 2)
    if(stopprogram); break; end
    for t = 1:exptrials
        if(stopprogram); break; end
        expduration = expdurations(e);   
        vbl = showPrimeChar(window, primechar, primedur, white);
        positions = startingpositions(randperm(2));
    
        Screen('TextSize', window, stimulussize);
        DrawFormattedText(window, letterSequenceRed(e, t), positions(1), 'center', red);
        Screen('TextSize', window, stimulussize);
        DrawFormattedText(window, letterSequenceGreen(e, t), positions(2), 'center', green);       
        vbl = Screen('Flip', window, vbl + primetotrialdelay); %SHOW STIMULUS
        time_start = GetSecs();
        KbQueueStart();
        
        Screen('TextSize', window, stimulussize);
        DrawFormattedText(window, mask, positions(1), 'center', white);
        DrawFormattedText(window, mask, positions(2), 'center', white);
        vbl = Screen('Flip', window, vbl + expdurations(e)); %SHOW MASK
        
        firstPress = getResponseOneAnswer(time_start, window, maskdur + expduration, typeRedLetter, white);      
        KbQueueStop();
        responsetime = firstPress(find(firstPress)) - time_start;
        if(min(find(firstPress)) == escapekey); stopprogram = 1; end
    end
end

ListenChar(0);
sca;

%{

%distinct SINGLE green **********************************
Screen('TextSize', window, 100);
DrawFormattedText(window, 'Distinct - single (green)', 'center', 'center', white);
Screen('TextSize', window, 90);
DrawFormattedText(window, 'Press a key to continue', 'center', yCenter*1.4, white);
vbl = Screen('Flip', window);
[ch, when] = GetChar();
KbStrokeWait;

for e = 1:size(expdurations, 2)
    for t = 1:exptrials
        Screen('TextSize', window, 200);
        DrawFormattedText(window, primechar, 'center', 'center', white);
        vbl = Screen('Flip', window);
        vbl = Screen('Flip', window, vbl + primedur);
    
        letter = letters(randi(numletters));
        screenpos = left + (randi(2) - 1) * leftToRight;
        Screen('TextSize', window, stimulussize);
        DrawFormattedText(window, letter, screenpos, 'center', green);

        vbl = Screen('Flip', window, vbl + primetotrialdelay);
        Screen('TextSize', window, stimulussize);
        DrawFormattedText(window, mask, screenpos, 'center', white);
        vbl = Screen('Flip', window, vbl + expdurations(e));
        vbl = Screen('Flip', window, vbl + maskdur);
        
        Screen('TextSize', window, 50);
        DrawFormattedText(window, typeGreenLetter, 'center', 'center', white);
        vbl = Screen('Flip', window);
        [ch, when] = GetChar();
        KbStrokeWait;
    end
end

%distinct PARTIAL red **********************************
Screen('TextSize', window, 100);
DrawFormattedText(window, 'Distinct - partial (red)', 'center', 'center', white);
Screen('TextSize', window, 90);
DrawFormattedText(window, 'Press a key to continue', 'center', yCenter*1.4, white);
vbl = Screen('Flip', window);
[ch, when] = GetChar();
KbStrokeWait;

for e = 1:size(expdurations, 2)
    for t = 1:exptrials
        positions = startingpositions(randperm(2));
        randletters = letters(randperm(numletters));
        
        Screen('TextSize', window, 200);
        DrawFormattedText(window, primechar, 'center', 'center', white);
        vbl = Screen('Flip', window);
        vbl = Screen('Flip', window, vbl + primedur);
    
        Screen('TextSize', window, stimulussize);
        DrawFormattedText(window, randletters(1), positions(1), 'center', red);
        Screen('TextSize', window, stimulussize);
        DrawFormattedText(window, randletters(2), positions(2), 'center', green);
        
        vbl = Screen('Flip', window, vbl + primetotrialdelay);
        Screen('TextSize', window, stimulussize);
        DrawFormattedText(window, mask, positions(1), 'center', white);
        DrawFormattedText(window, mask, positions(2), 'center', white);
        vbl = Screen('Flip', window, vbl + expdurations(e));
        vbl = Screen('Flip', window, vbl + maskdur);
        
        Screen('TextSize', window, 50);
        DrawFormattedText(window, typeRedLetter, 'center', 'center', white);
        vbl = Screen('Flip', window);
        [ch, when] = GetChar();
        KbStrokeWait;
    end
end

%distinct PARTIAL green **********************************
Screen('TextSize', window, 100);
DrawFormattedText(window, 'Distinct - partial (green)', 'center', 'center', white);
Screen('TextSize', window, 90);
DrawFormattedText(window, 'Press a key to continue', 'center', yCenter*1.4, white);
vbl = Screen('Flip', window);
[ch, when] = GetChar();
KbStrokeWait;

for e = 1:size(expdurations, 2)
    for t = 1:exptrials
        positions = startingpositions(randperm(2));
        randletters = letters(randperm(numletters));
        
        Screen('TextSize', window, 200);
        DrawFormattedText(window, primechar, 'center', 'center', white);
        vbl = Screen('Flip', window);
        vbl = Screen('Flip', window, vbl + primedur);
    
        Screen('TextSize', window, stimulussize);
        DrawFormattedText(window, randletters(1), positions(1), 'center', red);
        Screen('TextSize', window, stimulussize);
        DrawFormattedText(window, randletters(2), positions(2), 'center', green);
        
        vbl = Screen('Flip', window, vbl + primetotrialdelay);
        Screen('TextSize', window, stimulussize);
        DrawFormattedText(window, mask, positions(1), 'center', white);
        DrawFormattedText(window, mask, positions(2), 'center', white);
        vbl = Screen('Flip', window, vbl + expdurations(e));
        vbl = Screen('Flip', window, vbl + maskdur);
        
        Screen('TextSize', window, 50);
        DrawFormattedText(window, typeGreenLetter, 'center', 'center', white);
        vbl = Screen('Flip', window);
        [ch, when] = GetChar();
        KbStrokeWait;
    end
end

%distinct WHOLE red **********************************
Screen('TextSize', window, 100);
DrawFormattedText(window, 'Distinct - whole (red)', 'center', 'center', white);
Screen('TextSize', window, 90);
DrawFormattedText(window, 'Press a key to continue', 'center', yCenter*1.4, white);
vbl = Screen('Flip', window);
[ch, when] = GetChar();
KbStrokeWait;

for e = 1:size(expdurations, 2)
    for t = 1:exptrials
        positions = startingpositions(randperm(2));
        randletters = letters(randperm(numletters));
        
        Screen('TextSize', window, 200);
        DrawFormattedText(window, primechar, 'center', 'center', white);
        vbl = Screen('Flip', window);
        vbl = Screen('Flip', window, vbl + primedur);
    
        Screen('TextSize', window, stimulussize);
        DrawFormattedText(window, randletters(1), positions(1), 'center', red);
        Screen('TextSize', window, stimulussize);
        DrawFormattedText(window, randletters(2), positions(2), 'center', green);
        
        vbl = Screen('Flip', window, vbl + primetotrialdelay);
        Screen('TextSize', window, stimulussize);
        DrawFormattedText(window, mask, positions(1), 'center', white);
        DrawFormattedText(window, mask, positions(2), 'center', white);
        vbl = Screen('Flip', window, vbl + expdurations(e));
        vbl = Screen('Flip', window, vbl + maskdur);
        
        Screen('TextSize', window, 50);
        DrawFormattedText(window, typeRedLetter, 'center', 'center', white);
        vbl = Screen('Flip', window);
        [ch_red, when_red] = GetChar();
        KbStrokeWait;
        Screen('TextSize', window, 50);
        DrawFormattedText(window, typeGreenLetter, 'center', 'center', white);
        vbl = Screen('Flip', window);
        [ch_green, when_green] = GetChar();
        KbStrokeWait;
    end
end

%distinct WHOLE green **********************************
Screen('TextSize', window, 100);
DrawFormattedText(window, 'Distinct - whole (green)', 'center', 'center', white);
Screen('TextSize', window, 90);
DrawFormattedText(window, 'Press a key to continue', 'center', yCenter*1.4, white);
vbl = Screen('Flip', window);
[ch, when] = GetChar();
KbStrokeWait;

for e = 1:size(expdurations, 2)
    for t = 1:exptrials
        positions = startingpositions(randperm(2));
        randletters = letters(randperm(numletters));
        
        Screen('TextSize', window, 200);
        DrawFormattedText(window, primechar, 'center', 'center', white);
        vbl = Screen('Flip', window);
        vbl = Screen('Flip', window, vbl + primedur);
    
        Screen('TextSize', window, stimulussize);
        DrawFormattedText(window, randletters(1), positions(1), 'center', red);
        Screen('TextSize', window, stimulussize);
        DrawFormattedText(window, randletters(2), positions(2), 'center', green);
        
        vbl = Screen('Flip', window, vbl + primetotrialdelay);
        Screen('TextSize', window, stimulussize);
        DrawFormattedText(window, mask, positions(1), 'center', white);
        DrawFormattedText(window, mask, positions(2), 'center', white);
        vbl = Screen('Flip', window, vbl + expdurations(e));
        vbl = Screen('Flip', window, vbl + maskdur);
        
        Screen('TextSize', window, 50);
        DrawFormattedText(window, typeGreenLetter, 'center', 'center', white);
        vbl = Screen('Flip', window);
        [ch_red, when_red] = GetChar();
        KbStrokeWait;
        Screen('TextSize', window, 50);
        DrawFormattedText(window, typeRedLetter, 'center', 'center', white);
        vbl = Screen('Flip', window);
        [ch_green, when_green] = GetChar();
        KbStrokeWait;
    end
end

%END OF TEST **********************************
Screen('TextSize', window, 100);
DrawFormattedText(window, 'End of test, thank you!', 'center', 'center', white);
Screen('TextSize', window, 90);
DrawFormattedText(window, 'Press a key to continue', 'center', yCenter*1.4, white);
vbl = Screen('Flip', window);
[ch, when] = GetChar();
KbStrokeWait;

% Clear the screen
sca;
 %}


function letterSequence = generateLetterSequence(letters, expdurations, exptrials)
letterSequence = zeros(expdurations, exptrials);
for i = 1:expdurations
    for j = 1:exptrials
        letterSequence(i, j) = letters(mod(j, size(letters, 2)) + 1);
    end
    letterSequence(i, :) = letterSequence(i, randperm(exptrials));
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

function firstPress = getResponseOneAnswer(time_start, window, waitduration, stimulusMessage, messageColor)
time_check = 0;
pressed = 0;
while(time_check - time_start < waitduration & ~pressed)
    [ pressed, firstPress]=KbQueueCheck();
    time_check = GetSecs();
end
vbl = Screen('Flip', window);

if ~pressed
    Screen('TextSize', window, 50);
    DrawFormattedText(window, stimulusMessage, 'center', 'center', messageColor);
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