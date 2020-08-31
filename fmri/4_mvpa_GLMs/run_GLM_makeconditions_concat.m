clear all; clc;

% Settings
subjpath='E:\greebles\data';

subjlist=dir(fullfile(subjpath,'mvpa*'));

subjincl=[2];

% Run each subject
for c_subj = subjincl
    
    f_GLM_makeconditions_concat(subjlist(c_subj).name);
    
end