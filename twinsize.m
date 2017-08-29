% TWINSIZE Get/set window size for plotting
%
% Usage
%    old_winsize = twinsize(new_winsize);
%
% Input
%    new_winsize: The new window size, in the form of a pair of positive
%       integers. Either dimension can also be set to 'Inf', indicating no
%       limit to the window size. If empty, the window size is not changed
%       (default empty).
%
% Output
%    old_winsize: The old window size.

function old_winsize = twinsize(new_winsize)
    if nargin < 1
        new_winsize = [];
    end

    old_params = tparams();

    if ~isempty(new_winsize)
        if any(size(new_winsize) ~= [1 2]) || any(new_winsize < 1) || ...
            any(abs(imag(new_winsize))>0) || ...
            any(new_winsize ~= round(new_winsize))
            error('Window size must be a pair of positive integers or Inf.');
        end

        new_params = old_params;
        new_params.winsize = new_winsize;

        tparams(new_params);
    end

    old_winsize = old_params.winsize;
end
