
% After convertion par/rec to nii > all images in same space

% Realignment will change this because it will align all the brains and
% therefore changes the space of the images to make them align (output is
% thus the realignment parameters which indicate how much an image was
% moved to make it align)

% Mean image is same space as first func

% After coreg est, transformation matrix changed again (still not same
% across the functional images), mean also changed

% To apply the changes, we need to reslice (coreg reslice) them all to the 
% mean image,after that they have all the same matrix

% Importantly, they do not have the same matrix as the T1, because the T1
% has different dimientions/voxel size. Therefore, when you use the T1 and
% segment it f.e. extract the hippocampus, this will initially have the
% dims/voxel size of the T1, therefore you need to coreg_reslice these
% segmentation images (also .nii) again to the mean. 

% after all of this, your ROI/mask will be in the same space as the
% functional images and can therefor safely extract signal from the voxels
% of the functional images for that given ROI/mask

for r = 1:3
    
    for i = 4:8

        if i>99
            hdr_f=spm_vol(['func\Run',num2str(r),'\srmvpa003_Run',num2str(r),'_00',num2str(i),'.nii']);
            hdr_f.mat
        elseif i>9
            hdr_f=spm_vol(['func\Run',num2str(r),'\srmvpa003_Run',num2str(r),'_000',num2str(i),'.nii']);
            hdr_f.mat
        else
            hdr_f=spm_vol(['func\Run',num2str(r),'\srmvpa003_Run',num2str(r),'_0000',num2str(i),'.nii']);
            hdr_f.mat
        end
    end

end

         
% check mean image         
hdr_f=spm_vol(['E:\greebles\data\mvpa001\struc\mvpa001_T1_anat_00001.nii']);
hdr_f.mat

% check struc anat scan         
hdr_a=spm_vol('E:\greebles\data\mvpa001\func\Run1\mvpa001_Run1_00165.nii');
hdr_a.mat
 
% check struc anat scan         
hdr_a=spm_vol('E:\greebles\data\mvpa001\func\Run1\rmvpa001_Run1_00096.nii');
hdr_a.mat

% check struc anat scan         
hdr_a=spm_vol('C:\Users\lloydb\surfdrive\ExperimentData\toolbox\spm12\spm12\canonical\avg152T1.nii');
hdr_a.mat
