clear all; clc;


% this makes the conditions files for non concat runs 

% Settings
subjpath='E:\greebles\data';

subjlist=dir(fullfile(subjpath,'mvpa*'));

subjincl=[1:22];

% Run each subject
for c_subj = subjincl
    
    f_mvpa_makeconditions(subjlist(c_subj).name);
    
end