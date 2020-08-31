clear all; clc;

% Settings
subjpath='E:\greebles\rawdata';

subjlist=dir(fullfile(subjpath,'mvpa*'));

subjincl=[7:9];

% Run each subject
for c_subj = subjincl
    
    f_mvpa_p2n(subjlist(c_subj).name);
    
end