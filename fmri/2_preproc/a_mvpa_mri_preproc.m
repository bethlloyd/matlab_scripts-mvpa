function a_mvpa_mri_preproc(SUBJNAME)

%--------------------------------------------------------------------------
%
% Does the preprocessing for MVPA
% - Realign
% - Coregister
% - Smooth
%
% BL2019
%--------------------------------------------------------------------------

%get SUBJNAME
if ~exist('SUBJNAME')
    SUBJNAME=char(inputdlg('Which subject?'));
end


% RUN JOB #1: REALIGN (EST + RESCLICE MEAN)
%--------------------------------------------------------------------------

%load in batch
load 1_realign_and_est

%replace subject code
matlabbatch=struct_string_replace(matlabbatch,'mvpa001',SUBJNAME);

%run with SPM
spm_jobman('run',matlabbatch); clear matlabbatch


% RUN JOB #2: COREGISTER (EST)
%--------------------------------------------------------------------------

%load in batch
load 2_coregister_est

%replace subject code
matlabbatch=struct_string_replace(matlabbatch,'mvpa001',SUBJNAME);

%run with SPM
spm_jobman('run',matlabbatch); clear matlabbatch


% RUN JOB #3: COREGISTER (RESLICE)
%--------------------------------------------------------------------------

%load in batch
load 3_coregister_reslice

%replace subject code
matlabbatch=struct_string_replace(matlabbatch,'mvpa001',SUBJNAME);

%run with SPM
spm_jobman('run',matlabbatch); clear matlabbatch


% RUN JOB #4: SMOOTH 
%--------------------------------------------------------------------------

%load in batch
load 4_smooth

%replace subject code
matlabbatch=struct_string_replace(matlabbatch,'mvpa001',SUBJNAME);

%run with SPM
spm_jobman('run',matlabbatch); clear matlabbatch


% CLEAN UP
%--------------------------------------------------------------------------

%move files

%delete files