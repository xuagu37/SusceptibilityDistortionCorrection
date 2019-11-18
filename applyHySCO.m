function applyHySCO(pe1_dir, pe2_dir, dwi1_dir, dwi2_dir, results_dir)

addpath(genpath('/home/xuagu37/spm12'));

[filename1, pe1, pe2] = return_file_name_pe(pe1_dir, pe2_dir);
pe1_new_dir = [results_dir, filename1,'_',pe1, '.nii'];
pe2_new_dir = [results_dir, filename1,'_',pe2, '.nii'];
[filename2, ~, ~] = return_file_name_pe(dwi1_dir, dwi2_dir);
dwi1_new_dir = [results_dir, filename2,'_',pe1, '.nii'];
dwi2_new_dir = [results_dir, filename2,'_',pe2, '.nii'];

dwi1_corrected_dir = [results_dir, filename2,'_',pe1, '_HySCO_corrected.nii.gz'];
dwi2_corrected_dir = [results_dir, filename2,'_',pe2, '_HySCO_corrected.nii.gz'];

if (contains(pe1, 'LR') || contains(pe2, 'LR'))
    A{1} = 'matlabbatch{1}.spm.tools.dti.prepro_choice.hysco_choice.hysco2.perm_dim = 1;';
    
elseif (contains(pe1, 'AP') || contains(pe2, 'AP'))
    A{1} = 'matlabbatch{1}.spm.tools.dti.prepro_choice.hysco_choice.hysco2.perm_dim = 2;';
    
end

% HySCO only takes .nii but not .nii.gz

system(['cp ', pe1_dir, ' ', results_dir]);
system(['cp ', pe2_dir, ' ', results_dir]);
system(['cp ', dwi1_dir, ' ', results_dir]);
system(['cp ', dwi2_dir, ' ', results_dir]);
system(['gunzip -f ' results_dir, filename1,'_',pe1, '.nii.gz']);
system(['gunzip -f ' results_dir, filename1,'_',pe2, '.nii.gz']);
system(['gunzip -f ' results_dir, filename2,'_',pe1, '.nii.gz']);
system(['gunzip -f ' results_dir, filename2,'_',pe2, '.nii.gz']);

[~, dim4] = system(['fslval ', dwi1_dir, ' dim4']);
dim4 = str2num(dim4);

A{2} = ['matlabbatch{1}.spm.tools.dti.prepro_choice.hysco_choice.hysco2.source_up = {''', pe2_new_dir, ',1''};'];
A{3} = ['matlabbatch{1}.spm.tools.dti.prepro_choice.hysco_choice.hysco2.source_dw = {''', pe1_new_dir, ',1''};'];
A{4} = 'matlabbatch{1}.spm.tools.dti.prepro_choice.hysco_choice.hysco2.dummy_fast = 1;';
A{5} = 'matlabbatch{1}.spm.tools.dti.prepro_choice.hysco_choice.hysco2.dummy_ecc = 0;';
A{6} = 'matlabbatch{1}.spm.tools.dti.prepro_choice.hysco_choice.hysco2.alpha = 50;';
A{7} = 'matlabbatch{1}.spm.tools.dti.prepro_choice.hysco_choice.hysco2.beta = 10;';
A{8} = 'matlabbatch{1}.spm.tools.dti.prepro_choice.hysco_choice.hysco2.dummy_3dor4d = 0;';
A{9} = 'matlabbatch{1}.spm.tools.dti.prepro_choice.hysco_choice.hysco2.restrictdim = [1, 1, 1];';
A{10} = 'matlabbatch{1}.spm.tools.dti.prepro_choice.hysco_choice.hysco2.others_up = {';
for i = 1:dim4
    A{10+i} = ['''', dwi2_new_dir, ',', num2str(i), ''''];    
end
A{10+dim4+1} = '};';
A{10+dim4+2} = 'matlabbatch{1}.spm.tools.dti.prepro_choice.hysco_choice.hysco2.others_dw = {';
for i = 1:dim4
    A{10+dim4+2+i} = ['''', dwi1_new_dir, ',', num2str(i), ''''];
    
end
A{10+dim4+dim4+3} = '};';

% Write cell A into txt
fid = fopen([results_dir, 'HySCO_job2.m'], 'w');
for i = 1:numel(A)
fprintf(fid,'%s\n', A{i});
end
fclose(fid);

nrun = 1; % enter the number of runs here
jobfile = {[results_dir, 'HySCO_job2.m']};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});

% average AP and PA results
temp1_dir = [results_dir, 'u2', filename2,'_',pe1, '.nii'];
temp2_dir = [results_dir, 'u2', filename2,'_',pe2, '.nii'];
system(['gzip ', temp1_dir]);
system(['gzip ', temp2_dir]);
system(['mv ', temp1_dir, '.gz ', dwi1_corrected_dir]);
system(['mv ', temp2_dir, '.gz ', dwi2_corrected_dir]);




end
