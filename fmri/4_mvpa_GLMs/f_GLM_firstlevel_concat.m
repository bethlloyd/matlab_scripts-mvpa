function f_GLM_firstlevel_concat(SUBJNAME)

%--------------------------------------------------------------------------
%
% Does the firstlevel stats sperate-GLM models for MVPA learning 
% Then deletes all files except beta,T and con maps for GLM input
%
% BL2019
%--------------------------------------------------------------------------

%get SUBJNAME
if ~exist('SUBJNAME')
    SUBJNAME=char(inputdlg('Which subject?'));
end

%path settings
padi=i_mvpa_infofile(SUBJNAME);

% RUN JOB #1: FIRST-LEVEL: MODEL SPECIFICATION
%--------------------------------------------------------------------------
n_trials = 162

for trial=1:n_trials
    
    %load in batch
    load 1_GLM_model_spec_concat
    
    %replace subject code
    matlabbatch=struct_string_replace(matlabbatch,'mvpa001',SUBJNAME);
    
    %replace trial number
    matlabbatch=struct_string_replace(matlabbatch,'trial_1',[strcat('trial_', num2str(trial))]);
    
    %run with SPM
    spm_jobman('run',matlabbatch); clear matlabbatch
    
    
    % Concateonate runs here 
    %--------------------------------------------------------------------------
    %get dir for new SPM.mat file
    matrixdir=fullfile(padi.stats, 'fmri', 'GLM_seperate', SUBJNAME, [strcat('trial_', num2str(trial))],'SPM.mat')
    %make extra 3 regressors identifying seperate runs
    scans = [350 350 350];
    spm_fmri_concatenate(matrixdir, scans);
    

    % APPLY CHANGES TO MATRIX: ESTIMATE MODEL
    %--------------------------------------------------------------------------
    %load in batch
    load 2_GLM_model_est_concat

    %replace subject code
    matlabbatch=struct_string_replace(matlabbatch,'mvpa001',SUBJNAME);
    %replace trial number
    matlabbatch=struct_string_replace(matlabbatch,'trial_1',[strcat('trial_', num2str(trial))]);
    
    %run with SPM
    spm_jobman('run',matlabbatch); clear matlabbatch
    
    % CONSTRAST MANAGER
    %--------------------------------------------------------------------------
    %load in batch
    load 3_GLM_contrast_manager_concat

    %replace subject code
    matlabbatch=struct_string_replace(matlabbatch,'mvpa001',SUBJNAME);
    %replace trial number
    matlabbatch=struct_string_replace(matlabbatch,'trial_1',[strcat('trial_', num2str(trial))]);
    
    %run with SPM
    spm_jobman('run',matlabbatch); clear matlabbatch
    
    %Move CON1, T-map and BETA maps back one folder (to subj folder)
    %contrast
    old_con = fullfile(padi.stats, 'fmri', 'GLM_seperate', SUBJNAME, [strcat('trial_', num2str(trial))],'con_0001.nii')
    new_con = fullfile(padi.stats, 'fmri', 'GLM_seperate', SUBJNAME, [strcat('conmap_trial_', num2str(trial), '.nii')])
    movefile(old_con,new_con)
    
    %T-maps
    old_T = fullfile(padi.stats, 'fmri', 'GLM_seperate', SUBJNAME, [strcat('trial_', num2str(trial))],'spmT_0001.nii')
    new_T = fullfile(padi.stats, 'fmri', 'GLM_seperate', SUBJNAME, [strcat('Tmap_trial_', num2str(trial), '.nii')])
    movefile(old_T,new_T)
    
    %beta-maps
    old_beta = fullfile(padi.stats, 'fmri', 'GLM_seperate', SUBJNAME, [strcat('trial_', num2str(trial))],'beta_0001.nii')
    new_beta = fullfile(padi.stats, 'fmri', 'GLM_seperate', SUBJNAME, [strcat('betamap_trial_', num2str(trial), '.nii')])
    movefile(old_beta,new_beta)
    
    %REMOVE UNNECESSARY FILES
    rmdir(fullfile(padi.stats, 'fmri', 'GLM_seperate', SUBJNAME, [strcat('trial_', num2str(trial))]), 's')
end


