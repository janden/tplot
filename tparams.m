% TPARAMS Get/set parameters for terminal plotting functions
%
% Usage
%    old_params = tparams(new_params);
%
% Input
%    new_params: A struct containing new parameters. If empty, leaves the
%       parameters as is (default empty).
%
% Output
%    old_params: The old set of terminal plotting parameters.
%
% Note
%    This function is used internally to control the terminal plotting
%    parameters. It should not be used directly by the end user.

function old_params = tparams(new_params)
    persistent params;

    if nargin < 1
        new_params = [];
    end

    if isempty(params)
        params = default_tparams();
    end

    old_params = params;

    if ~isempty(new_params)
        params = new_params;
    end
end

function params = default_tparams()
    params = struct();
end
