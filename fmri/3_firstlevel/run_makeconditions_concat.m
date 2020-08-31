clear all; clc;

% Settings
subjpath='E:\greebles\data';

subjlist=dir(fullfile(subjpath,'mvpa*'));

subjincl=[4:21];

% Run each subject
for c_subj = subjincl
    
    f_makeconditions_concat(subjlist(c_subj).name);
    
end