function f_mvpa_p2n(SUBJNAME)
%--------------------------------------------------------------------------
%
% PAR/REC to niftii convertion using SPM [MVPA]
%
%Blloyd2020
%--------------------------------------------------------------------------


%get SUBJNAME
if ~exist('SUBJNAME')
    SUBJNAME=char(inputdlg('Which subject?'));
end


%path settings
padi=i_mvpa_infofile(SUBJNAME);
parpath=padi.rawdata;
datapath=padi.data;

%when downloading from the CBI calander the "_" gets removed
%SUBJNAMEcbi=['sub-' erase(SUBJNAME,'_')];


% Do not change anything below [only bugs]
%--------------------------------------------------------------------------



% Loop over par folders [in 'raw']
for c_type = 1:numel(padi.datatypes)

    %get dir paths
    sourcedir=fullfile(parpath,SUBJNAME,padi.datatypes{c_type});
    newdir=fullfile(datapath,SUBJNAME,padi.datatypes{c_type});
    
    %make dir
    if~exist(newdir)
        mkdir(newdir)
    end
    
    if c_type == 1
        
        for c_runs = 1:numel(padi.runs)

            %get run paths
            rundir = fullfile(newdir, padi.runs{c_runs});

            %make dir
            if ~exist(rundir)
                mkdir(rundir)
            end
        end
    end
    
    %get files
    %datafiles=dir(fullfile(sourcedir,'*.PAR'));

    %path
    outputdir=newdir;

    %get PAR images
    parfiles=dir([sourcedir,filesep,'*.PAR']);

    %load SPM job [does the PAR to niftii convertion]
    load f_p2n

    %change input of the SPM BATCH
    matlabbatch{1}.spm.util.import.parrec.data = ...
        cellstr(strcat(fullfile(sourcedir,filesep,cellstr(char(parfiles.name)))));
    matlabbatch{1}.spm.util.import.parrec.opts.outdir = ...
        cellstr(outputdir);

    %run the SPM BATCH
    spm_jobman('run',matlabbatch);

    %get niftiis
    newfiles=dir(fullfile(outputdir,'*.nii'));

    %loop over niftiis and change name
    for c_f=1:numel(newfiles)

        oldfile=fullfile(outputdir,newfiles(c_f).name);

        if contains(oldfile, 'Run1')
            newdir=fullfile(outputdir, 'Run1');
            newfile=fullfile(outputdir, 'Run1',...
                [char(SUBJNAME) '_' 'Run1' '.nii']);

        elseif contains(oldfile, 'Run2')
             newdir=fullfile(outputdir, 'Run2');
            newfile=fullfile(outputdir, 'Run2',...
                [char(SUBJNAME) '_' 'Run2' '.nii']);

        elseif contains(oldfile, 'Run3')
             newdir=fullfile(outputdir, 'Run3');
            newfile=fullfile(outputdir, 'Run3',...
                [char(SUBJNAME) '_' 'Run3' '.nii']);

        else
            newdir=outputdir;
            newfile=fullfile(outputdir,...
                [char(SUBJNAME) '_T1_anat' '.nii']);
        end

        %by moving the file the name is changed
        movefile(oldfile,newfile)

        clear matlabbatch
        
        %convert 4d to 3d images
        load f_4d23d
        
        %take file just made
        inputvol=newfile;
        
        matlabbatch{1}.spm.util.split.vol = {inputvol};
        matlabbatch{1}.spm.util.split.outdir = {newdir};

        %run the SPM BATCH
        spm_jobman('run',matlabbatch);

        delete(inputvol)
      
        clear matlabbatch
        
    end %c_runs
    
end %c_type





