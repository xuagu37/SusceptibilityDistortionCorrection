clear
close all



%% Files Dir
% Set dir for test data
test_data_dir = '/home/xuagu37/data/';
b0_GT_dir = [test_data_dir, 'b0_GT.nii.gz'];
b0_LR_dir = [test_data_dir, 'b0_LR.nii.gz'];
b0_RL_dir = [test_data_dir, 'b0_RL.nii.gz'];
b0_AP_dir = [test_data_dir, 'b0_AP.nii.gz'];
b0_PA_dir = [test_data_dir, 'b0_PA.nii.gz'];
dwi_GT_dir = [test_data_dir, 'dwi_GT.nii.gz'];
dwi_LR_dir = [test_data_dir, 'dwi_LR.nii.gz'];
dwi_RL_dir = [test_data_dir, 'dwi_RL.nii.gz'];
dwi_AP_dir = [test_data_dir, 'dwi_AP.nii.gz'];
dwi_PA_dir = [test_data_dir, 'dwi_PA.nii.gz'];
bvals_dir = [test_data_dir, 'bvalsnew'];
bvecs_dir = [test_data_dir, 'bvecsnew'];

%% Create folders
system(['mkdir -p ', test_data_dir, 'aDC']);
system(['mkdir -p ', test_data_dir, 'aBMDC']);
system(['mkdir -p ', test_data_dir, 'DRBUDDI']);
system(['mkdir -p ', test_data_dir, 'EPIC']);
system(['mkdir -p ', test_data_dir, 'HySCO']);
system(['mkdir -p ', test_data_dir, 'TOPUP']);

%% aDC

aDC_results_dir = [test_data_dir, 'aDC/'];

aDC(b0_LR_dir, b0_RL_dir, aDC_results_dir);
aDC(b0_AP_dir, b0_PA_dir, aDC_results_dir);

applyaDC(dwi_LR_dir, dwi_RL_dir, aDC_results_dir);
applyaDC(dwi_AP_dir, dwi_PA_dir, aDC_results_dir);

%% aBMDC

aBMDC_results_dir = [test_data_dir, 'aBMDC/'];

init_correction_field_LRRL_dir = [aDC_results_dir, 'b0_LRRL_aDC_correction_field.nii.gz'];
init_correction_field_APPA_dir = [aDC_results_dir, 'b0_APPA_aDC_correction_field.nii.gz'];
aBMDC(b0_LR_dir, b0_RL_dir, init_correction_field_LRRL_dir, aBMDC_results_dir);
aBMDC(b0_AP_dir, b0_PA_dir, init_correction_field_APPA_dir, aBMDC_results_dir);

applyaBMDC(dwi_LR_dir, dwi_RL_dir, aBMDC_results_dir);
applyaBMDC(dwi_AP_dir, dwi_PA_dir, aBMDC_results_dir);



%% DR-BUDDI

DRBUDDI_results_dir = [current_dir, 'DRBUDDI/'];   

DRBUDDI(dwi_LR_dir, dwi_RL_dir, '', bvals_dir, bvecs_dir, bvals_dir, bvecs_dir,1, DRBUDDI_results_dir);
DRBUDDI(dwi_AP_dir, dwi_PA_dir, '', bvals_dir, bvecs_dir, bvals_dir, bvecs_dir,1, DRBUDDI_results_dir);



%% EPIC

EPIC_results_dir = [test_data_dir, 'EPIC/'];

EPIC(b0_LR_dir, b0_RL_dir, EPIC_results_dir);
EPIC(b0_AP_dir, b0_PA_dir, EPIC_results_dir);

correction_field_LRRL_dir = [EPIC_results_dir, 'LRRL/d.mgz'];
correction_field_APPA_dir = [EPIC_results_dir, 'APPA/d.mgz'];

applyEPIC(dwi_LR_dir, dwi_RL_dir, correction_field_LRRL_dir, EPIC_results_dir);
applyEPIC(dwi_AP_dir, dwi_PA_dir, correction_field_APPA_dir, EPIC_results_dir);


%% HySCO

HySCO_results_dir = [test_data_dir, 'HySCO/'];

HySCO(b0_LR_dir, b0_RL_dir, HySCO_results_dir);
HySCO(b0_AP_dir, b0_PA_dir, HySCO_results_dir);

applyHySCO(b0_LR_dir, b0_RL_dir, dwi_LR_dir, dwi_RL_dir, HySCO_results_dir);
applyHySCO(b0_AP_dir, b0_PA_dir, dwi_AP_dir, dwi_PA_dir, HySCO_results_dir);



%% TOPUP

TOPUP_results_dir = [test_data_dir, 'TOPUP/'];

acqparams = [0, 1, 0, 0.05782; 0, -1, 0, 0.05782];
acqparams_APPA_dir = [TOPUP_results_dir, 'acqparams_APPA.txt'];
save(acqparams_APPA_dir, 'acqparams', '-ascii');
acqparams = [1, 0, 0, 0.06922; -1, 0, 0, 0.06922];
acqparams_LRRL_dir = [TOPUP_results_dir, 'acqparams_LRRL.txt'];
save(acqparams_LRRL_dir, 'acqparams', '-ascii');

TOPUP(b0_LR_dir, b0_RL_dir, acqparams_LRRL_dir, TOPUP_results_dir);
TOPUP(b0_AP_dir, b0_PA_dir, acqparams_APPA_dir, TOPUP_results_dir);

topup_LRRL_dir = [TOPUP_results_dir, 'b0_LRRL_TOPUP'];
topup_APPA_dir = [TOPUP_results_dir, 'b0_APPA_TOPUP'];

applyTOPUP(dwi_LR_dir, dwi_RL_dir, acqparams_LRRL_dir, topup_LRRL_dir, TOPUP_results_dir)
applyTOPUP(dwi_AP_dir, dwi_PA_dir, acqparams_APPA_dir, topup_APPA_dir, TOPUP_results_dir)



















