function aDC(pe1_dir, pe2_dir, results_dir)


[filename, pe1, pe2] = return_file_name_pe(pe1_dir, pe2_dir);
pe1_corrected_dir = [results_dir, filename,'_',pe1, '_aDC_corrected.nii.gz'];
pe2_corrected_dir = [results_dir, filename,'_',pe2, '_aDC_corrected.nii.gz'];

if (contains(pe1, 'LR') || contains(pe2, 'LR'))
    
    correction_field_dir = [results_dir, filename, '_LRRL_aDC_correction_field.nii.gz'];
    system(['animaDistortionCorrection -d 0 -s 2 -f ', pe1_dir, ' -b ', pe2_dir, ' -o ', correction_field_dir]);
    
    
elseif (contains(pe1, 'AP') || contains(pe2, 'AP'))
    
    correction_field_dir = [results_dir, filename, '_APPA_aDC_correction_field.nii.gz'];
    system(['animaDistortionCorrection -d 1 -s 2 -f ', pe1_dir, ' -b ', pe2_dir, ' -o ', correction_field_dir]);
    
end

system(['animaApplyDistortionCorrection -f ', pe1_dir, ' -t ', correction_field_dir, ' -o ', pe1_corrected_dir]);
system(['animaApplyDistortionCorrection -R -f ', pe2_dir, ' -t ', correction_field_dir, ' -o ', pe2_corrected_dir]);


end














