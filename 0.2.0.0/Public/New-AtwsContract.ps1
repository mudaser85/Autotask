﻿<#

.COPYRIGHT
Copyright (c) Office Center Hønefoss AS. All rights reserved. Based on code from Jan Egil Ring (Crayon). Licensed under the MIT license.
See https://github.com/officecenter/OCH-Public/blob/master/LICENSE for license information.

#>

Function New-AtwsContract
{
  <#
      .SYNOPSIS
      This function creates a new Contract through the Autotask Web Services API.
      .DESCRIPTION
      This function creates a new Contract through the Autotask Web Services API.
      .INPUTS
      Nothing. This function only takes parameters.
      .OUTPUTS
      [Autotask.Contract]. This function outputs the Autotask.Contract that was created by the API.
      .EXAMPLE
      New-AtwsContract  [-ParameterName] [Parameter value]
      For parameters, use Get-Help New-AtwsContract
      .NOTES
      NAME: New-AtwsContract
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
         [ValidateSet('Immediately without review','Manually','On timesheet approval')]

        [String]
         $BillingPreference
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [boolean]
         $Compliance
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [string]
         $ContactName
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [ValidateSet('Løpende fakturering','Månedlig fakturering','Prosjekt','Skal ikke fornyes','Oppdatert')]

        [String]
         $ContractCategory
 ,

        [Parameter(
          Mandatory = $True,
          ParameterSetName = 'By_parameters'
        )]
         [ValidateNotNullOrEmpty()]
         [string]
         $ContractName
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [string]
         $ContractNumber
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [boolean]
         $IsDefaultContract
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [string]
         $Description
 ,

        [Parameter(
          Mandatory = $True,
          ParameterSetName = 'By_parameters'
        )]
         [ValidateNotNullOrEmpty()]
         [datetime]
         $EndDate
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [double]
         $EstimatedCost
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [double]
         $EstimatedHours
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [double]
         $EstimatedRevenue
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [double]
         $OverageBillingRate
 ,

        [Parameter(
          Mandatory = $True,
          ParameterSetName = 'By_parameters'
        )]
         [ValidateNotNullOrEmpty()]
         [datetime]
         $StartDate
 ,

        [Parameter(
          Mandatory = $True,
          ParameterSetName = 'By_parameters'
        )]
         [ValidateNotNullOrEmpty()]
         [ValidateSet('Inactive','Active')]

        [String]
         $Status
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [ValidateSet('Responstid 8 timer','Responstid 4 timer','Support SLA')]

        [String]
         $ServiceLevelAgreementID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [double]
         $SetupFee
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [string]
         $PurchaseOrderNumber
 ,

        [Parameter(
          Mandatory = $True,
          ParameterSetName = 'By_parameters'
        )]
         [ValidateNotNullOrEmpty()]
         [ValidateSet('True','False')]

        [String]
         $TimeReportingRequiresStartAndStopTimes
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $OpportunityID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [long]
         $RenewedContractID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [long]
         $SetupFeeAllocationCodeID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $ContactID

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

    $InputObject = New-Object Autotask.Contract

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
