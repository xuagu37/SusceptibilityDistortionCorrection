function DRBUDDI(pe1_dir, pe2_dir, T2_dir, bvals1_dir, bvecs1_dir, bvals2_dir, bvecs2_dir, simple_mode,results_dir)
% simple_mode: without corrections from DIFFPREP and without a structral image

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

if (contains(pe1, 'LR') || contains(pe2, 'LR'))
    
    system(['ImportNIFTI --input_NIFTI ', pe1_new_dir, ' --bvecs ', bvecs1_dir, ' --bvals ', bvals1_dir, ' -p horizontal']);
    system(['ImportNIFTI --input_NIFTI ', pe2_new_dir, ' --bvecs ', bvecs2_dir, ' --bvals ', bvals2_dir, ' -p horizontal']);
    
elseif (contains(pe1, 'AP') || contains(pe2, 'AP'))
    system(['ImportNIFTI --input_NIFTI ', pe1_new_dir, ' --bvecs ', bvecs1_dir, ' --bvals ', bvals1_dir, ' -p vertical']);
    system(['ImportNIFTI --input_NIFTI ', pe2_new_dir, ' --bvecs ', bvecs2_dir, ' --bvals ', bvals2_dir, ' -p vertical']);
    
end

pe1_list_dir = [results_dir,filename,'_',pe1, '_proc/', filename,'_',pe1, '.list'];
pe2_list_dir = [results_dir,filename,'_',pe2, '_proc/', filename,'_',pe2, '.list'];
pe1_proc_list_dir = [results_dir,filename,'_',pe1, '_proc/', filename,'_',pe1, '_proc.list'];
pe2_proc_list_dir = [results_dir,filename,'_',pe2, '_proc/', filename,'_',pe2, '_proc.list'];


if simple_mode
    
else
    
    if (contains(pe1, 'LR') || contains(pe2, 'LR'))
        
        system(['DIFFPREP --input_list ', pe1_list_dir, ' --bvecs ', bvecs1_dir, ' --bvals ', bvals1_dir, ' -p horizontal -s ', T2_dir, ' --epi off --step 0 --will_be_drbuddied 1']);
        system(['DIFFPREP --input_list ', pe2_list_dir, ' --bvecs ', bvecs2_dir, ' --bvals ', bvals2_dir, ' -p horizontal -s ', T2_dir, ' --epi off --step 0 --will_be_drbuddied 1']);
        
    elseif (contains(pe1, 'AP') || contains(pe2, 'AP'))
        system(['DIFFPREP --input_list ', pe1_list_dir, ' --bvecs ', bvecs1_dir, ' --bvals ', bvals1_dir, ' -p vertical -s ', T2_dir, ' --epi off --step 0 --will_be_drbuddied 1']);
        system(['DIFFPREP --input_list ', pe2_list_dir, ' --bvecs ', bvecs2_dir, ' --bvals ', bvals2_dir, ' -p vertical -s ', T2_dir, ' --epi off --step 0 --will_be_drbuddied 1']);
        
    end
    
end

if simple_mode
    system(['DR_BUDDI_withoutGUI --up_data ', pe1_list_dir, ' --down_data ', pe2_list_dir, ' --do_jacobian_regardless 1 --disable_initial_rigid 1']);
else
    system(['DR_BUDDI_withoutGUI --up_data ', pe1_proc_list_dir, ' --down_data ', pe2_proc_list_dir, ' --structural ', T2_dir, ' --do_jacobian_regardless 1']);
end

%    Neurological to Radiological
if simple_mode
    system(['fslswapdim ', results_dir, filename,'_', pe1,'_DRBUDDI_proc/', filename,'_',pe1, '_DRBUDDI_up_final.nii x -y z ', pe1_corrected_dir]);
    system(['fslswapdim ', results_dir, filename,'_', pe1,'_DRBUDDI_proc/', filename,'_',pe2, '_DRBUDDI_down_final.nii x -y z ', pe2_corrected_dir]);
else
    system(['fslswapdim ', results_dir, filename,'_', pe1,'_DRBUDDI_proc/', filename,'_',pe1, '_proc_DRBUDDI_up_final.nii x -y z ', pe1_corrected_dir]);
    system(['fslswapdim ', results_dir, filename,'_', pe1,'_DRBUDDI_proc/', filename,'_',pe2, '_proc_DRBUDDI_down_final.nii x -y z ', pe2_corrected_dir]);
end

system(['fslorient -swaporient ', pe1_corrected_dir]);
system(['fslorient -swaporient ', pe2_corrected_dir]);




end
















