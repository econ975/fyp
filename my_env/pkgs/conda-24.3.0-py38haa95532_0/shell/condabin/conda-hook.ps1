$Env:CONDA_EXE = "C:\b\abs_1e6dlkntna\croot\conda_1710772093015\_h_env\Scripts\conda.exe"
$Env:_CE_M = ""
$Env:_CE_CONDA = ""
$Env:_CONDA_ROOT = "C:\b\abs_1e6dlkntna\croot\conda_1710772093015\_h_env"
$Env:_CONDA_EXE = "C:\b\abs_1e6dlkntna\croot\conda_1710772093015\_h_env\Scripts\conda.exe"
$CondaModuleArgs = @{ChangePs1 = $True}
Import-Module "$Env:_CONDA_ROOT\shell\condabin\Conda.psm1" -ArgumentList $CondaModuleArgs

Remove-Variable CondaModuleArgs