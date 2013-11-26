function startGUI
% STARTGUI Select a data set from the pop-up menu, then
% click one of the plot-type push buttons. Clicking the button
% plots the selected data in the axes.

% Set parameter defaults
type = 'mle';
mu1 = 50;   sigma1 = 50; 
mu2 = 50;   sigma2 = 50;
prior1 = 50; % Percent

whos % see variables
%  Create and then hide the GUI as it is being constructed.
hFig = figure('Visible','off','Position',[100,100,800,600]);

% Construct the components.
hRun = uicontrol('Style','pushbutton',...
    'String','Run Simulation',...
    'Units','normalized','Pos',[.75,.025,0.17,.05],...
    'Callback',{@runbutton_Callback});

hMethodText = uicontrol('Style','text','String','Choose Method',...
    'Units','normalized','Pos',[.76,.95,.15,.025]);

hpopup = uicontrol('Style','popupmenu',...
    'String',{'MLE','MAP','LDA'},...
    'Units','normalized','Pos',[.75,.89,.17,.05],...
    'Callback',{@popup_menu_Callback});

% Create the panel for setting means, standard deviations, and priors
hPanel = uipanel(gcf,'title','Parameters','units','normalized','pos',[0.67 0.1 0.33 0.7]);
Panel.title = 'Parameter Tool';
Panel.bordertype = 'none';
Panel.titleposition = 'centertop';
Panel.fontweight = 'bold';  
Slider.min = 0;
Slider.max = 100;
Slider.value = 50;
EditOpts = {'fontsize',10};
LabelOpts = {'fontsize',8,'fontweight','b'};
numFormat = '%0.0f';
titleStrings = {'Prior 1 (%)','Sigma 2', 'Mu 2', 'Sigma 1', 'Mu 1'};
startPos = {[0.05 0.05 0.9 0.18];
    [0.05 0.23 0.9 0.18];
    [0.05 0.41 0.9 0.18];
    [0.05 0.59 0.9 0.18]
    [0.05 0.77 0.9 0.18]};
sliderCallbacks = {'disp(''Mu 1 moved'')';
    'disp(''Sigma 1 moved'')';
    'disp(''Mu 2 moved'')';
    'disp(''Sigma 2 moved'')';
    'disp(''Prior 1 moved'')'};
for i = 1:5
    Panel.position = startPos{i};
    Panel.title = titleStrings{i};
    Slider.callback = sliderCallbacks{i};
    sliderPanel(hPanel,Panel,Slider,EditOpts,LabelOpts,numFormat);
end

% Move the GUI to the center of the screen.
movegui(hFig,'center')

% Make the GUI visible.
set(hFig,'Visible','on')

%% Nested Callback Functions Section
    function popup_menu_Callback(source,eventdata)
        % Determine the selected data set.
        str = get(source, 'String');
        val = get(source, 'Value');
        % Set current data to the selected data set.
        switch str{val};
            case 'MLE' % User selects Peaks.
                type = 'mle'
            case 'MAP' % User selects Membrane.
                type = 'map'
            case 'LDA' % User selects Sinc.
                type = 'lda'
        end
    end

    function runbutton_Callback(source,eventdata)
        spears = [1 2 1 2 1 2];
        smiles = [2 1 2 1 2 2];
        perceived = [1.1 2.1 1.5 1.9 0.9 2];
        % Run spear demo
        figPos = get(hFig,'Position');
        [frames] = spearDemo(spears, smiles, perceived,figPos);
        movie(hFig,frames,1,2,[0 figPos(4)*.33 0 0]);
    end

end

