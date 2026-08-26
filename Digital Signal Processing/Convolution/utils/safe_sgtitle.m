function safe_sgtitle(txt)
% SAFE_SGTITLE  Cross-version replacement for sgtitle().
%   Some Octave versions/installs do not ship sgtitle(). This function
%   uses it if available, otherwise falls back to an annotation textbox
%   placed at the top of the current figure.

    if exist('sgtitle', 'builtin') || exist('sgtitle', 'file')
        sgtitle(txt);
    else
        annotation('textbox', [0 0.94 1 0.05], ...
                    'String', txt, ...
                    'HorizontalAlignment', 'center', ...
                    'FontWeight', 'bold', ...
                    'FontSize', 11, ...
                    'LineStyle', 'none');
    end
end
