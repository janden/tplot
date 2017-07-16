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
    render_mode = 1;

    mn = min(im(:));
    mx = max(im(:));

    if mn ~= mx
        buf = (im-mn)/(mx-mn);
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
        shade_ct = 26;

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

        up_str{1} = sprintf(fg_str, 0);
        down_str{1} = sprintf(bg_str, 0);
        up_str{shade_ct} = sprintf(fg_str, 15);
        down_str{shade_ct} = sprintf(bg_str, 15);

        for k = 2:shade_ct-1
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
