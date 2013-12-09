function startGUI
% STARTGUI Select a data set from the pop-up menu, then
% click one of the plot-type push buttons. Clicking the button
% plots the selected data in the axes.

% Set parameter defaults
type = 'mle';
mu1 = 50;   sigma1 = 50; 
mu2 = 50;   sigma2 = 50;
prior1 = 50; % Percent

%  Create and then hide the GUI as it is being constructed.
hFig = figure('Visible','off','Position',[100,100,800,600]);
set(hFig, 'Color', [1 1 1]);
% Construct the components.
hRun = uicontrol('Style','pushbutton',...
    'String','Run Simulation',...
    'Units','normalized','Pos',[.75,.025,0.17,.05],...
    'Callback',{@runbutton_Callback},'BackgroundColor', [1 1 1]);

hMethodText = uicontrol('Style','text','String','Choose Method',...
    'Units','normalized','Pos',[.76,.95,.15,.025],'BackgroundColor', [1 1 1]);

hpopup = uicontrol('Style','popupmenu',...
    'String',{'MLE','MAP','LDA'},...
    'Units','normalized','Pos',[.75,.89,.17,.05],...
    'Callback',{@popup_menu_Callback},'BackgroundColor', [1 1 1]);
description = {'Welcome to Smiley Spear Avoidance Training!',...
    'You are a smiley face.  You have very poor vision. Deadly spears are approaching. Your goal is to survive.',...
    'Actual locations of the approaching spears are in red.  Every red spear is in one of two categories: high or low. The locations these spears appear to you (on account of your poor vision) are in green.',...
    'Based on your sensory perception (green spears), you must classify the location of the actual spears (red spears).'
    };
hDescription = uicontrol('Style','text','String',description,...
    'HorizontalAlignment','left','Units','normalized','Pos',[.05,0,.57,.33],'BackgroundColor', [1 1 1]);
status = ['Underlying Prior(1): 0.5 ' 'Underlying Mus: 1,2 ' 'Underlying Sigmas: 0.4,0.2 '];
hStatus = uicontrol('Style','text','String',status,...
    'Units','normalized','Pos',[.05,.05,.57,.05],'BackgroundColor', [1 1 1]);

% Create the panel for setting means, standard deviations, and priors
hPanel = uipanel(gcf,'title','Parameters','units','normalized',...
    'pos',[0.67 0.1 0.33 0.7],'BackgroundColor',[1 1 1]);
Panel.title = 'Parameter Tool';
Panel.bordertype = 'none';
Panel.titleposition = 'centertop';
Panel.fontweight = 'bold'; 
Slider.min = -1;
Slider.max = 4;
Slider.value = 1.5;
Slider.backgroundcolor = [1 1 1];
[mu1,sigma1,mu2,sigma2,prior1] = deal(Slider.value);
EditOpts = {'fontsize',10,'backgroundcolor',[1 1 1]};
LabelOpts = {'fontsize',8,'fontweight','b','backgroundcolor',[1 1 1]};
numFormat = '%0.2f';
titleStrings = {'Prior 1 (%)','Sigma 2', 'Mu 2', 'Sigma 1', 'Mu 1'};
startPos = {[0.05 0.05 0.9 0.18];
    [0.05 0.23 0.9 0.18];
    [0.05 0.41 0.9 0.18];
    [0.05 0.59 0.9 0.18]
    [0.05 0.77 0.9 0.18]};
sliderCallbacks = {{@updatePrior1};
    {@updateSigma2};
    {@updateMu2};
    {@updateSigma1};
    {@updateMu1}};
