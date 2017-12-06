﻿<#

.COPYRIGHT
Copyright (c) Office Center Hønefoss AS. All rights reserved. Based on code from Jan Egil Ring (Crayon). Licensed under the MIT license.
See https://github.com/officecenter/OCH-Public/blob/master/LICENSE for license information.

#>

Function Set-AtwsPriceListWorkTypeModifier
{
  <#
      .SYNOPSIS
      This function sets parameters on the PriceListWorkTypeModifier specified by the -id parameter through the Autotask Web Services API.
      .DESCRIPTION
      This function sets parameters on the PriceListWorkTypeModifier specified by the -id parameter through the Autotask Web Services API.
      .INPUTS
      Nothing. This function only takes parameters.
      .OUTPUTS
      [Autototask.PriceListWorkTypeModifier]. This function returns the updated Autotask.PriceListWorkTypeModifier that was returned by the API.
      .EXAMPLE
      Set-AtwsPriceListWorkTypeModifier  [-ParameterName] [Parameter value]
      For parameters, use Get-Help Set-AtwsPriceListWorkTypeModifier
      .NOTES
      NAME: Set-AtwsPriceListWorkTypeModifier
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
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [ValidateSet('UseRoleRate','UseRoleRateAdjustedBy','UseRoleRateMultipliedBy','UseCustomRate','UseFlatRate')]

        [String]
         $ModifierType
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [decimal]
         $ModifierValue
 ,

        [Parameter(
          Mandatory = $True,
          ParameterSetName = 'By_parameters'
        )]
         [ValidateNotNullOrEmpty()]
         [boolean]
         $UsesInternalCurrencyPrice

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

    $InputObject =  Get-AtwsData -Entity PriceListWorkTypeModifier -Filter {id -eq $Id}

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
