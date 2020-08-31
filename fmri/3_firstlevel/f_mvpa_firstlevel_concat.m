function f_mvpa_firstlevel_concat(SUBJNAME)

%--------------------------------------------------------------------------
%
% Does the firstlevel stats for MVPA
% 
%
% BL2019
%--------------------------------------------------------------------------

%get SUBJNAME
if ~exist('SUBJNAME')
    SUBJNAME=char(inputdlg('Which subject?'));
end


% RUN JOB #1: FIRST-LEVEL: MODEL SPECIFICATION
%--------------------------------------------------------------------------

%load in batch
load 1_model_spec_concat

%replace subject code
matlabbatch=struct_string_replace(matlabbatch,'mvpa024',SUBJNAME);

%run with SPM
spm_jobman('run',matlabbatch); clear matlabbatch


% Concateonate runs here 
%--------------------------------------------------------------------------

%path settings
padi=i_mvpa_infofile(SUBJNAME);

%get dir for new SPM.mat file
matrixdir=fullfile(padi.stats, 'fmri', 'concatenated', SUBJNAME, 'SPM.mat')

scans = [350 350 350];
spm_fmri_concatenate(matrixdir, scans);


% APPLY CHANGES TO MATRIX: ESTIMATE MODEL
%--------------------------------------------------------------------------
%load in batch
load 2_model_est_concat

%replace subject code
matlabbatch=struct_string_replace(matlabbatch,'mvpa024',SUBJNAME);

%run with SPM
spm_jobman('run',matlabbatch); clear matlabbatch



% CONSTRAST MANAGER
%--------------------------------------------------------------------------
%load in batch
load 3_contrast_manager_concat

%replace subject code
matlabbatch=struct_string_replace(matlabbatch,'mvpa024',SUBJNAME);

%run with SPM
spm_jobman('run',matlabbatch); clear matlabbatch


