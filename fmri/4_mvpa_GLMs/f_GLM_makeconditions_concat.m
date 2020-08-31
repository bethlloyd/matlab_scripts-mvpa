function f_GLM_makeconditions_concat(SUBJNAME)


%this script concatenates the timings of all the runs, and then makes the
%conditions file for GLM_seperate 

%It then concatenates the realigment parameters 

%get SUBJNAME
if ~exist('SUBJNAME')
    SUBJNAME=char(inputdlg('Which subject?'));
end


%path settings
padi=i_mvpa_infofile(SUBJNAME);

uber_data = [];

%make files
for c_runs = 1:numel(padi.runs) %padi.runs has 3 runs
    
    %get func dirs 
    funcdirs=dir(fullfile(padi.data,SUBJNAME,'func',padi.runs{c_runs}));

    % GET DATA FILE
    %--------------------------------------------------------------------------

    %get log file
    d_datafile=dir(fullfile(padi.behav,['*run' num2str(c_runs) '.txt']));
    d_filename=fullfile(padi.behav,d_datafile.name);

    % open datafile
    fid=fopen(d_filename);
    cdata=textscan(fid,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s', 'delimiter',',', 'HeaderLines', 1 );
    
    %combine the data from runs
    uber_data = [uber_data; {cdata}]
    
    fclose(fid);
end
  

% adjust g_onset, response_onset and feedback_onset of run2 and run3 to
% occur 'after' run1

%make all of them ints
uber_data{1}{6}=str2double(uber_data{1}{6}) %g_onset
uber_data{2}{6}=str2double(uber_data{2}{6})
uber_data{3}{6}=str2double(uber_data{3}{6})

uber_data{1}{10}=str2double(uber_data{1}{10}) %feedback_onset
uber_data{2}{10}=str2double(uber_data{2}{10})
uber_data{3}{10}=str2double(uber_data{3}{10})

uber_data{1}{16}=str2double(uber_data{1}{16}) %respscreen_onset
uber_data{2}{16}=str2double(uber_data{2}{16})
uber_data{3}{16}=str2double(uber_data{3}{16})

%get last onset of each run / column to add on to previous
r1_g_onset_add = uber_data{1}{10}(54) + 2000 %g_onset  
r2_g_onset_add = uber_data{1}{10}(54) + 2000 + uber_data{2}{10}(54) + 2000

r1_feedback_onset_add = uber_data{1}{10}(54) + 2000 %feedback_onset
r2_feedback_onset_add = uber_data{1}{10}(54) + 2000 + uber_data{2}{10}(54) + 2000 

r1_respscreen_onset_add = uber_data{1}{10}(54) + 2000 %respscreen_onset
r2_respscreen_onset_add = uber_data{1}{10}(54) + 2000 + uber_data{2}{10}(54) + 2000


%make new times: Run2
for trial=1:numel(uber_data{2}{6})
    uber_data{2}{6}(trial) = uber_data{2}{6}(trial) + r1_g_onset_add; %g_onset
    uber_data{2}{10}(trial) = uber_data{2}{10}(trial) + r1_feedback_onset_add; %feedback_onset
    uber_data{2}{16}(trial) = uber_data{2}{16}(trial) + r1_respscreen_onset_add; %respscreen_onset
end

%make new times: Run3
for trial=1:numel(uber_data{2}{6})
  uber_data{3}{6}(trial) = uber_data{3}{6}(trial) + r2_g_onset_add;
  uber_data{3}{10}(trial) = uber_data{3}{10}(trial) + r2_feedback_onset_add;
  uber_data{3}{16}(trial) = uber_data{3}{16}(trial) + r2_respscreen_onset_add;
end   

%combine all runs into one
for c_col =1:17
    uber_data_all{c_col}=[uber_data{1}{c_col};uber_data{2}{c_col};uber_data{3}{c_col}];
end
%convert correct column to int
uber_data_all{14} = str2double(uber_data_all{14})


% MAKE CONDITIONS.MAT FILE [FOR SPM]
%--------------------------------------------------------------------------

%make files
struct('names',{''},'onsets',{},'durations',{});
names{1}='trial_out'; 
names{2}='trials_rest'
names{3}='response';
names{4}='+ve_feedback'
names{5}='-ve_feedback'

%change view of ints to this format 
format longg

%onsets and durations: response
onsets{3}=uber_data_all{16}/1000; %ms to sec
durations{3}=str2double(uber_data_all{17})/1000; %ms to sec

onsets_pos =[];
onsets_neg =[];
durations_pos =[];
durations_neg = [];
%create emptly vecs of correct length
for i=1:numel(uber_data_all{1})
    
    if uber_data_all{14}(i) == 1
        %onsets and durations: feedback
        onsets_pos=[onsets_pos; uber_data_all{10}(i)]; 
        durations_pos=[durations_pos; uber_data_all{17}(i)]; 
    elseif uber_data_all{14}(i) == 0
        onsets_neg=[onsets_neg; uber_data_all{10}(i)];
        durations_neg=[durations_neg; uber_data_all{17}(i)]; 
    end
end

%assign to struct
onsets{4} = onsets_pos/1000;
onsets{5} = onsets_neg/1000;

durations{4} = str2double(durations_pos)/1000;
durations{5} = str2double(durations_neg)/1000;



%onsets and durations: stimuli --> to be split up in loop
onsets_stim=(uber_data_all{6}/1000); %ms to sec
durations_stim=str2double(uber_data_all{7})/1000;

%create a regressor for each trial (stim pres) for GLM-seperate
%--------------------------------------------------------------------------
%make index 
index = true(1, numel(onsets_stim));

for trial=1:numel(onsets_stim)
    %make onset_trial/duration_trial for each trial
    %onset_trial = strcat('onset_trial_', num2str(trial));
    onset_trial = onsets_stim(trial);
    duration_trial = durations_stim(trial);
    
    %make onset_rest/duration_rest regressor
    index(trial) = false;
    onset_rest  = onsets_stim(index);
    duration_rest = durations_stim(index);
    index(trial) = true;
    
    %assign these to struct
    onsets{1} = onset_trial
    durations{1} = duration_trial
    onsets{2} = onset_rest
    durations{2} = duration_rest
    

    %save file ----------------------------------------------------------------
    savedir=fullfile(padi.log, 'fmri', 'concatenated', 'GLM_seperate', [strcat('trial_', num2str(trial))]);

    %make dir for conditions file
    if~exist(savedir)
        mkdir(savedir);
    end
    
    savename=fullfile(savedir,'conditions.mat');
    save(savename,'names','onsets','durations');
    
    
    %make output stats directory (for the SPM.mat file for matrix to save)
    matrixdir=fullfile(padi.stats, 'fmri', 'GLM_seperate', SUBJNAME, [strcat('trial_', num2str(trial))]);
    
    %make dir for matrix file
    if~exist(matrixdir)
        mkdir(matrixdir)
    end
    
end

clear names onsets durations






% CONCATENATE THE REALIGNMENT PARAMENTERS (R1,R2,R3)
%------------------------------------------------------------------------


uber_rp = []

for c_runs = 1:numel(padi.runs) %padi.runs has 3 runs
    % combine the movement parameters from each run into one
    %get files
    rp_dirs=dir(fullfile(padi.data,SUBJNAME,'func',padi.runs{c_runs}, '*.txt'));
    rp_filename=fullfile(padi.data,SUBJNAME,'func',padi.runs{c_runs},rp_dirs.name);

    % open datafile
    %fid=fopen(rp_filename);
    %rpdata=textscan(fid,'%s %s %s %s %s %s', 'delimiter',',');
    R{c_runs} = load(rp_filename)
    
    %combine the data from runs
    %uber_rp{c_runs} = rpdata;
    
end

%combine all runs into one
rp_all=[R{1};R{2};R{3}];

%save this rp file
savedir_rp = fullfile(padi.data, SUBJNAME, 'func', 'concatenated');

%make dir for rp file
if~exist(savedir_rp)
    mkdir(savedir_rp)
end

rp_savename=fullfile(savedir_rp, ['rp_' SUBJNAME '_concatenated.txt']);

%save
save(rp_savename, 'rp_all', '-ascii')



