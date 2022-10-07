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