# Module created by Microsoft.PowerShell.Crescendo
class PowerShellCustomFunctionAttribute : System.Attribute { 
    [bool]$RequiresElevation
    [string]$Source
    PowerShellCustomFunctionAttribute() { $this.RequiresElevation = $false; $this.Source = "Microsoft.PowerShell.Crescendo" }
    PowerShellCustomFunctionAttribute([bool]$rElevation) {
        $this.RequiresElevation = $rElevation
        $this.Source = "Microsoft.PowerShell.Crescendo"
    }
}

function Get-UdkctlParsedResponse {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Mandatory, ValueFromPipeline)]
        $response
    );
    

    $responseObject = $response | ConvertFrom-Json;

    if ($responseObject.items)
    {
        return $responseObject.items;
    }
    else
    {
        return $responseObject;
    }
}


function Get-UdkctlNamespace
{
[PowerShellCustomFunctionAttribute(RequiresElevation=$False)]
[CmdletBinding()]

param(
[Parameter(ParameterSetName='ByName')]
[string[]]$Name
    )

BEGIN {
    $__PARAMETERMAP = @{
         Name = @{
               OriginalName = ''
               OriginalPosition = '0'
               Position = '2147483647'
               ParameterType = 'string[]'
               ApplyToExecutable = $False
               NoGap = $False
               }
    }

    $__outputHandlers = @{
        Default = @{ StreamOutput = $True; Handler = 'Get-UdkctlParsedResponse' }
    }
}

PROCESS {
    $__boundParameters = $PSBoundParameters
    $__defaultValueParameters = $PSCmdlet.MyInvocation.MyCommand.Parameters.Values.Where({$_.Attributes.Where({$_.TypeId.Name -eq "PSDefaultValueAttribute"})}).Name
    $__defaultValueParameters.Where({ !$__boundParameters["$_"] }).ForEach({$__boundParameters["$_"] = get-variable -value $_})
    $__commandArgs = @()
    $MyInvocation.MyCommand.Parameters.Values.Where({$_.SwitchParameter -and $_.Name -notmatch "Debug|Whatif|Confirm|Verbose" -and ! $__boundParameters[$_.Name]}).ForEach({$__boundParameters[$_.Name] = [switch]::new($false)})
    if ($__boundParameters["Debug"]){wait-debugger}
    $__commandArgs += 'get'
    $__commandArgs += '-ojson'
    $__commandArgs += 'namespace'
    foreach ($paramName in $__boundParameters.Keys|
            Where-Object {!$__PARAMETERMAP[$_].ApplyToExecutable}|
            Sort-Object {$__PARAMETERMAP[$_].OriginalPosition}) {
        $value = $__boundParameters[$paramName]
        $param = $__PARAMETERMAP[$paramName]
        if ($param) {
            if ($value -is [switch]) {
                 if ($value.IsPresent) {
                     if ($param.OriginalName) { $__commandArgs += $param.OriginalName }
                 }
                 elseif ($param.DefaultMissingValue) { $__commandArgs += $param.DefaultMissingValue }
            }
            elseif ( $param.NoGap ) {
                $pFmt = "{0}{1}"
                if($value -match "\s") { $pFmt = "{0}""{1}""" }
                $__commandArgs += $pFmt -f $param.OriginalName, $value
            }
            else {
                if($param.OriginalName) { $__commandArgs += $param.OriginalName }
                $__commandArgs += $value | Foreach-Object {$_}
            }
        }
    }
    $__commandArgs = $__commandArgs | Where-Object {$_ -ne $null}
    if ($__boundParameters["Debug"]){wait-debugger}
    if ( $__boundParameters["Verbose"]) {
         Write-Verbose -Verbose -Message .\binary\kubectl\kubectl.exe
         $__commandArgs | Write-Verbose -Verbose
    }
    $__handlerInfo = $__outputHandlers[$PSCmdlet.ParameterSetName]
    if (! $__handlerInfo ) {
        $__handlerInfo = $__outputHandlers["Default"] # Guaranteed to be present
    }
    $__handler = $__handlerInfo.Handler
    if ( $PSCmdlet.ShouldProcess(".\binary\kubectl\kubectl.exe $__commandArgs")) {
    # check for the application and throw if it cannot be found
        if ( -not (Get-Command -ErrorAction Ignore ".\binary\kubectl\kubectl.exe")) {
          throw "Cannot find executable '.\binary\kubectl\kubectl.exe'"
        }
        if ( $__handlerInfo.StreamOutput ) {
            & ".\binary\kubectl\kubectl.exe" $__commandArgs | & $__handler
        }
        else {
            $result = & ".\binary\kubectl\kubectl.exe" $__commandArgs
            & $__handler $result
        }
    }
  } # end PROCESS

<#


.DESCRIPTION
Gets namespaces from current Kubernetes cluster.

.PARAMETER Name
Namespace name.



#>
}


