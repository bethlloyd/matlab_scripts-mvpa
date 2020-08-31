clear all; clc;

% Settings
subjpath='E:\greebles\data';

subjlist=dir(fullfile(subjpath,'mvpa*'));

subjincl=[2:22];

% Run each subject
for c_subj = subjincl
    
    f_move_contrast_maps(subjlist(c_subj).name);
    
end