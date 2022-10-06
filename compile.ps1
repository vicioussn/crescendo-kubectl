

Export-CrescendoModule -ConfigurationFile .\crescendo-kubectl.json -ModuleName CrescendoKubectl.psm1 -Force -Verbose




Import-Module .\CrescendoKubectl.psd1;
Get-Command -Module CrescendoKubectl;