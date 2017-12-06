﻿<#

.COPYRIGHT
Copyright (c) Office Center Hønefoss AS. All rights reserved. Based on code from Jan Egil Ring (Crayon). Licensed under the MIT license.
See https://github.com/officecenter/OCH-Public/blob/master/LICENSE for license information.

#>

Function Update-AtwsUserDefinedFieldListItem
{
  <#
      .SYNOPSIS
      This function updates a UserDefinedFieldListItem through the Autotask Web Services API.
      .DESCRIPTION
      This function updates a UserDefinedFieldListItem through the Autotask Web Services API.
      .INPUTS
      [Autotask.UserDefinedFieldListItem[]]. This function takes objects as input. Pipeline is supported.
      .OUTPUTS
      [Autototask.UserDefinedFieldListItem[]]. This function returns the updated Autotask.UserDefinedFieldListItem that was returned by the API.
      .EXAMPLE
      Update-AtwsUserDefinedFieldListItem  [-ParameterName] [Parameter value]
      For parameters, use Get-Help Update-AtwsUserDefinedFieldListItem
      .NOTES
      NAME: Update-AtwsUserDefinedFieldListItem
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
        [Autotask.UserDefinedFieldListItem]
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

    
    Set-AtwsData -Entity $InputObject }   

  End
  {
    Write-Verbose ('{0}: End of function' -F $MyInvocation.MyCommand.Name)

  }


        
}
