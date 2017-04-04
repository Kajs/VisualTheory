function mask = getMask(letters, colors, fontSize, letterBoxX, letterBoxY, greyVal)
maskColors = cellstr(['green'; 'red  ']);
mask = ones(letterBoxY*3, letterBoxX*3, 3);

for x = 1:3
    for y = 1:3
        colorSequence = randperm(2);
        letterColorSequence = [maskColors(colorSequence(1)) maskColors(colorSequence(2)) maskColors(colorSequence(2)) maskColors(colorSequence(1))];
        letterSequence = randperm(size(letters, 2));
        letter = makeLetterCombination(letters, letterSequence, letterColorSequence, colors, fontSize, letterBoxX, letterBoxY, greyVal);
        m_x = (x-1) * letterBoxX;
        m_y = (y-1) * letterBoxY;
        mask(1+m_y:letterBoxY+m_y, 1+m_x:letterBoxX+m_x, :) = letter(:, :, :);    
    end
end
return
end

function letterCombination = makeLetterCombination(letters, perm, letterColorSequence, colors, fontSize, letterBoxX, letterBoxY, greyVal)
letterCombination = ones(letterBoxY, letterBoxX, 3);
NW = makeLetterImg(fontSize, letters(perm(1)), letterColorSequence(1), colors, letterBoxX, letterBoxY, greyVal);
NE = makeLetterImg(fontSize, letters(perm(2)), letterColorSequence(2), colors, letterBoxX, letterBoxY, greyVal);
SW = makeLetterImg(fontSize, letters(perm(3)), letterColorSequence(3), colors, letterBoxX, letterBoxY, greyVal);
SE = makeLetterImg(fontSize, letters(perm(4)), letterColorSequence(4), colors, letterBoxX, letterBoxY, greyVal);

borderX = floor(letterBoxX/2);
borderY = floor(letterBoxY/2);
letterCombination(1:borderY, 1:borderX, :) = NW(1:borderY, 1:borderX, :);
letterCombination(1:borderY, borderX+1:letterBoxX, :) = NE(1:borderY, borderX + 1:letterBoxX, :);
letterCombination(borderY+1:letterBoxY, 1:borderX, :) = SW(borderY+1:letterBoxY, 1:borderX, :);
letterCombination(borderY+1:letterBoxY, borderX + 1:letterBoxX, :) = SE(borderY+1:letterBoxY, borderX + 1:letterBoxX, :);
return
end

function letterImg = makeLetterImg(fontSize, letter, letterColor, colors, letterBoxX, letterBoxY, greyVal)
maskImage = zeros(fontSize,fontSize,3);
maskX = fontSize*1.5;
maskY = fontSize*1.5;

for y = 1:maskY
    for x = 1:maskX
        for c = 1:3
            maskImage(y, x, c) = greyVal;
        end
    end
end

position = [0 0];
box_color = {'black'};
RGB = insertText(maskImage,position,letter,'FontSize',fontSize,'BoxColor',...
    box_color,'BoxOpacity',0.0,'TextColor',letterColor);

m_top = 0;
for y = 1:maskY
    if m_top ~= 0; break; end
    for x = 1:maskX
        for c = 1:3
            r = RGB(y, x, 1);
            g = RGB(y, x, 2);
            b = RGB(y, x, 3);
            if r > greyVal | g > greyVal | b > greyVal; m_top = y; break; end
        end
    end
end

m_bottom = 0;
for y = 1:maskY
    if m_bottom ~= 0; break; end
    for x = 1:maskX
        for c = 1:3
            r = RGB(maskY - (y-1), x, 1);
            g = RGB(maskY - (y-1), x, 2);
            b = RGB(maskY - (y-1), x, 3);
            if r > greyVal | g > greyVal | b > greyVal; m_bottom = maskY - (y-1); break; end
        end
    end
end

m_left = 0;
for x = 1:maskX
    if m_left ~= 0; break; end
    for y = 1:maskY
        for c = 1:3
            r = RGB(y, x, 1);
            g = RGB(y, x, 2);
            b = RGB(y, x, 3);
            if r > greyVal | g > greyVal | b > greyVal; m_left = x; break; end
        end
    end
end

m_right = 0;
for x = 1:maskX
    if m_right ~= 0; break; end
    for y = 1:maskY
        for c = 1:3
            r = RGB(y, maskX - x + 1, 1);
            g = RGB(y, maskX - x + 1, 2);
            b = RGB(y, maskX - x + 1, 3);
            if r > greyVal | g > greyVal | b > greyVal; m_right = maskX - x + 1; break; end
        end
    end
end

while(m_right - m_left + 1 < letterBoxX)
    if(m_left > 1); m_left = m_left - 1; end
    if(m_right - m_left + 1  < letterBoxX); m_right = m_right + 1; end
end

while(m_bottom - m_top + 1 < letterBoxY)
    if(m_top > 1); m_top = m_top - 1; end
    if(m_bottom - m_top + 1 < letterBoxY); m_bottom = m_bottom + 1; end
end
letterImg = RGB(m_top:m_bottom, m_left:m_right, 1:3);
maskY = size(letterImg, 1);
maskX = size(letterImg, 2);
for y = 1:maskY
    for x = 1:maskX
        for c = 1:3
            r = letterImg(y, x, 1);
            g = letterImg(y, x, 2);
            b = letterImg(y, x, 3);
            if(r > greyVal | g > greyVal | b > greyVal)
                if r > g
                    letterImg(y, x, 1) = colors(1, 1);
                    letterImg(y, x, 2) = colors(1, 2);
                    letterImg(y, x, 3) = colors(1, 3);   
                else
                    letterImg(y, x, 1) = colors(2, 1);
                    letterImg(y, x, 2) = colors(2, 2);
                    letterImg(y, x, 3) = colors(2, 3);
                end
            end
        end
    end
end

return
end