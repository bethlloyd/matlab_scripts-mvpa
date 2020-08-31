[roi] = createroi(42,43,36,60,[2.75,2.75,3])

hdr=spm_vol('slmask_c1mvpa003_T1_anat_00001.nii');
dat=spm_read_vols(hdr)
roi_xyz=f_threeDfind('slmask_c1mvpa003_T1_anat_00001.nii',1)

hdr_roi=spm_create_vol(hdr)
hdr_roi.fname='test.nii'
dat_roi=zeros(hdr_roi.dim)

spm_write_vol(hdr_roi,dat_roi)


    
    