function simpleImageDiffGUI
    % Create GUI figure
    fig = uifigure('Name','Simple Image Difference Tool','Position',[100 100 900 550]);

    % Add title label at the top
    lbl = uilabel(fig, ...
        'Text','Image Difference Tool', ...
        'FontSize',22, ...
        'FontWeight','bold', ...
        'HorizontalAlignment','center', ...
        'Position',[200 480 500 40]);

    % Axes for images
    ax1 = uiaxes(fig,'Position',[30 150 250 300]);
    title(ax1,'Image 1');

    ax2 = uiaxes(fig,'Position',[320 150 250 300]);
    title(ax2,'Image 2');

    ax3 = uiaxes(fig,'Position',[610 150 250 300]);
    title(ax3,'Difference');

    % Variables to store images
    img1 = [];
    img2 = [];

    % Button 1: Load Image 1
    uibutton(fig,'Text','Load Image 1','Position',[80 50 150 40],...
        'ButtonPushedFcn',@(btn,event) loadImage1());

    % Button 2: Load Image 2
    uibutton(fig,'Text','Load Image 2','Position',[370 50 150 40],...
        'ButtonPushedFcn',@(btn,event) loadImage2());

    % Button 3: Show Difference
    uibutton(fig,'Text','Show Difference','Position',[660 50 150 40],...
        'ButtonPushedFcn',@(btn,event) showDifference());

    % ----------------------
    % Nested functions
    % ----------------------

    function loadImage1()
        [file, path] = uigetfile({'*.jpg;*.png;*.bmp'});
        if isequal(file,0)
            return;
        end
        img1 = imread(fullfile(path,file));
        imshow(img1,'Parent',ax1);
        title(ax1,'Image 1');
    end

    function loadImage2()
        [file, path] = uigetfile({'*.jpg;*.png;*.bmp'});
        if isequal(file,0)
            return;
        end
        img2 = imread(fullfile(path,file));
        imshow(img2,'Parent',ax2);
        title(ax2,'Image 2');
    end

    function showDifference()
        if isempty(img1) || isempty(img2)
            uialert(fig,'Please load both images first!','Error');
            return;
        end

        % Resize second image to match first
        g = size(img1);
        img2r = imresize(img2, [g(1), g(2)]);

        % Subtract images
        diffImg = imsubtract(img1, img2r);

        % Display result
        imshow(diffImg,'Parent',ax3);
        title(ax3,'Difference');
    end
end

