% TRENDERMODE Get/set render mode
%
% Usage
%    old_rendermore = trendermode(new_rendermode);
%
% Input
%    new_rendermode: The new render mode, which can be one of the following:
%          - 0: Box-drawing characters. Use only code points U+2500 through
%               U+259F to make plots. This mode works in most terminals.
%          - 1: 8-bit ANSI escapes. Use box-drawing characters in combination
%               with ANSI escape codes to control colors.
%       If empty, the render mode is not changed (default empty).
%
% Output
%    old_rendermode: The old render mode.

function old_rendermode = trendermode(new_rendermode)
    if nargin < 1
        new_rendermode = [];
    end

    old_params = tparams();

    if ~isempty(new_rendermode)
        if numel(new_rendermode) > 1 || ~ismember(new_rendermode, [0 1])
            error('Render mode must be 0 or 1.');
        end

        new_params = old_params;
        new_params.rendermode = new_rendermode;

        tparams(new_params);
    end

    old_rendermode = old_params.rendermode;
end
