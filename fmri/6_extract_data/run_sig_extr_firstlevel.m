% runs the threeDfind for each subject for each ROI mask
clear all; clc;

% Settings
subjpath='E:\greebles\data';

subjlist=dir(fullfile(subjpath,'mvpa*'));

subjincl=[2:22];

% Run each subject
for c_subj = subjincl
    
    a_sig_extr_firstlevel(subjlist(c_subj).name);
    
end