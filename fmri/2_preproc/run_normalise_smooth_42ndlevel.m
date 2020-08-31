clear all; clc;

% Settings
subjpath='E:\greebles\data';

subjlist=dir(fullfile(subjpath,'mvpa*'));

subjincl=[1];

% Run each subject
for c_subj = subjincl
    
    a_normalise_smooth_42ndlevel(subjlist(c_subj).name);
    
end