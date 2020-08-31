clear all; clc;

% Settings
subjpath='E:\greebles\data';

subjlist=dir(fullfile(subjpath,'mvpa*'));

subjincl=[5:22];

% Run each subject
for c_subj = subjincl
    
    f_mvpa_firstlevel(subjlist(c_subj).name);
    
end