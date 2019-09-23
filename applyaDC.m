function applyaDC(pe1_dir, pe2_dir, results_dir)



[filename, pe1, pe2] = return_file_name_pe(pe1_dir, pe2_dir);
pe1_corrected_dir = [results_dir, filename,'_',pe1, '_aDC_corrected.nii.gz'];
pe2_corrected_dir = [results_dir, filename,'_',pe2, '_aDC_corrected.nii.gz'];

if (contains(pe1, 'LR') || contains(pe2, 'LR'))
    
    correction_field_dir = [results_dir, 'b0_LRRL_aDC_correction_field.nii.gz'];
        
elseif (contains(pe1, 'AP') || contains(pe2, 'AP'))
    
    correction_field_dir = [results_dir, 'b0_APPA_aDC_correction_field.nii.gz'];
    
end

system(['animaApplyDistortionCorrection -f ', pe1_dir, ' -t ', correction_field_dir, ' -o ', pe1_corrected_dir]);
system(['animaApplyDistortionCorrection -R -f ', pe2_dir, ' -t ', correction_field_dir, ' -o ', pe2_corrected_dir]);


end














