function y_circ = circular_conv_demo(x, h, opts)
% CIRCULAR_CONV_DEMO  Animate circular convolution of x[n] and h[n] using
%   a "rotating wheel" visualization (h circularly shifted around x),
%   zero-padded to N = Nx+Nh-1 so the result matches linear convolution.
%   Optionally exports the animation as a GIF.
%
%   y_circ = circular_conv_demo(x, h, opts)
%
%   opts (struct, all optional fields):
%     .animate    (default true)
%     .save_gif   (default false) - export to outputs/circular_conv.gif
%     .pause_time (default 0.6)
%     .max_len    (default 15)    - skip animation if N exceeds this

    if nargin < 3, opts = struct(); end
    if ~isfield(opts,'animate'),    opts.animate    = true;  end
    if ~isfield(opts,'save_gif'),   opts.save_gif   = false; end
    if ~isfield(opts,'pause_time'), opts.pause_time = 0.6;   end
    if ~isfield(opts,'max_len'),    opts.max_len    = 15;    end

    addpath('utils');
    Nx = length(x); Nh = length(h);
    N_full = Nx + Nh - 1;
    y_circ = circconv_fft(x, h, N_full);

    if ~opts.animate
        return;
    end

    if N_full > opts.max_len
        fprintf(['Sequence too long for animation (N=%d > max_len=%d). ' ...
                 'Skipping animation, returning result only.\n'], N_full, opts.max_len);
        return;
    end

    xp = [x zeros(1, N_full-Nx)];
    hp = [h zeros(1, N_full-Nh)];

    theta = linspace(0, 2*pi, N_full+1); theta(end) = [];
    radius_x = 1.4; radius_h = 0.9;

    fig = figure('Name','Circular Convolution Animation','NumberTitle','off', ...
                 'Position',[150 150 900 600]);

    gif_filename = 'outputs/circular_conv.gif';
    frame_dir = tempname();
    if opts.save_gif
        if ~exist('outputs','dir'), mkdir('outputs'); end
        mkdir(frame_dir);
    end

    for shift = 0:N_full-1
        clf;

        subplot(1,2,1); hold on; axis equal off;

        for k = 0:N_full-1
            px = radius_x*cos(theta(k+1)); py = radius_x*sin(theta(k+1));
            plot(px, py, 'bo','MarkerFaceColor','b','MarkerSize',18);
            text(px, py, sprintf('%d',xp(k+1)), 'Color','w', ...
                 'HorizontalAlignment','center','FontWeight','bold');
        end

        for k = 0:N_full-1
            idx = mod(shift - k, N_full) + 1;
            px = radius_h*cos(theta(k+1)); py = radius_h*sin(theta(k+1));
            plot(px, py, 'rs','MarkerFaceColor','r','MarkerSize',16);
            text(px, py, sprintf('%d',hp(idx)), 'Color','w', ...
                 'HorizontalAlignment','center','FontWeight','bold');
        end

        title(sprintf('Circular Convolution Wheel (n = %d)\nh wraps around x', shift));

        subplot(1,2,2);
        y_partial = y_circ(1:shift+1);
        stem(0:shift, y_partial, 'filled','g','LineWidth',1.5);
        xlim([0, N_full-1]); ylim([0, max(y_circ)+2]);
        title('Circular Output y[n] (building up)');
        xlabel('n'); ylabel('y[n]'); grid on;

        drawnow;

        if opts.save_gif
            print(fig, fullfile(frame_dir, sprintf('frame_%04d.png', shift+1)), '-dpng', '-r100');
        end

        pause(opts.pause_time);
    end

    safe_sgtitle('Circular Convolution Complete!');

    if opts.save_gif
        delay_centisec = max(1, round(opts.pause_time * 100));
        cmd = sprintf('convert -delay %d -loop 0 %s/frame_*.png %s', ...
                       delay_centisec, frame_dir, gif_filename);
        status = system(cmd);
        if status == 0
            fprintf('Circular convolution animation saved to %s\n', gif_filename);
        else
            warning(['Could not assemble GIF (ImageMagick "convert" not found or failed). ' ...
                     'Individual frames are in: %s'], frame_dir);
        end
    end
end
