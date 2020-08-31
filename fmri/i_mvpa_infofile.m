function padi=i_mvpa_infofile(SUBJNAME)

%paths
padi.main='E:\greebles\';
padi.rawdata=fullfile(padi.main,'rawdata');
padi.data=fullfile(padi.main, 'data');
padi.log=fullfile(padi.data, SUBJNAME, 'log');
padi.behav=fullfile(padi.log, 'behavioural');
padi.stats=fullfile(padi.main,'stats');
padi.templates=fullfile(padi.main, 'templates');


padi.datatypes={'func', 'struc'};
padi.runs={'Run1', 'Run2', 'Run3'};

%get T1
padi.T1pattern=fullfile('*3DT1*');
if ~isempty(dir(fullfile(padi.data, SUBJNAME,'struc', padi.T1pattern)))
    T1=dir(fullfile(padi.data, SUBJNAME,'struc', padi.T1pattern));
    padi.T1=fullfile(padi.data,SUBJNAME,'struc',T1.name,[SUBJNAME '_0001.nii']);
    padi.flowfields=fullfile(padi.data,SUBJNAME,'struc',T1.name,['y_' SUBJNAME '_0001.nii']);
end

