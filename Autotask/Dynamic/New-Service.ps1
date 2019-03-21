﻿#Requires -Version 4.0
<#

.COPYRIGHT
Copyright (c) Office Center Hønefoss AS. All rights reserved. Based on code from Jan Egil Ring (Crayon). Licensed under the MIT license.
See https://github.com/officecenter/Autotask/blob/master/LICENSE.md for license information.

#>
Function New-Service
{


<#
.SYNOPSIS
This function creates a new Service through the Autotask Web Services API. All required properties are marked as required parameters to assist you on the command line.
.DESCRIPTION
The function supports all properties of an [Autotask.Service] that can be updated through the Web Services API. The function uses PowerShell parameter validation  and supports IntelliSense for selecting picklist values. Any required paramterer is marked as Mandatory in the PowerShell function to assist you on the command line.

If you need very complicated queries you can write a filter directly and pass it using the -Filter parameter. To get the Service with Id number 0 you could write 'New-Service -Id 0' or you could write 'New-Service -Filter {Id -eq 0}.

'New-Service -Id 0,4' could be written as 'New-Service -Filter {id -eq 0 -or id -eq 4}'. For simple queries you can see that using parameters is much easier than the -Filter option. But the -Filter option supports an arbitrary sequence of most operators (-eq, -ne, -gt, -ge, -lt, -le, -and, -or, -beginswith, -endswith, -contains, -like, -notlike, -soundslike, -isnotnull, -isnull, -isthisday). As you can group them using parenthesis '()' you can write arbitrarily complex queries with -Filter. 

To create a new Service you need the following required fields:
 -Name
 -UnitPrice
 -PeriodType
 -AllocationCodeID

Entities that have fields that refer to the base entity of this CmdLet:

BillingItem
 ContractService
 ContractServiceAdjustment
 ContractServiceUnit
 InstalledProduct
 PriceListService
 QuoteItem
 ServiceBundleService

.INPUTS
Nothing. This function only takes parameters.
.OUTPUTS
[Autotask.Service]. This function outputs the Autotask.Service that was created by the API.
.EXAMPLE
$Result = New-Service -Name [Value] -UnitPrice [Value] -PeriodType [Value] -AllocationCodeID [Value]
Creates a new [Autotask.Service] through the Web Services API and returns the new object.
 .EXAMPLE
$Result = Get-Service -Id 124 | New-Service 
Copies [Autotask.Service] by Id 124 to a new object through the Web Services API and returns the new object.
 .EXAMPLE
Get-Service -Id 124 | New-Service | Set-Service -ParameterName <Parameter Value>
Copies [Autotask.Service] by Id 124 to a new object through the Web Services API, passes the new object to the Set-Service to modify the object.
 .EXAMPLE
$Result = Get-Service -Id 124 | New-Service | Set-Service -ParameterName <Parameter Value> -Passthru
Copies [Autotask.Service] by Id 124 to a new object through the Web Services API, passes the new object to the Set-Service to modify the object and returns the new object.

.LINK
Get-Service
 .LINK
Set-Service

#>

  [CmdLetBinding(DefaultParameterSetName='By_parameters', ConfirmImpact='Medium')]
  Param
  (
# An array of objects to create
    [Parameter(
      Mandatory = $true,
      ParameterSetName = 'Input_Object',
      ValueFromPipeline = $true
    )]
    [ValidateNotNullOrEmpty()]
    [Autotask.Service[]]
    $InputObject,

# service_name
    [Parameter(
      Mandatory = $true,
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1,100)]
    [string]
    $Name,

# service_description
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,400)]
    [string]
    $Description,

