function f_second_level(SUBJNAME)


%--------------------------------------------------------------------------
%
% This script loads in the batch for the 2nd level analayis and adjusts
% folders/conmaps to run all contrasts in contrast folder
% 
%
% BL2019
%--------------------------------------------------------------------------

% Settings
contrastpath ='E:\greebles\stats\fmri\group_analysis\contrasts';

contrast_list=dir(contrastpath);

conincl=[3:9];

% Run each subject
for c_con = conincl
    
    %load in batch
    load second_level_batch

    %replace subject code
    matlabbatch=struct_string_replace(matlabbatch,'stim_pos',contrast_list(c_con).name);

    %run with SPM
    spm_jobman('run',matlabbatch); clear matlabbatch

    
end