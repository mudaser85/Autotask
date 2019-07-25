﻿#Requires -Version 4.0
#Version 1.6.2.17
<#

.COPYRIGHT
Copyright (c) Office Center Hønefoss AS. All rights reserved. Based on code from Jan Egil Ring (Crayon). Licensed under the MIT license.
See https://github.com/officecenter/Autotask/blob/master/LICENSE.md for license information.

#>
Function Get-AtwsInstalledProductBillingProductAssociation
{


<#
.SYNOPSIS
This function get one or more InstalledProductBillingProductAssociation through the Autotask Web Services API.
.DESCRIPTION
This function creates a query based on any parameters you give and returns any resulting objects from the Autotask Web Services Api. By default the function returns any objects with properties that are Equal (-eq) to the value of the parameter. To give you more flexibility you can modify the operator by using -NotEquals [ParameterName[]], -LessThan [ParameterName[]] and so on.

Possible operators for all parameters are:
 -NotEquals
 -GreaterThan
 -GreaterThanOrEqual
 -LessThan
 -LessThanOrEquals 

Additional operators for [String] parameters are:
 -Like (supports * or % as wildcards)
 -NotLike
 -BeginsWith
 -EndsWith
 -Contains

Properties with picklists are:


Entities that have fields that refer to the base entity of this CmdLet:


.INPUTS
Nothing. This function only takes parameters.
.OUTPUTS
[Autotask.InstalledProductBillingProductAssociation[]]. This function outputs the Autotask.InstalledProductBillingProductAssociation that was returned by the API.
.EXAMPLE
Get-AtwsInstalledProductBillingProductAssociation -Id 0
Returns the object with Id 0, if any.
 .EXAMPLE
Get-AtwsInstalledProductBillingProductAssociation -InstalledProductBillingProductAssociationName SomeName
Returns the object with InstalledProductBillingProductAssociationName 'SomeName', if any.
 .EXAMPLE
Get-AtwsInstalledProductBillingProductAssociation -InstalledProductBillingProductAssociationName 'Some Name'
Returns the object with InstalledProductBillingProductAssociationName 'Some Name', if any.
 .EXAMPLE
Get-AtwsInstalledProductBillingProductAssociation -InstalledProductBillingProductAssociationName 'Some Name' -NotEquals InstalledProductBillingProductAssociationName
Returns any objects with a InstalledProductBillingProductAssociationName that is NOT equal to 'Some Name', if any.
 .EXAMPLE
Get-AtwsInstalledProductBillingProductAssociation -InstalledProductBillingProductAssociationName SomeName* -Like InstalledProductBillingProductAssociationName
Returns any object with a InstalledProductBillingProductAssociationName that matches the simple pattern 'SomeName*'. Supported wildcards are * and %.
 .EXAMPLE
Get-AtwsInstalledProductBillingProductAssociation -InstalledProductBillingProductAssociationName SomeName* -NotLike InstalledProductBillingProductAssociationName
Returns any object with a InstalledProductBillingProductAssociationName that DOES NOT match the simple pattern 'SomeName*'. Supported wildcards are * and %.

.LINK
New-AtwsInstalledProductBillingProductAssociation
 .LINK
Remove-AtwsInstalledProductBillingProductAssociation
 .LINK
Set-AtwsInstalledProductBillingProductAssociation

#>

  [CmdLetBinding(SupportsShouldProcess = $True, DefaultParameterSetName='Filter', ConfirmImpact='None')]
  Param
  (
# A filter that limits the number of objects that is returned from the API
    [Parameter(
      Mandatory = $true,
      ValueFromRemainingArguments = $true,
      ParameterSetName = 'Filter'
    )]
    [ValidateNotNullOrEmpty()]
    [String[]]
    $Filter,

# Follow this external ID and return any external objects
    [Parameter(
      ParameterSetName = 'Filter'
    )]
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [Alias('GetRef')]
    [ValidateNotNullOrEmpty()]
    [ValidateSet('BillingProductID', 'InstalledProductID')]
    [String]
    $GetReferenceEntityById,

# Return entities of selected type that are referencing to this entity.
    [Parameter(
      ParameterSetName = 'Filter'
    )]
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [Alias('External')]
    [ValidateNotNullOrEmpty()]
    [String]
    $GetExternalEntityByThisEntityId,

# Return all objects in one query
    [Parameter(
      ParameterSetName = 'Get_all'
    )]
    [Switch]
    $All,

# Do not add descriptions for all picklist attributes with values
    [Parameter(
      ParameterSetName = 'Filter'
    )]
    [Parameter(
      ParameterSetName = 'Get_all'
    )]
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [Switch]
    $NoPickListLabel,

# Installed Product Billing Product Association ID
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [Nullable[long][]]
    $id,

# Installed Product ID
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [Nullable[Int][]]
    $InstalledProductID,

# Billing Product ID
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [Nullable[Int][]]
    $BillingProductID,

# Effective Date
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [Nullable[datetime][]]
    $EffectiveDate,

# Expiration Date
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [Nullable[datetime][]]
    $ExpirationDate,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateSet('id', 'InstalledProductID', 'BillingProductID', 'EffectiveDate', 'ExpirationDate')]
    [String[]]
    $NotEquals,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateSet('id', 'InstalledProductID', 'BillingProductID', 'EffectiveDate', 'ExpirationDate')]
    [String[]]
    $IsNull,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateSet('id', 'InstalledProductID', 'BillingProductID', 'EffectiveDate', 'ExpirationDate')]
    [String[]]
    $IsNotNull,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateSet('id', 'InstalledProductID', 'BillingProductID', 'EffectiveDate', 'ExpirationDate')]
    [String[]]
    $GreaterThan,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateSet('id', 'InstalledProductID', 'BillingProductID', 'EffectiveDate', 'ExpirationDate')]
    [String[]]
    $GreaterThanOrEquals,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateSet('id', 'InstalledProductID', 'BillingProductID', 'EffectiveDate', 'ExpirationDate')]
    [String[]]
    $LessThan,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateSet('id', 'InstalledProductID', 'BillingProductID', 'EffectiveDate', 'ExpirationDate')]
    [String[]]
    $LessThanOrEquals,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [String[]]
    $Like,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [String[]]
    $NotLike,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [String[]]
    $BeginsWith,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [String[]]
    $EndsWith,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [String[]]
    $Contains,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateSet('EffectiveDate', 'ExpirationDate')]
    [String[]]
    $IsThisDay
  )

  Begin
  { 
    $EntityName = 'InstalledProductBillingProductAssociation'
    
    # Enable modern -Debug behavior
    If ($PSCmdlet.MyInvocation.BoundParameters['Debug'].IsPresent) {$DebugPreference = 'Continue'}
    
    Write-Debug ('{0}: Begin of function' -F $MyInvocation.MyCommand.Name)
    
  }


  Process
  {
    If ($PSCmdlet.ParameterSetName -eq 'Get_all')
    { 
      $Filter = @('id', '-ge', 0)
    }
    ElseIf (-not ($Filter)) {
    
      Write-Debug ('{0}: Query based on parameters, parsing' -F $MyInvocation.MyCommand.Name)
      
      # Convert named parameters to a filter definition that can be parsed to QueryXML
      $Filter = ConvertTo-AtwsFilter -BoundParameters $PSBoundParameters -EntityName $EntityName
    }
    Else {
      
      Write-Debug ('{0}: Query based on manual filter, parsing' -F $MyInvocation.MyCommand.Name)
              
      $Filter = . Update-AtwsFilter -FilterString $Filter
    } 

    $Caption = $MyInvocation.MyCommand.Name
    $VerboseDescrition = '{0}: About to query the Autotask Web API for {1}(s).' -F $Caption, $EntityName
    $VerboseWarning = '{0}: About to query the Autotask Web API for {1}(s). Do you want to continue?' -F $Caption, $EntityName
    
    If ($PSCmdlet.ShouldProcess($VerboseDescrition, $VerboseWarning, $Caption)) { 
    
      # Make the query and pass the optional parameters to Get-AtwsData
      $Result = Get-AtwsData -Entity $EntityName -Filter $Filter `
        -NoPickListLabel:$NoPickListLabel.IsPresent `
        -GetReferenceEntityById $GetReferenceEntityById `
        -GetExternalEntityByThisEntityId $GetExternalEntityByThisEntityId
    
      Write-Verbose ('{0}: Number of entities returned by base query: {1}' -F $MyInvocation.MyCommand.Name, $Result.Count)

    }
  }

  End
  {
    Write-Debug ('{0}: End of function' -F $MyInvocation.MyCommand.Name)
    If ($Result)
    {
      Return $Result
    }
  }


}