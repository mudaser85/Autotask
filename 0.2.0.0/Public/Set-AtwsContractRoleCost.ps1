﻿<#

.COPYRIGHT
Copyright (c) Office Center Hønefoss AS. All rights reserved. Based on code from Jan Egil Ring (Crayon). Licensed under the MIT license.
See https://github.com/officecenter/OCH-Public/blob/master/LICENSE for license information.

#>

Function Set-AtwsContractRoleCost
{
  <#
      .SYNOPSIS
      This function sets parameters on the ContractRoleCost specified by the -id parameter through the Autotask Web Services API.
      .DESCRIPTION
      This function sets parameters on the ContractRoleCost specified by the -id parameter through the Autotask Web Services API.
      .INPUTS
      Nothing. This function only takes parameters.
      .OUTPUTS
      [Autototask.ContractRoleCost]. This function returns the updated Autotask.ContractRoleCost that was returned by the API.
      .EXAMPLE
      Set-AtwsContractRoleCost  [-ParameterName] [Parameter value]
      For parameters, use Get-Help Set-AtwsContractRoleCost
      .NOTES
      NAME: Set-AtwsContractRoleCost
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

    $InputObject =  Get-AtwsData -Entity ContractRoleCost -Filter {id -eq $Id}

    Foreach ($Parameter in $PSBoundParameters.GetEnumerator())
    {
        $InputObject.$($Parameter.Key) = $Parameter.Value
    }
        
    
    Set-AtwsData -Entity $InputObject }   

  End
  {
    Write-Verbose ('{0}: End of function' -F $MyInvocation.MyCommand.Name)

  }


        
}
