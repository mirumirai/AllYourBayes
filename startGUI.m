function startGUI
% STARTGUI Select a data set from the pop-up menu, then
% click one of the plot-type push buttons. Clicking the button
% plots the selected data in the axes.
%  Create and then hide the GUI as it is being constructed.
hFig = figure('Position',[100,100,800,600]);
%'Visible','off',
% Construct the components.
hRun    = uicontrol('Style','pushbutton',...
    'String','Run Simulation',...
    'Units','normalized','Pos',[.75,.025,0.17,.05],...
    'Callback',{@runbutton_Callback});
hMu1Text  = uicontrol('Style','text','String','Choose Method',...
    'Units','normalized','Pos',[.75,.95,.17,.025]);
hpopup = uicontrol('Style','popupmenu',...
    'String',{'MLE','MAP','LDA'},...
    'Units','normalized','Pos',[.75,.9,.17,.05],...
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
for ii = 1:5
    Panel.position = startPos{ii};
    Panel.title = titleStrings{ii};
    Slider.callback = sliderCallbacks{ii};
    sliderPanel(hPanel,Panel,Slider,EditOpts,LabelOpts,numFormat);
end
set(hFig,'Visible','on')
end