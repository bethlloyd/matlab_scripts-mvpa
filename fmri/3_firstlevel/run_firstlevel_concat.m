clear all; clc;

% Settings
subjpath='E:\greebles\data';

subjlist=dir(fullfile(subjpath,'mvpa*'));

subjincl=[2:3];

% Run each subject
for c_subj = subjincl
    
    f_mvpa_firstlevel_concat(subjlist(c_subj).name);
    
end