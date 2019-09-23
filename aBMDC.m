function aBMDC(pe1_dir, pe2_dir, init_correction_field_dir, results_dir)



[filename, pe1, pe2] = return_file_name_pe(pe1_dir, pe2_dir);
pe1_corrected_dir = [results_dir, filename,'_',pe1, '_aBMDC_corrected.nii.gz'];
pe2_corrected_dir = [results_dir, filename,'_',pe2, '_aBMDC_corrected.nii.gz'];

if (contains(pe1, 'LR') || contains(pe2, 'LR'))
    
    correction_field_dir = [results_dir, filename, '_LRRL_aBMDC_correction_field.nii.gz'];
    average_corrected_dir = [results_dir, filename, '_LRRL_aBMDC_corrected.nii.gz'];
    system(['animaBMDistortionCorrection -d 0 -f ', pe1_dir, ' -b ', pe2_dir, ' -i ', init_correction_field_dir, ' -o ', average_corrected_dir, ' -O ', correction_field_dir]);
%     system(['animaBMDistortionCorrection -d 0 -f ', pe1_dir, ' -b ', pe2_dir, ' -o ', average_corrected_dir, ' -O ', correction_field_dir]);
    
    
elseif (contains(pe1, 'AP') || contains(pe2, 'AP'))
    
    correction_field_dir = [results_dir, filename, '_APPA_aBMDC_correction_field.nii.gz'];
    average_corrected_dir = [results_dir, filename, '_APPA_aBMDC_corrected.nii.gz'];    
    system(['animaBMDistortionCorrection -d 1 -f ', pe1_dir, ' -b ', pe2_dir, ' -i ', init_correction_field_dir, ' -o ', average_corrected_dir, ' -O ', correction_field_dir]);
%     system(['animaBMDistortionCorrection -d 1 -f ', pe1_dir, ' -b ', pe2_dir, ' -o ', average_corrected_dir, ' -O ', correction_field_dir]);
    
end


system(['animaApplyDistortionCorrection -f ', pe1_dir, ' -t ', correction_field_dir, ' -o ', pe1_corrected_dir]);

system(['animaApplyDistortionCorrection -R -f ', pe2_dir, ' -t ', correction_field_dir, ' -o ', pe2_corrected_dir]);


end