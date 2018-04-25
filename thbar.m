% THBAR Horizontal bar plot in terminal
%
% Usage
%    thbar(x);
%
% Input
%    x: The values to be plotted.
%
% Description
%    Plots the values in the x array as a horizontal bar plot using block
%    elements. The terminal must support Unicode for this to work.

function tbar(x)
    val = [hex2dec('20') ...
           hex2dec('258F') hex2dec('258E') hex2dec('258D') hex2dec('258C') ...
           hex2dec('258B') hex2dec('258A') hex2dec('2589') hex2dec('2588')];

    win = 78;

    mx = max(x);
    mn = 0;

    x = x/mx*win;

    x(~isfinite(x)) = 0;

    x0 = floor(x);
    x1 = x-x0;

    for k = 1:numel(x)
        fprintf('%c', val([9*ones(1, x0(k)) 1+round(x1(k)*8)]));
        fprintf('\n\n');
    end
end
