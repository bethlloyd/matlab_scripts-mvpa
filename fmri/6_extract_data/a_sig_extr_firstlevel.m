function a_sig_extr_firstlevel(SUBJNAME)

% 
%--------------------------------------------------------------------------
%
%
% extracts signal from all T maps within a single subject GLM
%
% PATH SETTINGS
%--------------------------------------------------------------------------

%get SUBJNAME
if ~exist('SUBJNAME')
    SUBJNAME=char(inputdlg('Which subject?'));
end

%path settings
padi=i_mvpa_infofile(SUBJNAME);

roidir=fullfile(padi.data,SUBJNAME,'ROIs');
statsdir=fullfile(padi.stats, 'fmri', 'GLM_seperate', SUBJNAME);

left_FFA_roi=strcat(SUBJNAME,'_left_FFA_roi.nii');  %define ROI filenames
left_LO_roi=strcat(SUBJNAME,'_left_LO_roi.nii');
right_FFA_roi=strcat(SUBJNAME,'_right_FFA_roi.nii');
right_LO_roi=strcat(SUBJNAME,'_right_LO_roi.nii');
right_lPFC_roi=strcat(SUBJNAME,'_right_lPFC_roi.nii');
left_lPFC_roi=strcat(SUBJNAME,'_left_lPFC_roi.nii');
roinames= {left_lPFC_roi};%{left_FFA_roi,left_LO_roi,right_FFA_roi,right_LO_roi,right_lPFC_roi}; %make list of ROIs

%output folders
extracted_voxdir=fullfile(padi.stats, 'fmri', 'extracted_voxels');
l_FFA_dir=fullfile(extracted_voxdir, 'left_FFA_roi');
l_LO_dir=fullfile(extracted_voxdir, 'left_LO_roi');
r_FFA_dir=fullfile(extracted_voxdir, 'right_FFA_roi');
r_LO_dir=fullfile(extracted_voxdir, 'right_LO_roi');
r_lpfc_dir=fullfile(extracted_voxdir, 'right_lPFC_roi');
l_lpfc_dir=fullfile(extracted_voxdir, 'left_lPFC_roi');
roi_dirs= {l_lpfc_dir};%{l_FFA_dir, l_LO_dir, r_FFA_dir, r_LO_dir, r_lpfc_dir};

% GET DATA
%--------------------------------------------------------------------------

subjdirs=(statsdir);
extracteddata{1}={'subjname'};

%loops over subjects
%for c_ss=1:numel(subjdirs);

%get the t maps that are in the subject folder
%subfol=subjdirs.name;    
conmapdisr=dir(fullfile(subjdirs,'Tmap_*.nii'));

%loop over beta maps
for c_cmaps=1:numel(conmapdisr);

    %get the beta map hdr      
    c_hdr=spm_vol(fullfile(subjdirs,conmapdisr(c_cmaps).name));        

    %get name of the contrast
    c_name{c_cmaps}=c_hdr.descrip(19:end);

    %replace signs
    %c_name{c_cmaps}(isspace(c_name{c_cmaps}))='_';
    %c_name{c_cmaps}(findstr(c_name{c_cmaps},'>'))='g';
    %c_name{c_cmaps}(findstr(c_name{c_cmaps},'<'))='k';

    %loop over roi's
    for c_roi=1:numel(roinames)

        %get hdr of roi
        r_hdr=spm_vol(fullfile(roidir,roinames{c_roi}));        

        %check dimentions
        if abs(sum(sum(c_hdr.mat-r_hdr.mat)))>0
            error('ROI and CONTRAST MAP are not in the same space!')
        end

        %get roi coordinates
        roixyz{c_roi} = f_threeDfind(fullfile(roidir,roinames{c_roi}),1);

        %get number of voxels: 
        num_voxels=numel(spm_get_data(fullfile(subjdirs,conmapdisr(c_cmaps).name),roixyz{c_roi}))

        %get the data from the images based on the ROI
        %extracteddata{c_roi}(2,1)=cellstr(subjdirs);
        extracteddata{c_roi}(c_cmaps+1, 1)=cellstr(strcat('trial_', num2str(c_cmaps)));
        %extracteddata{c_roi}(1,2)=cellstr(c_name{c_cmaps});
        extracteddata{c_roi}(c_cmaps+1,2:num_voxels+1)=num2cell(spm_get_data(fullfile(subjdirs,conmapdisr(c_cmaps).name),roixyz{c_roi}));

        if c_cmaps == 1
            extracteddata{c_roi}(1,:) = [];
        end
   
    end %roi

end %contrast maps


for c_roi=1:numel(roinames)
  % SAVE DATA
%--------------------------------------------------------------------------
    %remove 2nd row (full of commas) 
    extracteddata{c_roi}(2,:) = [];
    newroi_name=erase(roinames{c_roi}, '.nii');

    filename=strcat(newroi_name,'.csv');
    savefilename=fullfile(roi_dirs{c_roi},filename);
    cell2csv(savefilename,extracteddata{c_roi});

end

