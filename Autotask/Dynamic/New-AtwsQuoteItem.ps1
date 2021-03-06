#Requires -Version 4.0
#Version 1.6.6
<#
    .COPYRIGHT
    Copyright (c) ECIT Solutions AS. All rights reserved. Licensed under the MIT license.
    See https://github.com/ecitsolutions/Autotask/blob/master/LICENSE.md for license information.
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
$result = New-AtwsQuoteItem -QuoteID [Value] -Type [Value] -Quantity [Value] -UnitDiscount [Value] -PercentageDiscount [Value] -IsOptional [Value] -LineDiscount [Value]
Creates a new [Autotask.QuoteItem] through the Web Services API and returns the new object.
 .EXAMPLE
$result = Get-AtwsQuoteItem -Id 124 | New-AtwsQuoteItem 
Copies [Autotask.QuoteItem] by Id 124 to a new object through the Web Services API and returns the new object.
 .EXAMPLE
Get-AtwsQuoteItem -Id 124 | New-AtwsQuoteItem | Set-AtwsQuoteItem -ParameterName <Parameter Value>
Copies [Autotask.QuoteItem] by Id 124 to a new object through the Web Services API, passes the new object to the Set-AtwsQuoteItem to modify the object.
 .EXAMPLE
$result = Get-AtwsQuoteItem -Id 124 | New-AtwsQuoteItem | Set-AtwsQuoteItem -ParameterName <Parameter Value> -Passthru
Copies [Autotask.QuoteItem] by Id 124 to a new object through the Web Services API, passes the new object to the Set-AtwsQuoteItem to modify the object and returns the new object.

.LINK
Remove-AtwsQuoteItem
 .LINK
Get-AtwsQuoteItem
 .LINK
Set-AtwsQuoteItem

#>

  [CmdLetBinding(SupportsShouldProcess = $true, DefaultParameterSetName='By_parameters', ConfirmImpact='Low')]
  Param
  (
# An array of objects to create
    [Parameter(
      ParametersetName = 'Input_Object',
      ValueFromPipeline = $true
    )]
    [ValidateNotNullOrEmpty()]
    [Autotask.QuoteItem[]]
    $InputObject,

# quote_id
    [Parameter(
      Mandatory = $true,
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [Int]
    $QuoteID,

# parent_type
    [Parameter(
      Mandatory = $true,
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [string]
    $Type,

# product_id
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Int]
    $ProductID,

# cost_id
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Int]
    $CostID,

# labor_id
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Int]
    $LaborID,

# expense_id
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Int]
    $ExpenseID,

# shipping_id
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Int]
    $ShippingID,

# service_id
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Int]
    $ServiceID,

# service_bundle_id
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Int]
    $ServiceBundleID,

# quote_item_name
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,100)]
    [string]
    $Name,

# unit_price
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [double]
    $UnitPrice,

# unit_cost
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [double]
    $UnitCost,

# quantity
    [Parameter(
      Mandatory = $true,
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [double]
    $Quantity,

# discount_dollars
    [Parameter(
      Mandatory = $true,
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [double]
    $UnitDiscount,

# discount_percent
    [Parameter(
      Mandatory = $true,
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [double]
    $PercentageDiscount,

# taxable
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [boolean]
    $IsTaxable,

# optional
    [Parameter(
      Mandatory = $true,
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [boolean]
    $IsOptional,

# period_type
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [string]
    $PeriodType,

# quote_item_description
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [ValidateLength(0,2000)]
    [string]
    $Description,

# line_discount_dollars
    [Parameter(
      Mandatory = $true,
      ParametersetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [double]
    $LineDiscount,

# average_cost
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [double]
    $AverageCost,

# highest_cost
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [double]
    $HighestCost,

# tax_category_id
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [Int]
    $TaxCategoryID,

# tax_rate_applied
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [double]
    $TotalEffectiveTax,

# markup_rate
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [double]
    $MarkupRate,

# internal_currency_unit_price
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [double]
    $InternalCurrencyUnitPrice,

# internal_currency_discount_dollars
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [double]
    $InternalCurrencyUnitDiscount,

# internal_currency_line_discount_dollars
    [Parameter(
      ParametersetName = 'By_parameters'
    )]
    [double]
    $InternalCurrencyLineDiscount
  )
 
    begin { 
        $entityName = 'QuoteItem'
           
        # Enable modern -Debug behavior
        if ($PSCmdlet.MyInvocation.BoundParameters['Debug'].IsPresent) {
            $DebugPreference = 'Continue' 
        }
        else {
            # Respect configured preference
            $DebugPreference = $Script:Atws.Configuration.DebugPref
        }
    
        Write-Debug ('{0}: Begin of function' -F $MyInvocation.MyCommand.Name)

        if (!($PSCmdlet.MyInvocation.BoundParameters['Verbose'].IsPresent)) {
            # No local override of central preference. Load central preference
            $VerbosePreference = $Script:Atws.Configuration.VerbosePref
        }
        
        $processObject = @()
    }

    process {
    
        if ($InputObject) {
            Write-Verbose -Message ('{0}: Copy Object mode: Setting ID property to zero' -F $MyInvocation.MyCommand.Name)  

            $fields = Get-AtwsFieldInfo -Entity $entityName
      
            $CopyNo = 1

            foreach ($object in $InputObject) { 
                # Create a new object and copy properties
                $newObject = New-Object -TypeName Autotask.$entityName
        
                # Copy every non readonly property
                $fieldNames = $fields.Where( { $_.Name -ne 'id' }).Name

                if ($PSBoundParameters.ContainsKey('UserDefinedFields')) { 
                    $fieldNames += 'UserDefinedFields' 
                }

                foreach ($field in $fieldNames) { 
                    $newObject.$field = $object.$field 
                }

                if ($newObject -is [Autotask.Ticket]) {
                    Write-Verbose -Message ('{0}: Copy Object mode: Object is a Ticket. Title must be modified to avoid duplicate detection.' -F $MyInvocation.MyCommand.Name)  
                    $title = '{0} (Copy {1})' -F $newObject.Title, $CopyNo
                    $copyNo++
                    $newObject.Title = $title
                }
                $processObject += $newObject
            }   
        }
        else {
            Write-Debug -Message ('{0}: Creating empty [Autotask.{1}]' -F $MyInvocation.MyCommand.Name, $entityName) 
            $processObject += New-Object -TypeName Autotask.$entityName    
        }
        
        # Prepare shouldProcess comments
        $caption = $MyInvocation.MyCommand.Name
        $verboseDescription = '{0}: About to create {1} {2}(s). This action cannot be undone.' -F $caption, $processObject.Count, $entityName
        $verboseWarning = '{0}: About to create {1} {2}(s). This action may not be undoable. Do you want to continue?' -F $caption, $processObject.Count, $entityName

        # Lets don't and say we did!
        if ($PSCmdlet.ShouldProcess($verboseDescription, $verboseWarning, $caption)) { 
            
            # Process parameters and update objects with their values
            $processObject = $processObject | Update-AtwsObjectsWithParameters -BoundParameters $PSBoundParameters -EntityName $EntityName
            
            $result = Set-AtwsData -Entity $processObject -Create
        }
    }

    end {
        Write-Debug -Message ('{0}: End of function, returning {1} {2}(s)' -F $MyInvocation.MyCommand.Name, $result.count, $entityName)
        Return $result
    }

}
