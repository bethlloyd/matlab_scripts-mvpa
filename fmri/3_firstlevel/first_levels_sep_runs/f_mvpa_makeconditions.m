function f_mvpa_makeconditions(SUBJNAME)


%get SUBJNAME
if ~exist('SUBJNAME')
    SUBJNAME=char(inputdlg('Which subject?'));
end


%path settings
padi=i_mvpa_infofile(SUBJNAME);

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
    fclose(fid);


    % MAKE CONDITIONS.MAT FILE [FOR SPM]
    %--------------------------------------------------------------------------

    %make files
    struct('names',{''},'onsets',{},'durations',{});
    names{1}='stimuli'; 
    names{2}='response';
    names{3}='feedback'
    
    %onsets and durations: stimuli
    onsets{1}=str2double(cdata{6})/1000; %ms to sec
    durations{1}=str2double(cdata{7})/1000;
    
    %onsets and durations: response
    onsets{2}=str2double(cdata{16})/1000; %ms to sec
    durations{2}=str2double(cdata{11})/1000; %ms to sec
    
    %onsets and durations: response
    onsets{3}=str2double(cdata{10})/1000; %ms to sec
    durations{3}=str2double(cdata{17})/1000; %ms to sec
    
    
    %save file
    savedir=fullfile(padi.log, 'fmri', padi.runs{c_runs});

    %make dir for conditions file
    if~exist(savedir)
        mkdir(savedir)
    end
    
    savename=fullfile(savedir,'conditions.mat');
    save(savename,'names','onsets','durations');

    clear names onsets durations
    
    %make output stats directory (for the SPM.mat file for matrix to save)
    matrixdir=fullfile(padi.stats, 'fmri', 'stimuli_contrast', SUBJNAME)
    
    %make dir for matrix file
    if~exist(matrixdir)
        mkdir(matrixdir)
    end
end