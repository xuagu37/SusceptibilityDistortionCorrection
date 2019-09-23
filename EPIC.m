function EPIC(pe1_dir, pe2_dir, results_dir)

PATH = getenv('PATH');
setenv('PATH', [PATH ':/home/xuagu37/freesurfer/bin']);
setenv('FREESURFER_HOME','/home/xuagu37/freesurfer');
setenv('PATH', [PATH ':/home/xuagu37/epi_corrections/epic_src/bin']);
setenv('EPIC_HOME','/home/xuagu37/epi_corrections/epic_src');
setenv LD_LIBRARY_PATH LD_LIBRARY_PATH:/home/xuagu37/epi_corrections/epic_src/ctxsrc/Interpolation:/home/xuagu37/epi_corrections/epic_src/ctxsrc/BasicStructs:/home/xuagu37/intel/itac/2019.4.036/intel64/slib:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/compiler/lib/intel64_lin:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/mpi/intel64/libfabric/lib:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/mpi/intel64/lib/release:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/mpi/intel64/lib:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/ipp/lib/intel64:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/compiler/lib/intel64_lin:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/mkl/lib/intel64_lin:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/tbb/lib/intel64/gcc4.7:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/tbb/lib/intel64/gcc4.7:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/daal/lib/intel64_lin:/home/xuagu37/intel/itac/2019.4.036/intel64/slib:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/compiler/lib/intel64_lin:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/mpi/intel64/libfabric/lib:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/mpi/intel64/lib/release:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/mpi/intel64/lib:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/ipp/lib/intel64:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/compiler/lib/intel64_lin:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/mkl/lib/intel64_lin:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/tbb/lib/intel64/gcc4.7:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/tbb/lib/intel64/gcc4.7:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/daal/lib/intel64_lin:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/compiler/lib/intel64_lin:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/mpi/intel64/libfabric/lib:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/mpi/intel64/lib/release:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/mpi/intel64/lib:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/ipp/lib/intel64:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/compiler/lib/intel64_lin:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/mkl/lib/intel64_lin:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/tbb/lib/intel64/gcc4.7:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/tbb/lib/intel64/gcc4.7:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/daal/lib/intel64_lin:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/compiler/lib/intel64_lin:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/mkl/lib/intel64_lin:/home/xuagu37/intel/itac/2019.4.036/intel64/slib:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/compiler/lib/intel64_lin:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/mpi/intel64/libfabric/lib:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/mpi/intel64/lib/release:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/mpi/intel64/lib:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/ipp/lib/intel64:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/compiler/lib/intel64_lin:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/mkl/lib/intel64_lin:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/tbb/lib/intel64/gcc4.7:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/tbb/lib/intel64/gcc4.7:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/daal/lib/intel64_lin:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/compiler/lib/intel64_lin:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/mpi/intel64/libfabric/lib:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/mpi/intel64/lib/release:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/mpi/intel64/lib:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/ipp/lib/intel64:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/compiler/lib/intel64_lin:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/mkl/lib/intel64_lin:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/tbb/lib/intel64/gcc4.7:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/tbb/lib/intel64/gcc4.7:/home/xuagu37/intel/debugger_2019/libipt/intel64/lib:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/daal/lib/intel64_lin:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/daal/../tbb/lib/intel64_lin/gcc4.4:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/tbb/lib/intel64_lin/gcc4.7:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/compiler/lib/intel64_lin:/home/xuagu37/intel/compilers_and_libraries_2019.4.243/linux/mkl/lib/intel64_lin::/usr/local/cuda-9.0/lib64/:/usr/local/lib:/usr/lib:/usr/local/lib64:/usr/lib64:/home/xuagu37/dtb/gurobi751/linux64/lib:/usr/local/cuda-9.0/lib64/:/usr/local/lib:/usr/lib:/usr/local/lib64:/usr/lib64:/home/xuagu37/dtb/gurobi751/linux64/lib


[filename, pe1, pe2] = return_file_name_pe(pe1_dir, pe2_dir);
pe1_corrected_dir = [results_dir, filename,'_',pe1, '_EPIC_corrected.nii.gz'];
pe2_corrected_dir = [results_dir, filename,'_',pe2, '_EPIC_corrected.nii.gz'];


pe1_mgz_dir = [results_dir, filename,'_',pe1, '.mgz'];
pe2_mgz_dir = [results_dir, filename,'_',pe2, '.mgz'];

if (contains(pe1, 'LR') || contains(pe2, 'LR'))
    save_results_dir = [results_dir, 'LRRL/'];
    system(['mkdir -p ', save_results_dir]);
    pe1_rotated_dir = [results_dir, filename,'_',pe1, '_rotated.nii.gz'];
    pe2_rotated_dir = [results_dir, filename,'_',pe2, '_rotated.nii.gz'];
    system(['fslswapdim ', pe1_dir, ' y x z ', pe1_rotated_dir]);
    system(['fslswapdim ', pe2_dir, ' y x z ', pe2_rotated_dir]);
    system(['mri_convert ', pe1_rotated_dir, ' ', pe1_mgz_dir]);
    system(['mri_convert ', pe2_rotated_dir, ' ', pe2_mgz_dir]);
elseif (contains(pe1, 'AP') || contains(pe2, 'AP'))
    save_results_dir = [results_dir, 'APPA/'];
    system(['mkdir -p ', save_results_dir]);
    system(['mri_convert ', pe1_dir, ' ', pe1_mgz_dir]);
    system(['mri_convert ', pe2_dir, ' ', pe2_mgz_dir]);
end


system(['epic -f ', pe1_mgz_dir, ' -r ', pe2_mgz_dir, ' -od ', save_results_dir]);

system(['mri_convert ', save_results_dir, 'fB0uw.mgz ', pe1_corrected_dir]);
system(['mri_convert ', save_results_dir, 'rB0uw.mgz ', pe2_corrected_dir]);


% Rescale EPIC results

[~, val1max] = system(['fslstats ', pe1_dir, '  -R']);
val1max = str2num(val1max);
val1max = val1max(2);
[~, val2max] = system(['fslstats ', pe2_dir, '  -R']);
val2max = str2num(val2max);
val2max = val2max(2);

iscale = 3400/(max(val1max, val2max));
system(['fslmaths ', pe1_corrected_dir, ' -div ', num2str(iscale), ' ', pe1_corrected_dir]);
system(['fslmaths ', pe2_corrected_dir, ' -div ', num2str(iscale), ' ', pe2_corrected_dir]);

if (contains(pe1, 'LR') || contains(pe2, 'LR'))
    
    system(['fslswapdim ', pe1_corrected_dir, ' y x z ', pe1_corrected_dir]);
    system(['fslswapdim ', pe2_corrected_dir, ' y x z ', pe2_corrected_dir]);
    
end

system(['fslcpgeom ', pe1_dir, ' ', pe1_corrected_dir]);
system(['fslcpgeom ', pe2_dir, ' ', pe2_corrected_dir]);

end