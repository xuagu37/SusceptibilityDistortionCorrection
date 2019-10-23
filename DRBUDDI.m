function DRBUDDI(pe1_dir, pe2_dir, T2_dir, bvals_dir, bvecs_dir, results_dir)


[filename, pe1, pe2] = return_file_name_pe(pe1_dir, pe2_dir);
pe1_corrected_dir = [results_dir, filename,'_',pe1, '_DRBUDDI_corrected.nii'];
pe2_corrected_dir = [results_dir, filename,'_',pe2, '_DRBUDDI_corrected.nii'];
pe1_new_dir = [results_dir, filename,'_',pe1, '.nii'];
pe2_new_dir = [results_dir, filename,'_',pe2, '.nii'];


% DIFFPREP changes radiological to neurological so we cp data to DRBUDDIfolder first
system(['cp ', pe1_dir, ' ', results_dir]);
system(['cp ', pe2_dir, ' ', results_dir]);
system(['gunzip -f ' pe1_new_dir, '.gz']);
system(['gunzip -f ' pe2_new_dir, '.gz']);

pe1_list_dir = [results_dir, filename,'_',pe1, '_proc.list'];
pe2_list_dir = [results_dir, filename,'_',pe2, '_proc.list'];

if (contains(pe1, 'LR') || contains(pe2, 'LR'))
    
    system(['DIFFPREP --dwi ', pe1_new_dir, ' --bvecs ', bvecs_dir, ' --bvals ', bvals_dir, ' -p horizontal -s ', T2_dir, ' --epi off --step 0 --will_be_drbuddied 1']);
    system(['DIFFPREP --dwi ', pe2_new_dir, ' --bvecs ', bvecs_dir, ' --bvals ', bvals_dir, ' -p horizontal -s ', T2_dir, ' --epi off --step 0 --will_be_drbuddied 1']);    
    
elseif (contains(pe1, 'AP') || contains(pe2, 'AP'))
    system(['DIFFPREP --dwi ', pe1_new_dir, ' --bvecs ', bvecs_dir, ' --bvals ', bvals_dir, ' -p vertical -s ', T2_dir, ' --epi off --step 0 --will_be_drbuddied 1']);
    system(['DIFFPREP --dwi ', pe2_new_dir, ' --bvecs ', bvecs_dir, ' --bvals ', bvals_dir, ' -p vertical -s ', T2_dir, ' --epi off --step 0 --will_be_drbuddied 1']);
        
end

system(['DR_BUDDI_withoutGUI --up_data ', pe1_list_dir, ' --down_data ', pe2_list_dir, ' --structural ', T2_dir, ' --output ', results_dir, pe1, pe2, '/dwi_', pe1, pe2, '_DRBUDDI_corrected.list --do_jacobian_regardless 1']);


%    Neurological to Radiological
system(['fslswapdim ', results_dir, pe1, pe2,'/', filename,'_',pe1, '_proc_DRBUDDI_up_final.nii x -y z ', pe1_corrected_dir]);
system(['fslorient -swaporient ', pe1_corrected_dir]);

system(['fslswapdim ', results_dir, pe1, pe2,'/', filename,'_',pe2, '_proc_DRBUDDI_down_final.nii x -y z ', pe2_corrected_dir]);
system(['fslorient -swaporient ', pe2_corrected_dir]);




end
















