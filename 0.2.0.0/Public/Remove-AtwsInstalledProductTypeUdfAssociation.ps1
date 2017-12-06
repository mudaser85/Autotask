﻿<#

.COPYRIGHT
Copyright (c) Office Center Hønefoss AS. All rights reserved. Based on code from Jan Egil Ring (Crayon). Licensed under the MIT license.
See https://github.com/officecenter/OCH-Public/blob/master/LICENSE for license information.

#>

Function Remove-AtwsInstalledProductTypeUdfAssociation
{
  <#
      .SYNOPSIS
      This function deletes a InstalledProductTypeUdfAssociation through the Autotask Web Services API.
      .DESCRIPTION
      This function deletes a InstalledProductTypeUdfAssociation through the Autotask Web Services API.
      .INPUTS
      [Autotask.InstalledProductTypeUdfAssociation[]]. This function takes objects as input. Pipeline is supported.
      .OUTPUTS
      Nothing. This fuction just deletes the Autotask.InstalledProductTypeUdfAssociation that was passed to the function.
      .EXAMPLE
      Remove-AtwsInstalledProductTypeUdfAssociation  [-ParameterName] [Parameter value]
      For parameters, use Get-Help Remove-AtwsInstalledProductTypeUdfAssociation
      .NOTES
      NAME: Remove-AtwsInstalledProductTypeUdfAssociation
  #>
	  [CmdLetBinding(DefaultParameterSetName='Input_Object')]
    Param
    (
                [Parameter(
          Mandatory = $True,
          ParameterSetName = 'Input_Object',
          ValueFromPipeline = $True
        )]
        [ValidateNotNullOrEmpty()]
        [Autotask.InstalledProductTypeUdfAssociation]
        $InputObject
    )



          

  Begin
  { 
    If (-not($global:atws.Url))
    {
      Throw [ApplicationException] 'Not connected to Autotask WebAPI. Run Connect-AutotaskWebAPI first.'
    }
    Write-Verbose ('{0}: Begin of function' -F $MyInvocation.MyCommand.Name)

  }   

  Process
  {   
  
    Remove-AtwsData -Entity $InputObject
 }   

  End
  {
    Write-Verbose ('{0}: End of function' -F $MyInvocation.MyCommand.Name)

  }


        
}
