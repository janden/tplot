% TIMAGESC Scaled image in terminal
%
% Usage
%    timagesc(im);
%
% Input
%    im: A two-dimensional array to be displayed as an image.
%
% Description
%    Takes the image and displays it, like the imagesc function, but in the
%    terminal using block elements. This requires the terminal window to
%    support Unicode.

function timagesc(im)
    mn = min(im(:));
    mx = max(im(:));

    if mn ~= mx
        buf = (im-mn)/(mx-mn);
    else
        buf = zeros(size(im));
    end

    timagesc_render(buf);
end

function timagesc_render(buf)
    vals = [32 hex2dec('2591') hex2dec('2592') hex2dec('2593') hex2dec('2588')];

    buf = min(floor(buf*numel(vals)), numel(vals)-1);

    chars = vals(buf+1);

    for k = 1:size(chars, 1)
        fprintf('%c', chars(k,:));
        fprintf('\n');
    end
end
