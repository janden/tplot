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
    vals = [32 hex2dec('2591') hex2dec('2592') hex2dec('2593') hex2dec('2588')];

    mn = min(im(:));
    mx = max(im(:));

    if mn ~= mx
        im = (im-mn)/(mx-mn);
    else
        im = zeros(size(im));
    end

    im = min(floor(im*numel(vals)), numel(vals)-1);

    im = vals(im+1);

    for k = 1:size(im, 1)
        fprintf('%c', im(k,:));
        fprintf('\n');
    end
end
