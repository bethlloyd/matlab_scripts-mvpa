function f_move_contrast_maps(SUBJNAME)


%--------------------------------------------------------------------------
%
% This script moves the con maps from indiv folder into 1 folder for each
% type of contrast
% 
%
% BL2019
%--------------------------------------------------------------------------

%get SUBJNAME
if ~exist('SUBJNAME')
    SUBJNAME=char(inputdlg('Which subject?'));
end

%path settings
padi=i_mvpa_infofile(SUBJNAME);


% get contrast file from original folder
% constrast STIM POS
 old_con = fullfile(padi.stats, 'fmri', 'stimuli_contrast', SUBJNAME,'con_0001.nii')
 new_con = fullfile(padi.stats, 'fmri', 'group_analysis', 'contrasts', 'stim_pos', [strcat('conmap01_', SUBJNAME, '.nii')])
 movefile(old_con,new_con) %change new and location of conmap
    
% get contrast file from original folder 
% contrast F-TEST STIMPOS
 old_con = fullfile(padi.stats, 'fmri', 'stimuli_contrast', SUBJNAME,'ess_0002.nii')
 new_con = fullfile(padi.stats, 'fmri', 'group_analysis', 'contrasts', 'f_test_stimpos', [strcat('conmap02_', SUBJNAME, '.nii')])
 movefile(old_con,new_con)
 
 % get contrast file from original folder 
 %contrast: R1 > R2
 old_con = fullfile(padi.stats, 'fmri', 'stimuli_contrast', SUBJNAME,'con_0003.nii')
 new_con = fullfile(padi.stats, 'fmri', 'group_analysis', 'contrasts', 'r1_gr_r2', [strcat('conmap03_', SUBJNAME, '.nii')])
 movefile(old_con,new_con)
 
  % get contrast file from original folder 
 %contrast: R1 > R3
 old_con = fullfile(padi.stats, 'fmri', 'stimuli_contrast', SUBJNAME,'con_0004.nii')
 new_con = fullfile(padi.stats, 'fmri', 'group_analysis', 'contrasts', 'r1_gr_r3', [strcat('conmap04_', SUBJNAME, '.nii')])
 movefile(old_con,new_con)
 
 
   % get contrast file from original folder 
 %contrast: R2 > R3
 old_con = fullfile(padi.stats, 'fmri', 'stimuli_contrast', SUBJNAME,'con_0005.nii')
 new_con = fullfile(padi.stats, 'fmri', 'group_analysis', 'contrasts', 'r2_gr_r3', [strcat('conmap05_', SUBJNAME, '.nii')])
 movefile(old_con,new_con)
 
  
   % get contrast file from original folder 
 %contrast: R3 > R1
 old_con = fullfile(padi.stats, 'fmri', 'stimuli_contrast', SUBJNAME,'con_0006.nii')
 new_con = fullfile(padi.stats, 'fmri', 'group_analysis', 'contrasts', 'r3_gr_r1', [strcat('conmap06_', SUBJNAME, '.nii')])
 movefile(old_con,new_con)
 

   % get contrast file from original folder 
 %contrast: R3 > R2
 old_con = fullfile(padi.stats, 'fmri', 'stimuli_contrast', SUBJNAME,'con_0007.nii')
 new_con = fullfile(padi.stats, 'fmri', 'group_analysis', 'contrasts', 'r3_gr_r2', [strcat('conmap07_', SUBJNAME, '.nii')])
 movefile(old_con,new_con)
 
 

   % get contrast file from original folder 
 %contrast: R2 > R1
 old_con = fullfile(padi.stats, 'fmri', 'stimuli_contrast', SUBJNAME,'con_0008.nii')
 new_con = fullfile(padi.stats, 'fmri', 'group_analysis', 'contrasts', 'r2_gr_r1', [strcat('conmap08_', SUBJNAME, '.nii')])
 movefile(old_con,new_con)
 
 %done
 
 