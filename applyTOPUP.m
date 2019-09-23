function applyTOPUP(pe1_dir, pe2_dir, acqparams_dir, topup_out_dir, results_dir)


[filename, pe1, pe2] = return_file_name_pe(pe1_dir, pe2_dir);
pe1_corrected_dir = [results_dir, filename,'_',pe1, '_TOPUP_corrected.nii.gz'];
pe2_corrected_dir = [results_dir, filename,'_',pe2, '_TOPUP_corrected.nii.gz'];

% system(['applytopup --imain=', pe1_dir,',',pe2_dir, ' --inindex=1,2', ' --datain=', acqparams_dir, ' --topup=', topup_out_dir, ' --out=', average_corrected_dir]);
system(['applytopup --imain=', pe1_dir, ' --inindex=1', ' --datain=', acqparams_dir, ' --method=jac ', ' --topup=', topup_out_dir, ' --out=', pe1_corrected_dir]);
system(['applytopup --imain=', pe2_dir, ' --inindex=2', ' --datain=', acqparams_dir, ' --method=jac ', ' --topup=', topup_out_dir, ' --out=', pe2_corrected_dir]);




end