# unit_price
    [Parameter(
      Mandatory = $true,
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [double]
    $UnitPrice,

# period_type
    [Parameter(
      Mandatory = $true,
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1,1)]
    [string]
    $PeriodType,

# allocation_code_id
    [Parameter(
      Mandatory = $true,
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [Int]
    $AllocationCodeID,

# active
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [boolean]
    $IsActive,

# create_by_id
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [Int]
    $CreatorResourceID,

# update_by_id
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [Int]
    $UpdateResourceID,

# create_date
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [datetime]
    $CreateDate,

# update_date
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [datetime]
    $LastModifiedDate,

# Vendor Account ID
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [Int]
    $VendorAccountID,

# Unit Cost
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [double]
    $UnitCost,

# Invoice Description
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,1000)]
    [string]
    $InvoiceDescription,

# Service Level Agreement Id
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [long]
    $ServiceLevelAgreementID,

# Markup Rate
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [double]
    $MarkupRate
  )
 
  Begin
  { 
    $EntityName = 'Service'
           
    Write-Verbose ('{0}: Begin of function' -F $MyInvocation.MyCommand.Name)
    $ProcessObject = @()
    
    # Set up TimeZone offset handling
    If (-not($script:ESToffset))
    {
      $Now = Get-Date
      $ESTzone = [System.TimeZoneInfo]::FindSystemTimeZoneById("Eastern Standard Time")
      $ESTtime = [System.TimeZoneInfo]::ConvertTimeFromUtc($Now.ToUniversalTime(), $ESTzone)

      $script:ESToffset = (New-TimeSpan -Start $ESTtime -End $Now).TotalHours
    }

  }

  Process
  {
    $Fields = Get-FieldInfo -Entity $EntityName
    
    If ($InputObject)
    {
      Write-Verbose ('{0}: Copy Object mode: Setting ID property to zero' -F $MyInvocation.MyCommand.Name)  
      
      $CopyNo = 1

      Foreach ($Object in $InputObject) 
      { 
        # Create a new object and copy properties
        $NewObject = New-Object Autotask.$EntityName
        
        # Copy every non readonly property
        Foreach ($Field in $Fields.Where({$_.Name -ne 'id'}).Name)
        {
          $NewObject.$Field = $Object.$Field
        }
        If ($NewObject -is [Autotask.Ticket])
        {
          Write-Verbose ('{0}: Copy Object mode: Object is a Ticket. Title must be modified to avoid duplicate detection.' -F $MyInvocation.MyCommand.Name)  
          $Title = '{0} (Copy {1})' -F $NewObject.Title, $CopyNo
          $CopyNo++
          $NewObject.Title = $Title
        }
        $ProcessObject += $NewObject
      }   
    }
    Else
    {
      Write-Verbose ('{0}: Creating empty [Autotask.{1}]' -F $MyInvocation.MyCommand.Name, $EntityName) 
      $ProcessObject += New-Object Autotask.$EntityName    
    }
    
    Foreach ($Parameter in $PSBoundParameters.GetEnumerator())
    {
      $Field = $Fields | Where-Object {$_.Name -eq $Parameter.Key}
      If ($Field -or $Parameter.Key -eq 'UserDefinedFields')
      { 
        If ($Field.IsPickList)
        {
          If($Field.PickListParentValueField)
          {
            $ParentField = $Fields.Where{$_.Name -eq $Field.PickListParentValueField}
            $ParentLabel = $PSBoundParameters.$($ParentField.Name)
            $ParentValue = $ParentField.PickListValues | Where-Object {$_.Label -eq $ParentLabel}
            $PickListValue = $Field.PickListValues | Where-Object {$_.Label -eq $Parameter.Value -and $_.ParentValue -eq $ParentValue.Value}                
          }
          Else 
          { 
            $PickListValue = $Field.PickListValues | Where-Object {$_.Label -eq $Parameter.Value}
          }
          $Value = $PickListValue.Value
        }
        ElseIf ($Field.Type -eq 'datetime')
        {
          # Yes, you really have to ADD the difference
          $Value = $Parameter.Value.AddHours($script:ESToffset)
        }
        Else
        {
          $Value = $Parameter.Value
        } 

        Foreach ($Object in $ProcessObject) 
        { 
          $Object.$($Parameter.Key) = $Value
        }
      }
    }
    $Result = New-AtwsData -Entity $ProcessObject
  }

  End
  {
    Write-Verbose ('{0}: End of function' -F $MyInvocation.MyCommand.Name)

    If ($PSCmdLet.ParameterSetName -eq 'Input_Object')
    {
      # Verify copy mode
      Foreach ($Object in $Result)
      {
        If ($InputObject.Id -contains $Object.Id)
        {
          Write-Verbose ('{0}: Autotask detected new object as duplicate of {1} with Id {2} and tried to update object, not create a new copy. ' -F $MyInvocation.MyCommand.Name, $EntityName, $Object.Id)
        }
      }
    }

    Return $Result
  }


}