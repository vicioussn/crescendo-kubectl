Get-ChildItem ".\helpers" -Filter "*.ps1" -Recurse | %{. $_.FullName};


[int]$patchVersion = Select-String -Path .\CrescendoKubectl.psd1 -Pattern "ModuleVersion = '0\.0\.(\d)'" | Select-Object @{name="version"; expression={$_.Matches.Groups[1].Value}} | select-object -ExpandProperty version;

Export-CrescendoModule -ConfigurationFile .\crescendo-kubectl.json -ModuleName CrescendoKubectl.psm1 -Force -Verbose;

$patchVersion++;
$versionString = "ModuleVersion = '0.0.$patchVersion'";
$a = Get-Content -Path .\CrescendoKubectl.psd1 | %{$_ -replace "ModuleVersion = '0\.0\.\d'", $versionString };
$a | Out-File .\CrescendoKubectl.psd1 -Verbose;


Remove-Module CrescendoKubectl -Force -Verbose -ErrorAction SilentlyContinue;
Import-Module .\CrescendoKubectl.psd1;
Get-Command -Module CrescendoKubectl;


$a = Get-UdkctlNamespace -Name dev
$a