for i = 1:5
    if i==1
        Slider.min = 0;
        Slider.max = 1;
        Slider.value = 0.5;
    elseif i==2 || i==4
        Slider.min = 0;
        Slider.max = 3;
        Slider.value = 1.5;
    else
        Slider.min = -1;
        Slider.max = 4;
        Slider.value = 1.5;
    end
    Panel.position = startPos{i};
    Panel.title = titleStrings{i};
    Panel.backgroundcolor = [1 1 1];
    Slider.callback = sliderCallbacks{i};
    [hSlider(i),~,~] = sliderPanel(hPanel,Panel,Slider,EditOpts,LabelOpts,numFormat);
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
            case 'MLE' % User selects MLE.
                type = 'mle';
                status = ['Underlying Prior(1): 0.5 ' 'Underlying Mus: 1,2 ' 'Underlying Sigmas: 0.4,0.2 '];
                set(hStatus,'String',status)
            case 'MAP' % User selects MAP.
                type = 'map';
                status = ['Underlying Prior(1): 0.1 ' 'Underlying Mus: 1,2 ' 'Underlying Sigmas: 0.4,0.2 '];
                set(hStatus,'String',status)
            case 'LDA' % User selects LDA.
                type = 'lda';
                status = ['Underlying Prior(1): 0.5 ' 'Underlying Mus: 1, 2 ' 'Underlying Sigmas: 0.3, 0.3 '];
                set(hStatus,'String',status)
        end
    end

    function runbutton_Callback(source,eventdata)
%         spears = [1 2 1 2 1 2];
%         smiles = [2 1 2 1 2 2];
%         perceived = [1.1 2.1 1.5 1.9 0.9 2];
% display underlying distribution priors
        nShort = 10; % Number of spears in movie
        nLong = 5000; % Number of spears in long simulation
        if strcmpi(type,'map')            
            underlyingMu = [1 2]; 
            underlyingSigma = [0.4 0.2];
            underlyingPrior = 0.1;            
            spears = generateSpears(underlyingPrior,nShort);
            spearsLong = generateSpears(underlyingPrior,nLong);  
        elseif strcmpi(type,'lda')
            underlyingMu = [1 2]; 
            underlyingSigma = [0.3 0.3];
            underlyingPrior = 0.5;
            spears = generateSpears(underlyingPrior,nShort);
            spearsLong = generateSpears(underlyingPrior,nLong);   
        else
            underlyingMu = [1 2]; 
            underlyingSigma = [0.4 0.2];
            underlyingPrior = 0.5;
            spears = generateSpears(underlyingPrior,nShort);
            spearsLong = generateSpears(underlyingPrior,nLong);   
        end
        
        % Short simulation for movie
        perceived = generateSignal(spears,'gaussian',underlyingMu,underlyingSigma);   
        mu = [mu1 mu2]; sigma = [sigma1 sigma2]; prior = [prior1 1-prior1];
        [smiles, allParams] = makeDecisions(perceived, type, mu, sigma, prior);
                
        
        % Long Simulation
        perceivedLong = generateSignal(spearsLong,'gaussian',underlyingMu,underlyingSigma);   
        mu = [mu1 mu2]; sigma = [sigma1 sigma2]; prior = [prior1 1-prior1];
        [smilesLong, allParamsLong] = makeDecisions(perceivedLong, type, mu, sigma, prior);
        successProb = sum(smilesLong~=spearsLong)/nLong;
        set(hStatus,'String',['Successful Dodge Probability Over ' num2str(nLong) ' trials: ' num2str(successProb) '%'])
        
        % Run spear movie
        figPos = get(hFig,'Position');
        [frames] = spearDemo(spears, smiles, perceived,figPos);
        movie(hFig,frames,1,2,[0 figPos(4)*.33 0 0]);
    end

    % Update slider values
    function updateMu1(source,eventdata)
        newval = get(source,'value');
        mu1 = newval;
    end
    function updateSigma1(source,eventdata)
        newval = get(source,'value');
        sigma1 = newval;
    end
    function updateMu2(source,eventdata)
        newval = get(source,'value');
        mu2 = newval;
    end
    function updateSigma2(source,eventdata)
        newval = get(source,'value');
        sigma2 = newval;
    end
    function updatePrior1(source,eventdata)
        newval = get(source,'value');
        prior1 = newval;
    end
    function updateStatus(source,eventdata,status)
    end
end

