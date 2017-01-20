% TPLOT Line plot in terminal
%
% Usage
%    tplot(x);
%
% Input
%    x: The values to be plotted.
%
% Description
%    Plots the values in the x array as a line plot using block elements. The
%    terminal must support Unicode for this to work.

function tplot(x, style)
    if nargin < 2 || isempty(style)
        style = 'thin';
    end

    win = [22 2*size(x, 1)-1];

    mn = min(x(:));
    mx = max(x(:));

    x = (x-mn)/(mx-mn);

    x = round(x*(win(1)-1));

    buf = ones([4 win(1) win(2)]);

    for l = 1:size(x, 2)
        code = 2+mod(l-1, 4);
        for k = 1:size(x, 1)
            buf([2 4],1+x(k,l),2*(k-1)+1) = code;

            if k < size(x, 1)
                if x(k+1,l) == x(k,l)
                    buf([2 4],1+x(k,l),2*k) = code;
                else
                    if x(k+1,l) < x(k,l)
                        buf([3 4],1+x(k,l),2*k) = code;
                        buf([1 2],1+x(k+1,l),2*k) = code;
                    else
                        buf([1 4],1+x(k,l),2*k) = code;
                        buf([2 3],1+x(k+1,l),2*k) = code;
                    end
                    buf([1 3],1+[min(x(k,l), x(k+1,l))+1:max(x(k,l), x(k+1,l))-1], 2*k) = code;
                end
            end
        end
    end

    buf = flip(buf, 2);

    buf = reshape(compose(reshape(buf, [4 prod(win)])), win);

    for l = 1:size(buf, 1)
        fprintf('%c', [buf(l,:) 10]);
    end
end
