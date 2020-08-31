function f_mvpa_firstlevel(SUBJNAME)

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


% RUN JOB #1: FIRST-LEVEL
%--------------------------------------------------------------------------

%load in batch
load 1_mvpa_firstlevel

%replace subject code
matlabbatch=struct_string_replace(matlabbatch,'mvpa001',SUBJNAME);

%run with SPM
spm_jobman('run',matlabbatch); clear matlabbatch





