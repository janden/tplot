% TIMAGESC Scaled image in terminal
%
% Usage
%    timagesc(im, climits);
%
% Input
%    im: A two-dimensional array to be displayed as an image.
%    climits: A pair of numbers specifying the range of the displayed colors
%       (default [min(im(:)) max(im(:))]).
%
% Description
%    Takes the image and displays it, like the imagesc function, but in the
%    terminal using block elements. This requires the terminal window to
%    support Unicode.

function timagesc(im, climits)
    if nargin < 2
        climits = [];
    end

    win_size = twinsize();

    render_mode = 1;

    if ndims(im) > 2
        warning('Array has more than two dimensions. Displaying first slice.');

        sz = size(im);

        im = im(1:sz(1)*sz(2));
        im = reshape(im, sz(1:2));
    end

    if any(imag(im(:))~=0)
        warning('Image has imaginary components. Ignoring.');

        im = real(im);
    end

    if render_mode == 1
        % If `render_mode` is 1, we have double the number of pixels to work
        % with, so take this into account when adjusting the size of the
        % image.

        win_size = [2 1].*win_size;
    end

    if any(size(im) > win_size)
        im = timagesc_rescale(im, win_size);
    end

    if isempty(climits)
        climits = [min(im(:)) max(im(:))];
    end

    if climits(1) ~= climits(2)
        buf = (im-climits(1))/(climits(2)-climits(1));

        buf = max(min(buf, 1), 0);
    else
        buf = zeros(size(im));
    end

    timagesc_render(buf, render_mode);
end

function timagesc_render(buf, render_mode)
    if render_mode == 0
        vals = [32 hex2dec('2591') hex2dec('2592') hex2dec('2593') hex2dec('2588')];

        buf = min(floor(buf*numel(vals)), numel(vals)-1);

        chars = vals(buf+1);

        for k = 1:size(chars, 1)
            fprintf('%c', chars(k,:));
            fprintf('\n');
        end
    elseif render_mode == 1
        shade_ct = 24;

        buf = min(floor(buf*shade_ct), shade_ct-1);

        if mod(size(buf, 1), 2) == 1
            buf = cat(1, buf, zeros(1, size(buf, 2)));
        end

        escape_str = [char(27) '['];
        reset_str = '0';
        fg_str = '38;5;%d';
        bg_str = '48;5;%d';
        join_str = ';';
        unescape_str = 'm';

        up_str = {};
        down_str = {};

        for k = 1:shade_ct
            up_str{k} = sprintf(fg_str, 232+(k-1));
            down_str{k} = sprintf(bg_str, 232+(k-1));
        end

        block_str = sprintf('%c', hex2dec('2580'));

        output = char([]);
        for k = 1:2:size(buf, 1)
            for l = 1:size(buf, 2)
                output = [output escape_str up_str{buf(k,l)+1} join_str ...
                    down_str{buf(k+1,l)+1} unescape_str block_str];
            end
            output = [output char(10)];
        end

        output = [output escape_str reset_str unescape_str];

        fprintf('%s', output);
    else
        error('Invalid `render_mode`.');
    end
end

function im = timagesc_rescale(im, win_size)
    ratio = size(im, 2)/size(im, 1);

    win_ratio = win_size(2)/win_size(1);

    if ratio >= win_ratio
        factor = win_size(2)/size(im, 2);
    else
        factor = win_size(1)/size(im, 1);
    end

    im_size = max(1, factor*size(im));

    [Xi, Yi] = meshgrid(1/factor*[0:im_size(2)-1]+1, 1/factor*[0:im_size(1)-1]+1);

    im = interp2(double(im), Xi, Yi);
end
