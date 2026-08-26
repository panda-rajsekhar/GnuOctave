function v = validate_input(v, name)
% VALIDATE_INPUT  Basic sanity checks for a discrete-time sequence.
%
%   v = validate_input(v, name) checks that v is a non-empty numeric
%   row vector with finite values. 'name' is used in error messages
%   (e.g. 'x[n]' or 'h[n]'). Throws an error and stops execution if
%   the input is invalid; otherwise returns v as a row vector.

    if nargin < 2
        name = 'sequence';
    end

    if isempty(v)
        error('validate_input:empty', '%s cannot be empty.', name);
    end

    if ~isnumeric(v)
        error('validate_input:type', '%s must be numeric.', name);
    end

    if any(~isfinite(v(:)))
        error('validate_input:finite', ...
              '%s contains NaN or Inf values, which are not allowed.', name);
    end

    % Force row vector orientation for consistency
    if iscolumn(v)
        v = v.';
    end

    if ~isvector(v)
        error('validate_input:shape', '%s must be a 1-D vector.', name);
    end
end
