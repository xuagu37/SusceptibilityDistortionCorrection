function TOPUP(pe1_dir, pe2_dir, acqparams_dir, results_dir)


[filename, pe1, pe2] = return_file_name_pe(pe1_dir, pe2_dir);
pe1_corrected_dir = [results_dir, filename,'_',pe1, '_TOPUP_corrected.nii.gz'];
pe2_corrected_dir = [results_dir, filename,'_',pe2, '_TOPUP_corrected.nii.gz'];

if (contains(pe1, 'LR') || contains(pe2, 'LR'))
    
    pe1pe2_corrected_dir = [results_dir, filename, '_LRRL_TOPUP_corrected.nii.gz'];
    pe1pe2_dir = [results_dir, filename, '_LRRL.nii.gz'];
    topup_out_dir = [results_dir, filename, '_LRRL_TOPUP'];
    fieldmap_hz_dir = [results_dir, filename, '_LRRL_TOPUP_fieldmap_hz.nii.gz'];
    
elseif (contains(pe1, 'AP') || contains(pe2, 'AP'))
    
    pe1pe2_corrected_dir = [results_dir, filename, '_APPA_TOPUP_corrected.nii.gz'];
    pe1pe2_dir = [results_dir, filename, '_APPA.nii.gz'];
    topup_out_dir = [results_dir, filename, '_APPA_TOPUP'];
    fieldmap_hz_dir = [results_dir, filename, '_APPA_TOPUP_fieldmap_hz.nii.gz'];
end



system(['fslmerge -t ', pe1pe2_dir, ' ', pe1_dir, ' ', pe2_dir]);

% Stupid TOPUP only works for even size
[~, dim1] = system(['fslval ', pe1pe2_dir, ' dim1']);
dim1 = str2num(dim1);
[~, dim2] = system(['fslval ', pe1pe2_dir, ' dim2']);
dim2 = str2num(dim2);
[~, dim3] = system(['fslval ', pe1pe2_dir, ' dim3']);
dim3 = str2num(dim3);

margin1_dir = [results_dir, 'margin1.nii.gz'];
margin2_dir = [results_dir, 'margin2.nii.gz'];
margin3_dir = [results_dir, 'margin3.nii.gz'];
flag1 = 0;
flag2 = 0;
flag3 = 0;
if (mod(dim1,2) == 1)
    flag1 = 1;
    system(['fslroi ', pe1pe2_dir, ' ', margin1_dir, ' ', num2str(dim1-1) ' 1 0 ', num2str(dim2), ' 0 ', num2str(dim3)]);
    system(['fslroi ', pe1pe2_dir, ' ', pe1pe2_dir, ' 0 ', num2str(dim1-1) ' 0 ', num2str(dim2), ' 0 ', num2str(dim3)]);
    dim1 = dim1 - 1;
end
if (mod(dim2,2) == 1)
    flag2 = 1;
    system(['fslroi ', pe1pe2_dir, ' ', margin2_dir, ' 0 ', num2str(dim1), ' ', num2str(dim2-1), ' 1 0 ', num2str(dim3)]);
    system(['fslroi ', pe1pe2_dir, ' ', pe1pe2_dir, ' 0 ', num2str(dim1) ' 0 ', num2str(dim2-1), ' 0 ', num2str(dim3)]);
    dim2 = dim2 - 1;
end
if (mod(dim3,2) == 1)
    flag3 = 1;
    system(['fslroi ', pe1pe2_dir, ' ', margin3_dir, ' 0 ', num2str(dim1), ' 0 ', num2str(dim2), ' ', num2str(dim3-1), ' 1']);
    system(['fslroi ', pe1pe2_dir, ' ', pe1pe2_dir, ' 0 ', num2str(dim1) ' 0 ', num2str(dim2), ' 0 ', num2str(dim3-1)]);
end

system(['topup --imain=', pe1pe2_dir, ' --datain=', acqparams_dir, ' --config=b02b0.cnf --out=', topup_out_dir, ' --fout=', fieldmap_hz_dir, ' --iout=', pe1pe2_corrected_dir, ' --verbose']);

if (flag3)
    system(['fslmerge -z ', pe1pe2_corrected_dir, ' ', pe1pe2_corrected_dir, ' ', margin3_dir]);
end
if (flag2)
    system(['fslmerge -y ', pe1pe2_corrected_dir, ' ', pe1pe2_corrected_dir, ' ', margin2_dir]);
end
if (flag1)
    system(['fslmerge -x ', pe1pe2_corrected_dir, ' ', pe1pe2_corrected_dir, ' ', margin1_dir]);
end


system(['fslroi ', pe1pe2_corrected_dir, ' ', pe1_corrected_dir, ' 0 1']);
system(['fslroi ', pe1pe2_corrected_dir, ' ', pe2_corrected_dir, ' 1 1']);



end