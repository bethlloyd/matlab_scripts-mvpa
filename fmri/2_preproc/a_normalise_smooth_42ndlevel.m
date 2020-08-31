function a_normalise_smooth_42ndlevel(SUBJNAME)

%--------------------------------------------------------------------------
%
% Does the preprocessing for 2nd Level Statistics
% - Normalise
% - Smooth
%
% BL2019
%--------------------------------------------------------------------------

%get SUBJNAME
if ~exist('SUBJNAME')
    SUBJNAME=char(inputdlg('Which subject?'));
end


% RUN JOB #1: NORMALISE (EST + RESCLICE)  --> prefix 'w'
%--------------------------------------------------------------------------
%load in batch
load normalise_est_reslice

%replace subject code
matlabbatch=struct_string_replace(matlabbatch,'mvpa003',SUBJNAME);

%run with SPM
spm_jobman('run',matlabbatch); clear matlabbatch



% RUN JOB #2: SMOOTH (4 4 4)  --> prefix 's_afterw'
%--------------------------------------------------------------------------

%load in batch
load smooth_after_norm

%replace subject code
matlabbatch=struct_string_replace(matlabbatch,'mvpa003',SUBJNAME);

%run with SPM
spm_jobman('run',matlabbatch); clear matlabbatch


