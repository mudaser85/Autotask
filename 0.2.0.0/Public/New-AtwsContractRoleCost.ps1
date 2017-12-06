﻿<#

.COPYRIGHT
Copyright (c) Office Center Hønefoss AS. All rights reserved. Based on code from Jan Egil Ring (Crayon). Licensed under the MIT license.
See https://github.com/officecenter/OCH-Public/blob/master/LICENSE for license information.

#>

Function New-AtwsContractRoleCost
{
  <#
      .SYNOPSIS
      This function creates a new ContractRoleCost through the Autotask Web Services API.
      .DESCRIPTION
      This function creates a new ContractRoleCost through the Autotask Web Services API.
      .INPUTS
      Nothing. This function only takes parameters.
      .OUTPUTS
      [Autotask.ContractRoleCost]. This function outputs the Autotask.ContractRoleCost that was created by the API.
      .EXAMPLE
      New-AtwsContractRoleCost  [-ParameterName] [Parameter value]
      For parameters, use Get-Help New-AtwsContractRoleCost
      .NOTES
      NAME: New-AtwsContractRoleCost
  #>
	  [CmdLetBinding(DefaultParameterSetName='By_parameters')]
    Param
    (
                [Parameter(
          Mandatory = $true,
          ValueFromRemainingArguments = $true,
          ParameterSetName = 'By_parameters')]
        [ValidateNotNullOrEmpty()]
        [Int]
        $Id ,

        [Parameter(
          Mandatory = $True,
          ParameterSetName = 'By_parameters'
        )]
         [ValidateNotNullOrEmpty()]
         [double]
         $Rate

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

    $InputObject = New-Object Autotask.ContractRoleCost

    Foreach ($Parameter in $PSBoundParameters.GetEnumerator())
    {
        $InputObject.$($Parameter.Key) = $Parameter.Value
    }

    New-AtwsData -Entity $InputObject
 }   

  End
  {
    Write-Verbose ('{0}: End of function' -F $MyInvocation.MyCommand.Name)

  }


        
}
