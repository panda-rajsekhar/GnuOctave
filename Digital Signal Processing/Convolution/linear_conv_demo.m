function y_lin = linear_conv_demo(x, h, opts)
% LINEAR_CONV_DEMO  Animate the "flip-and-slide" linear convolution of
%   x[n] and h[n], and optionally export the animation as a GIF.
%
%   y_lin = linear_conv_demo(x, h, opts)
%
%   opts (struct, all optional fields):
%     .animate    (default true)  - show animation
%     .save_gif   (default false) - export animation to outputs/linear_conv.gif
%     .pause_time (default 0.6)   - seconds between frames
%     .max_len    (default 15)    - skip/limit animation if Nx+Nh-1 exceeds this

    if nargin < 3, opts = struct(); end
    if ~isfield(opts,'animate'),    opts.animate    = true;  end
    if ~isfield(opts,'save_gif'),   opts.save_gif   = false; end
    if ~isfield(opts,'pause_time'), opts.pause_time = 0.6;   end
    if ~isfield(opts,'max_len'),    opts.max_len    = 15;    end

    Nx = length(x); Nh = length(h);
    N_full = Nx + Nh - 1;
    y_lin = conv(x, h);

    if ~opts.animate
        return;
    end

    if N_full > opts.max_len
        fprintf(['Sequence too long for animation (N=%d > max_len=%d). ' ...
                 'Skipping animation, returning result only.\n'], N_full, opts.max_len);
        return;
    end

    fig = figure('Name','Linear Convolution Animation','NumberTitle','off', ...
                 'Position',[100 100 900 600]);

    h_flipped = fliplr(h);
    gif_filename = 'outputs/linear_conv.gif';
    frame_dir = tempname();
    if opts.save_gif
        if ~exist('outputs','dir'), mkdir('outputs'); end
        mkdir(frame_dir);
    end

    for shift = 1:N_full
        clf;

        subplot(2,1,1);
        stem(0:Nx-1, x, 'filled','b','LineWidth',1.5); hold on;
        h_pos = (shift-Nh):(shift-1);
        stem(h_pos, h_flipped, 'filled','r','LineWidth',1.5);
        xlim([-Nh, Nx+Nh]); ylim([0, max([x h])+1]);
        legend('x[k]','h[shift-k] (flipped & shifted)');
        title(sprintf('Linear Convolution: Sliding h[n] under x[n]  (shift = %d)', shift));
        xlabel('k'); grid on;

        subplot(2,1,2);
        y_partial = y_lin(1:shift);
        stem(0:shift-1, y_partial, 'filled','k','LineWidth',1.5);
        xlim([0, N_full]); ylim([0, max(y_lin)+2]);
        title('Output y[n] (building up)');
        xlabel('n'); ylabel('y[n]'); grid on;

        drawnow;

        if opts.save_gif
            print(fig, fullfile(frame_dir, sprintf('frame_%04d.png', shift)), '-dpng', '-r100');
        end

        pause(opts.pause_time);
    end

    safe_sgtitle('Linear Convolution Complete!');

    if opts.save_gif
        delay_centisec = max(1, round(opts.pause_time * 100));
        cmd = sprintf('convert -delay %d -loop 0 %s/frame_*.png %s', ...
                       delay_centisec, frame_dir, gif_filename);
        status = system(cmd);
        if status == 0
            fprintf('Linear convolution animation saved to %s\n', gif_filename);
        else
            warning(['Could not assemble GIF (ImageMagick "convert" not found or failed). ' ...
                     'Individual frames are in: %s'], frame_dir);
        end
    end
end
