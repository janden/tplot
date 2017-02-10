% THIST Histogram in terminal
%
% Usage
%    thist(x, bins);
%
% Input
%    x: The values whose histogram is to be displayed.
%    bins: The bins for the histogram. If this is an array, these are the bin
%       centers that are used. If this is a scalar, it indicates the number of
%       equispaced bins to use, with bin centers calculated automatically
%       (default 10).
%
% Description
%     This function uses the standard hist function to calculate the histogram
%     but displays it in the terminal using the tbar function instead of in a
%     graphics window.

function thist(x, bins)
    if nargin < 2 || isempty(bins)
        bins = 10;
    end

    n = hist(x, bins);

    if size(n, 1) == 1
        n = n';
    end

    tbar(n);
end
