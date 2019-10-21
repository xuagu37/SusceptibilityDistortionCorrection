function DRBUDDI(pe1_dir, pe2_dir, T2_dir, bvals_dir, bvecs_dir, results_dir)


[filename, pe1, pe2] = return_file_name_pe(pe1_dir, pe2_dir);
pe1_corrected_dir = [results_dir, filename,'_',pe1, '_DRBUDDI_corrected.nii.gz'];
pe2_corrected_dir = [results_dir, filename,'_',pe2, '_DRBUDDI_corrected.nii.gz'];
pe1_new_dir = [results_dir, filename,'_',pe1, '.nii.gz'];
pe2_new_dir = [results_dir, filename,'_',pe2, '.nii.gz'];

slash_index = strfind(bvals_dir, '/');
bvals_filename = bvals_dir(slash_index(end)+1:end);
bvals_new_dir = [results_dir, bvals_filename];
slash_index = strfind(bvecs_dir, '/');
bvecs_filename = bvecs_dir(slash_index(end)+1:end);
bvecs_new_dir = [results_dir, bvecs_filename];

% DIFFPREP changes radiological to neurological so we cp data to DRBUDDIfolder first
system(['cp ', pe1_dir, ' ', pe1_new_dir]);
system(['cp ', pe2_dir, ' ', pe2_new_dir]);
system(['cp ', bvals_dir, ' ', bvals_new_dir]);
system(['cp ', bvecs_dir, ' ', bvecs_new_dir]);

% Add a dummy volume
system(['fslroi ', pe1_new_dir, ' ', results_dir, 'temp.nii.gz 0 1']);
system(['fslmerge -t ', pe1_new_dir, ' ', pe1_new_dir, ' ', results_dir, 'temp.nii.gz']);
system(['rm ', results_dir, 'temp.nii.gz']);
bvals = load(bvals_new_dir);
bvals = [bvals, bvals(1)];
save(bvals_new_dir, 'bvals', '-ascii');
bvecs = load(bvecs_new_dir);
bvecs = [bvecs, bvecs(:,1)];
save(bvecs_new_dir, 'bvecs', '-ascii');

pe1_list_dir = [results_dir, filename,'_',pe1, '_proc.list'];
pe2_list_dir = [results_dir, filename,'_',pe2, '_proc.list'];

if (contains(pe1, 'LR') || contains(pe2, 'LR'))
    
    system(['DIFFPREP --dwi ', pe1_new_dir, ' --bvecs ', bvecs_new_dir, ' --bvals ', bvals_new_dir, ' -p horizontal -s ', T2_dir, ' --epi off ', ' --step 0 --will_be_drbuddied 1']);
    system(['DIFFPREP --dwi ', pe2_new_dir, ' --bvecs ', bvecs_dir, ' --bvals ', bvals_dir, ' -p horizontal -s ', T2_dir, ' --epi off ', ' --step 0 --will_be_drbuddied 1']);    
    
elseif (contains(pe1, 'AP') || contains(pe2, 'AP'))
    system(['DIFFPREP --dwi ', pe1_new_dir, ' --bvecs ', bvecs_new_dir, ' --bvals ', bvals_new_dir, ' -p vertical -s ', T2_dir, ' --epi off ', ' --step 0 --will_be_drbuddied 1']);
    system(['DIFFPREP --dwi ', pe2_new_dir, ' --bvecs ', bvecs_dir, ' --bvals ', bvals_dir, ' -p vertical -s ', T2_dir, ' --epi off ', ' --step 0 --will_be_drbuddied 1']);
        
end

system(['DR_BUDDI_withoutGUI --up_data ', pe1_list_dir, ' --down_data ', pe2_list_dir, ' --structural ', T2_dir, ' --output ', results_dir, pe1, pe2, '/dwi_', pe1, pe2, '_DRBUDDI_corrected.list']);


%    Neurological to Radiological
system(['fslswapdim ', results_dir, pe1, pe2,'/', filename,'_',pe1, '_proc_DRBUDDI_up_final.nii x -y z ', pe1_corrected_dir]);
system(['fslorient -swaporient ', pe1_corrected_dir]);

system(['fslswapdim ', results_dir, pe1, pe2,'/', filename,'_',pe2, '_proc_DRBUDDI_down_final.nii x -y z ', pe2_corrected_dir]);
system(['fslorient -swaporient ', pe2_corrected_dir]);


% Remove dummy volume
[~, nvols] = system(['fslnvols ', pe1_corrected_dir]);
system(['fslroi ', pe1_corrected_dir, ' ', pe1_corrected_dir, ' 0 ', num2str(str2num(nvols)-1)]);



end
















