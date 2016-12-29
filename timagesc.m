% TIMAGESC Scaled image in terminal
%
% Usage
%    timagesc(im, do_square);
%
% Input
%    im: A two-dimensional array to be displayed as an image.
%    do_square: If true, do a box averaging along the first dimension so that
%       the displayed image is approximately square (default false).
%
% Description
%    Takes the image and displays it, like the imagesc function, but in the
%    terminal using block elements. This requires the terminal window to
%    support Unicode.

function timagesc(im, do_square)
    if nargin < 2
        do_square = false;
    end

    vals = [32 hex2dec('2591') hex2dec('2592') hex2dec('2593') hex2dec('2588')];

    if do_square && mod(size(im, 1), 2) == 1
        im = im(1:end-1,:);
    end

    mn = min(im(:));
    mx = max(im(:));

    if mn ~= mx
        im = (im-mn)/(mx-mn);
    else
        im = zeros(size(im));
    end

    if do_square
        im = permute(mean(reshape(im, 2, size(im, 1)/2, size(im, 2)), 1), [2 3 1]);
    end

    im = floor(im*(numel(vals)-1));

    im = vals(im+1);

    for k = 1:size(im, 1)
        fprintf('%c', im(k,:));
        fprintf('\n');
    end
end
