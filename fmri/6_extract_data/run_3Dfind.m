% runs the threeDfind for each subject for each ROI mask
clear all; clc;

%get SUBJNAME
if ~exist('SUBJNAME')
    SUBJNAME=char(inputdlg('Which subject?'));
end

%path settings
padi=i_mvpa_infofile(SUBJNAME);
roidir=fullfile(padi.data,SUBJNAME,'ROIs');
left_FFA_roi=strcat(SUBJNAME,'_left_FFA_roi.nii');  %define ROI filenames
left_LO_roi=strcat(SUBJNAME,'_left_LO_roi.nii');
right_FFA_roi=strcat(SUBJNAME,'_right_FFA_roi.nii');
right_LO_roi=strcat(SUBJNAME,'_right_LO_roi.nii');
right_lPFC_roi=strcat(SUBJNAME,'_right_lPFC_roi.nii');
roinames=left_FFA_roi; %make list of ROIs




%for extracting signal firstlevel 
n_trials = 162

for trial=1:n_trials

    statsdir=fullfile(padi.stats, 'fmri', 'GLM_seperate', SUBJNAME, [strcat('trial_', num2str(trial))]);
   