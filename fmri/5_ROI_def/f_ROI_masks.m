function f_ROI_masks(SUBJNAME)

%--------------------------------------------------------------------------
%
% This normalises and write the ROI masks into native space T1 for each
% subj
%
% Then it coregisters + reslice these images to make sure in same space as
% T1
% Then it moves the new masks into subject folders 
%
% For final region (right lPFC) --> also need to make the normalised mask
% binary before coregistration 
%
% BL2019
%--------------------------------------------------------------------------

%get SUBJNAME
if ~exist('SUBJNAME')
    SUBJNAME=char(inputdlg('Which subject?'));
end

%path settings
padi=i_mvpa_infofile(SUBJNAME);


% r_FFA: NORMALISE & WRITE - coreg reslice
%--------------------------------------------------------------------------

%load in batch
load r_FFA_norm_write

%replace subject code
matlabbatch=struct_string_replace(matlabbatch,'mvpa001',SUBJNAME);

%run with SPM
spm_jobman('run',matlabbatch); clear matlabbatch


%move files to subj folder 
save_dir = fullfile(padi.data, SUBJNAME, 'ROIs');
% 
%make dir 
if~exist(save_dir)
    mkdir(save_dir)
end

old_rFFA_roi = fullfile(padi.templates, 'Jiang_2007', 'right_FFA', 'rnw_r_FFA.nii');
new_rFFA_roi = fullfile(save_dir, [strcat(SUBJNAME, '_right_FFA_roi.nii')]);
movefile(old_rFFA_roi,new_rFFA_roi)

%delete nw_ file (image not coregistered)
norm_file = fullfile(padi.templates, 'Jiang_2007', 'right_FFA', 'nw_r_FFA.nii');
delete(norm_file)



% l_FFA: NORMALISE & WRITE - coreg reslice
%--------------------------------------------------------------------------

%load in batch
load l_FFA_norm_write

%replace subject code
matlabbatch=struct_string_replace(matlabbatch,'mvpa001',SUBJNAME);

%run with SPM
spm_jobman('run',matlabbatch); clear matlabbatch


old_lFFA_roi = fullfile(padi.templates, 'Jiang_2007', 'left_FFA', 'rnw_l_FFA_roi.nii');
new_lFFA_roi = fullfile(save_dir, [strcat(SUBJNAME, '_left_FFA_roi.nii')]);
movefile(old_lFFA_roi,new_lFFA_roi)

%delete nw_ file (image not coregistered)
norm_file = fullfile(padi.templates, 'Jiang_2007', 'left_FFA', 'nw_l_FFA_roi.nii');
delete(norm_file)




% r_LO: NORMALISE & WRITE - coreg reslice
%--------------------------------------------------------------------------

%load in batch
load r_LO_norm_write

%replace subject code
matlabbatch=struct_string_replace(matlabbatch,'mvpa001',SUBJNAME);

%run with SPM
spm_jobman('run',matlabbatch); clear matlabbatch


old_rLO_roi = fullfile(padi.templates, 'Jiang_2007', 'right_LO', 'rnw_r_LO.nii');
new_rLO_roi = fullfile(save_dir, [strcat(SUBJNAME, '_right_LO_roi.nii')]);
movefile(old_rLO_roi,new_rLO_roi)

%delete nw_ file (image not coregistered)
norm_file = fullfile(padi.templates, 'Jiang_2007', 'right_LO', 'nw_r_LO.nii');
delete(norm_file)


% l_LO: NORMALISE & WRITE - coreg reslice
%--------------------------------------------------------------------------

%load in batch
load l_LO_norm_write

%replace subject code
matlabbatch=struct_string_replace(matlabbatch,'mvpa001',SUBJNAME);

%run with SPM
spm_jobman('run',matlabbatch); clear matlabbatch


old_lLO_roi = fullfile(padi.templates, 'Jiang_2007', 'left_LO', 'rnw_l_LO.nii');
new_lLO_roi = fullfile(save_dir, [strcat(SUBJNAME, '_left_LO_roi.nii')]);
movefile(old_lLO_roi,new_lLO_roi)

%delete nw_ file (image not coregistered)
norm_file = fullfile(padi.templates, 'Jiang_2007', 'left_LO', 'nw_l_LO.nii');
delete(norm_file)



% right_lPFC: NORMALISE & WRITE - coreg reslice
%--------------------------------------------------------------------------

%load in batch
load r_lPFC_norm_write

%replace subject code
matlabbatch=struct_string_replace(matlabbatch,'mvpa001',SUBJNAME);

%run with SPM
spm_jobman('run',matlabbatch); clear matlabbatch

old_r_lPFC_roi = fullfile(padi.templates, 'Jiang_2007', 'all_right_lPFC', 'rbinary_r_lPFC.nii');
new_r_lPFC_roi = fullfile(save_dir, [strcat(SUBJNAME, '_right_lPFC_roi.nii')]);
movefile(old_r_lPFC_roi,new_r_lPFC_roi)

%delete nw_ file and binary file (image not coregistered)
norm_file = fullfile(padi.templates, 'Jiang_2007', 'all_right_lPFC', 'wall_r_lPFC.nii');
delete(norm_file);
binary_file = fullfile(padi.templates, 'Jiang_2007', 'all_right_lPFC', 'rwall_r_lPFC.nii');
delete(binary_file);





% left_lPFC: NORMALISE & WRITE - coreg reslice
%--------------------------------------------------------------------------

%load in batch
load l_lPFC_norm_write

%replace subject code
matlabbatch=struct_string_replace(matlabbatch,'mvpa001',SUBJNAME);

%run with SPM
spm_jobman('run',matlabbatch); clear matlabbatch

old_l_lPFC_roi = fullfile(padi.templates, 'Jiang_2007', 'all_left_lPFC', 'rbinary_l_lPFC.nii');
new_l_lPFC_roi = fullfile(save_dir, [strcat(SUBJNAME, '_left_lPFC_roi.nii')]);
movefile(old_l_lPFC_roi,new_l_lPFC_roi)

%delete nw_ file and binary file (image not coregistered)
norm_file = fullfile(padi.templates, 'Jiang_2007', 'all_left_lPFC', 'wall_l_lPFC.nii');
delete(norm_file);
binary_file = fullfile(padi.templates, 'Jiang_2007', 'all_left_lPFC', 'rwall_l_lPFC.nii');
delete(binary_file);


