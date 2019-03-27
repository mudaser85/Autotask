﻿#Requires -Version 4.0
<#

.COPYRIGHT
Copyright (c) Office Center Hønefoss AS. All rights reserved. Based on code from Jan Egil Ring (Crayon). Licensed under the MIT license.
See https://github.com/officecenter/Autotask/blob/master/LICENSE.md for license information.

#>
Function New-AtwsQuoteItem
{


<#
.SYNOPSIS
This function creates a new QuoteItem through the Autotask Web Services API. All required properties are marked as required parameters to assist you on the command line.
.DESCRIPTION
The function supports all properties of an [Autotask.QuoteItem] that can be updated through the Web Services API. The function uses PowerShell parameter validation  and supports IntelliSense for selecting picklist values. Any required paramterer is marked as Mandatory in the PowerShell function to assist you on the command line.

If you need very complicated queries you can write a filter directly and pass it using the -Filter parameter. To get the QuoteItem with Id number 0 you could write 'New-AtwsQuoteItem -Id 0' or you could write 'New-AtwsQuoteItem -Filter {Id -eq 0}.

'New-AtwsQuoteItem -Id 0,4' could be written as 'New-AtwsQuoteItem -Filter {id -eq 0 -or id -eq 4}'. For simple queries you can see that using parameters is much easier than the -Filter option. But the -Filter option supports an arbitrary sequence of most operators (-eq, -ne, -gt, -ge, -lt, -le, -and, -or, -beginswith, -endswith, -contains, -like, -notlike, -soundslike, -isnotnull, -isnull, -isthisday). As you can group them using parenthesis '()' you can write arbitrarily complex queries with -Filter. 

To create a new QuoteItem you need the following required fields:
 -QuoteID
 -Type
 -Quantity
 -UnitDiscount
 -PercentageDiscount
 -IsOptional
 -LineDiscount

Entities that have fields that refer to the base entity of this CmdLet:

ContractService
 ContractServiceAdjustment
 ContractServiceBundle
 ContractServiceBundleAdjustment

.INPUTS
Nothing. This function only takes parameters.
.OUTPUTS
[Autotask.QuoteItem]. This function outputs the Autotask.QuoteItem that was created by the API.
.EXAMPLE
$Result = New-AtwsQuoteItem -QuoteID [Value] -Type [Value] -Quantity [Value] -UnitDiscount [Value] -PercentageDiscount [Value] -IsOptional [Value] -LineDiscount [Value]
Creates a new [Autotask.QuoteItem] through the Web Services API and returns the new object.
 .EXAMPLE
$Result = Get-AtwsQuoteItem -Id 124 | New-AtwsQuoteItem 
Copies [Autotask.QuoteItem] by Id 124 to a new object through the Web Services API and returns the new object.
 .EXAMPLE
Get-AtwsQuoteItem -Id 124 | New-AtwsQuoteItem | Set-AtwsQuoteItem -ParameterName <Parameter Value>
Copies [Autotask.QuoteItem] by Id 124 to a new object through the Web Services API, passes the new object to the Set-AtwsQuoteItem to modify the object.
 .EXAMPLE
$Result = Get-AtwsQuoteItem -Id 124 | New-AtwsQuoteItem | Set-AtwsQuoteItem -ParameterName <Parameter Value> -Passthru
Copies [Autotask.QuoteItem] by Id 124 to a new object through the Web Services API, passes the new object to the Set-AtwsQuoteItem to modify the object and returns the new object.

.LINK
Remove-AtwsQuoteItem
 .LINK
Get-AtwsQuoteItem
 .LINK
Set-AtwsQuoteItem

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
    [Autotask.QuoteItem[]]
    $InputObject,

# quote_id
    [Parameter(
      Mandatory = $true,
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [Int]
    $QuoteID,

# parent_type
    [Parameter(
      Mandatory = $true,
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [Int]
    $Type,

# product_id
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [Int]
    $ProductID,

# cost_id
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [Int]
    $CostID,

# labor_id
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [Int]
    $LaborID,

# expense_id
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [Int]
    $ExpenseID,

# shipping_id
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [Int]
    $ShippingID,

# service_id
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [Int]
    $ServiceID,

# service_bundle_id
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [Int]
    $ServiceBundleID,

# quote_item_name
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,100)]
    [string]
    $Name,

# unit_price
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [double]
    $UnitPrice,

# unit_cost
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [double]
    $UnitCost,

# quantity
    [Parameter(
      Mandatory = $true,
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [double]
    $Quantity,

# discount_dollars
    [Parameter(
      Mandatory = $true,
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [double]
    $UnitDiscount,

# discount_percent
    [Parameter(
      Mandatory = $true,
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [double]
    $PercentageDiscount,

# taxable
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [boolean]
    $IsTaxable,

# optional
    [Parameter(
      Mandatory = $true,
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [boolean]
    $IsOptional,

# period_type
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,50)]
    [string]
    $PeriodType,

# quote_item_description
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,2000)]
    [string]
    $Description,

# line_discount_dollars
    [Parameter(
      Mandatory = $true,
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [double]
    $LineDiscount,

# average_cost
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [double]
    $AverageCost,

# highest_cost
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [double]
    $HighestCost,

# tax_category_id
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [Int]
    $TaxCategoryID,

# tax_rate_applied
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [double]
    $TotalEffectiveTax,

# markup_rate
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [double]
    $MarkupRate,

# internal_currency_unit_price
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [double]
    $InternalCurrencyUnitPrice,

# internal_currency_discount_dollars
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [double]
    $InternalCurrencyUnitDiscount,

# internal_currency_line_discount_dollars
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [double]
    $InternalCurrencyLineDiscount
  )
 
  Begin
  { 
    $EntityName = 'QuoteItem'
           
    # Enable modern -Debug behavior
    If ($PSCmdlet.MyInvocation.BoundParameters['Debug'].IsPresent) {$DebugPreference = 'Continue'}
    
    Write-Debug ('{0}: Begin of function' -F $MyInvocation.MyCommand.Name)
    
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
    $Fields = Get-AtwsFieldInfo -Entity $EntityName
    
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
      Write-Debug ('{0}: Creating empty [Autotask.{1}]' -F $MyInvocation.MyCommand.Name, $EntityName) 
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
          $TimePresent = $Parameter.Value.Hour -gt 0 -or $Parameter.Value.Minute -gt 0 -or $Parameter.Value.Second -gt 0 -or $Parameter.Value.Millisecond -gt 0 
          
          If ($Field.Name -like "*DateTime" -or $TimePresent) { 
            # Yes, you really have to ADD the difference
            $Value = $Parameter.Value.AddHours($script:ESToffset)
          }        
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
    Write-Debug ('{0}: End of function' -F $MyInvocation.MyCommand.Name)

    If ($PSCmdLet.ParameterSetName -eq 'Input_Object')
    {
      # Verify copy mode
      Foreach ($Object in $Result)
      {
        If ($InputObject.Id -contains $Object.Id)
        {
          Write-Warning ('{0}: Autotask detected new object as duplicate of {1} with Id {2} and tried to update object, not create a new copy. ' -F $MyInvocation.MyCommand.Name, $EntityName, $Object.Id)
        }
      }
    }

    Return $Result
  }


}