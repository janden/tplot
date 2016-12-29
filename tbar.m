% TBAR Bar plot in terminal
%
% Usage
%    tbar(x);
%
% Input
%    x: The values to be plotted.
%
% Description
%    Plots the values in the x array as a bar plot using block elements. The
%    terminal must support Unicode for this to work.

function tbar(x)
    val = [hex2dec('20') ...
           hex2dec('2581') hex2dec('2582') hex2dec('2583') hex2dec('2584') ...
           hex2dec('2585') hex2dec('2586') hex2dec('2587') hex2dec('2588')];

    win = 22;

    mx = max(x(:));
    mn = 0;

    x = x/mx*win;

    x0 = floor(x);
    x1 = x-x0;

    width = size(x, 2)+1;

    buf = repmat(32, win, size(x, 1)*width);

    for k = 1:size(x, 1)
        for l = 1:size(x, 2)
            str = val([9*ones(1, x0(k,l)) 1+round(x1(k,l)*8)]);
            buf(1:x0(k,l)+1,width*(k-1)+l) = str';
        end
    end

    buf = flipud(buf);

    for l = 1:size(buf, 1)
        for c = 1:size(buf, 2)
            if mod(c-1, width) == width-1
                fprintf(' ');
            else
                fprintf('%c[%d;1m', 27, 37-mod(mod(c-1, width), 8));
                fprintf('%c', buf(l,c));
                fprintf('%c[0m', 27);
            end
        end
        fprintf('\n');
    end
end
