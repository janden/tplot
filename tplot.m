% TPLOT Line plot in terminal
%
% Usage
%    tplot(x, style);
%
% Input
%    x: The values to be plotted.
%    style: The style of the line. Can be any of 'thin', 'thin-rounded',
%       'thin-dashed', 'thin-dashed-rounded', 'thick', 'thick-dashed',
%       or 'double' (default 'thin').
%
% Description
%    Plots the values in the x array as a line plot using block elements. The
%    terminal must support Unicode for this to work.

function tplot(x, style)
    if nargin < 2 || isempty(style)
        style = 'thin';
    end

    win = [22 2*numel(x)-1];

    width = 2*numel(x)-1;

    if strcmp(style, 'thin')
        val = [hex2dec('2500') hex2dec('2502') ...
               hex2dec('250c') hex2dec('2510') hex2dec('2518') hex2dec('2514')];
    elseif strcmp(style, 'thin-rounded')
        val = [hex2dec('2500') hex2dec('2502') ...
               hex2dec('256d') hex2dec('256e') hex2dec('256f') hex2dec('2570')];
    elseif strcmp(style, 'thin-dashed')
        val = [hex2dec('254c') hex2dec('254e') ...
               hex2dec('250c') hex2dec('2510') hex2dec('2518') hex2dec('2514')];
    elseif strcmp(style, 'thin-dashed-rounded')
        val = [hex2dec('254c') hex2dec('254e') ...
               hex2dec('256d') hex2dec('256e') hex2dec('256f') hex2dec('2570')];
    elseif strcmp(style, 'thick')
        val = [hex2dec('2501') hex2dec('2503') ...
               hex2dec('250f') hex2dec('2513') hex2dec('251b') hex2dec('2517')];
    elseif strcmp(style, 'thick-dashed')
        val = [hex2dec('254d') hex2dec('254f') ...
               hex2dec('250f') hex2dec('2513') hex2dec('251b') hex2dec('2517')];
    elseif strcmp(style, 'double')
        val = [hex2dec('2550') hex2dec('2551') ...
               hex2dec('2554') hex2dec('2557') hex2dec('255d') hex2dec('255a')];
    else
        error(['style must be one of ''thin'', ''thin-rounded'', ' ...
               '''thin-dashed'', ''thin-dashed-rounded'', ''thick'', ' ...
               '''thick-dashed'', or ''double''.']);
    end

    mn = min(x(:));
    mx = max(x(:));

    x = (x-mn)/(mx-mn);

    x = round(x*(win(1)-1));

    buf = repmat(32, win(1), win(2));

    for k = 1:numel(x)
        buf(1+x(k),2*(k-1)+1) = val(1);

        if k < numel(x)
            if x(k+1) == x(k)
                buf(1+x(k),2*k) = val(1);
            else
                if x(k+1) < x(k)
                    buf(1+x(k),2*k) = val(4);
                    buf(1+x(k+1),2*k) = val(6);
                else
                    buf(1+x(k),2*k) = val(5);
                    buf(1+x(k+1),2*k) = val(3);
                end
                buf(1+[min(x(k), x(k+1))+1:max(x(k), x(k+1))-1], 2*k) = val(2);
            end
        end
    end

    buf = flipud(buf);

    for l = 1:size(buf, 1)
        fprintf('%c', [buf(l,:) 10]);
    end
end
