function DRBUDDI(pe1_dir, pe2_dir, T2_dir, bvals_dir, bvecs_dir, results_dir)


[filename, pe1, pe2] = return_file_name_pe(pe1_dir, pe2_dir);
pe1_corrected_dir = [results_dir, filename,'_',pe1, '_DRBUDDI_corrected.nii.gz'];
pe2_corrected_dir = [results_dir, filename,'_',pe2, '_DRBUDDI_corrected.nii.gz'];
pe1_new_dir = [results_dir, filename,'_',pe1, '.nii.gz'];
pe2_new_dir = [results_dir, filename,'_',pe2, '.nii.gz'];


% DIFFPREP changes radiological to neurological so we cp data to DRBUDDIfolder first
system(['cp ', pe1_dir, ' ', pe1_new_dir]);
system(['cp ', pe2_dir, ' ', pe2_new_dir]);

if strcmp(bvals_dir, '')
    
    % create bvals and bvecs
    bvals_dir = [results_dir, 'b0.bval'];
    bvecs_dir = [results_dir, 'b0.bvec'];
    bvals_b0 = zeros(1,2);
    bvecs_b0 = zeros(3,2);
    bvecs_b0(1,:) = 1;
    save(bvals_dir, 'bvals_b0', '-ascii');
    save(bvecs_dir, 'bvecs_b0', '-ascii');
    
end

[~, nvols] = system(['fslnvols ', pe1_new_dir]);
nvols = str2num(nvols);

if (nvols == 1)
    system(['fslmerge -t ', pe1_new_dir, ' ', pe1_new_dir, ' ', pe1_new_dir]);
    system(['fslmerge -t ', pe2_new_dir, ' ', pe2_new_dir, ' ', pe2_new_dir]);
end


system(['DIFFPREP --dwi ', pe1_new_dir, ' --bvecs ', bvecs_dir, ' --bvals ', bvals_dir, ' -p vertical -s ', T2_dir, ' --epi off ', ' --step 0 --will_be_drbuddied 1']);
system(['DIFFPREP --dwi ', pe2_new_dir, ' --bvecs ', bvecs_dir, ' --bvals ', bvals_dir, ' -p vertical -s ', T2_dir, ' --epi off ', ' --step 0 --will_be_drbuddied 1']);

pe1_list_dir = [results_dir, pe1_filename, '_proc.list'];
pe2_list_dir = [results_dir, pe2_filename, '_proc.list'];
system(['DR_BUDDI --up_data ', pe1_list_dir, ' --down_data ', pe2_list_dir, ' --structural ', T2_dir]);




%    Neurological to Radiological
system(['fslswapdim ', results_dir, pe1_filename, '_proc_DRBUDDI.nii x -y z ', pe1_corrected_dir]);
system(['fslorient -swaporient ', pe1_corrected_dir]);

system(['fslswapdim ', results_dir, pe2_filename, '_proc_DRBUDDI.nii x -y z ', pe2_corrected_dir]);
system(['fslorient -swaporient ', pe2_corrected_dir]);


if (nvols == 1)
    system(['fslroi ', pe1_corrected_dir, ' ',  pe1_corrected_dir, ' 0 1']);
    system(['fslroi ', pe2_corrected_dir, ' ',  pe2_corrected_dir, ' 0 1']);
end






end
















