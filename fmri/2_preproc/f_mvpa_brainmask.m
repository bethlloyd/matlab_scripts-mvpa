function f_mvpa_brainmask(SUBJNAME)


%--------------------------------------------------------------------------
%
% Creates a brain mask for each subject using segmentation in SPM

%get SUBJNAME
if ~exist('SUBJNAME')
    SUBJNAME=char(inputdlg('Which subject?'));
end

%load in batch
load 5_brainmask

%replace subject code
matlabbatch=struct_string_replace(matlabbatch,'mvpa001',SUBJNAME);

%run with SPM
spm_jobman('run',matlabbatch); clear matlabbatch



