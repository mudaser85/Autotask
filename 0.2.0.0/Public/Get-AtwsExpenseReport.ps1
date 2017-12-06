﻿<#

.COPYRIGHT
Copyright (c) Office Center Hønefoss AS. All rights reserved. Based on code from Jan Egil Ring (Crayon). Licensed under the MIT license.
See https://github.com/officecenter/OCH-Public/blob/master/LICENSE for license information.

#>

Function Get-AtwsExpenseReport
{
  <#
      .SYNOPSIS
      This function get one or more ExpenseReport through the Autotask Web Services API.
      .DESCRIPTION
      This function creates a query based on any parameters you give and returns any resulting 
objects from the Autotask Web Services Api. By default the function returns any objects with properties 
that are Equal (-eq) to the value of the parameter. To give you more flexibility you can modify the operator
by using -NotEquals [ParameterName[]], -LessThan [ParameterName[]] and so on. 
Use Get-help Get-AtwsExpenseReport for all possible operators.
      .INPUTS
      Nothing. This function only takes parameters.
      .OUTPUTS
      [Autotask.ExpenseReport[]]. This function outputs the Autotask.ExpenseReport that was returned by the API.
      .EXAMPLE
      Get-AtwsExpenseReport  -Parameter1 [Parameter1 value] -Parameter2 [Parameter2 Value] -GreaterThan Parameter2
Returns all objects where a property by name of "Parameter1" is equal to [Parameter1 value] and where a property
by name of "Parameter2" is greater than [Parameter2 Value].
      For parameters, use Get-Help Get-AtwsExpenseReport
      .NOTES
      NAME: Get-AtwsExpenseReport
  #>
	  [CmdLetBinding(DefaultParameterSetName='Filter')]
    Param
    (
                [Parameter(
          Mandatory = $true,
          ValueFromRemainingArguments = $true,
          ParameterSetName = 'Filter')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        $Filter ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [long]
         $id
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [string]
         $Name
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [ValidateSet('In Progress','Awaiting Approval','Approved for Payment','Rejected','Paid','Transferred to QuickBooks')]

        [String]
         $Status
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [datetime]
         $SubmitDate
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $SubmitterID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $ApproverID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [datetime]
         $WeekEnding
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [double]
         $ExpenseTotal
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [double]
         $CashAdvanceAmount
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [string]
         $RejectionReason
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [string]
         $QuickBooksReferenceNumber
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [datetime]
         $ApprovedDate
 ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('id','Name','SubmitDate','SubmitterID','ApproverID','WeekEnding','ExpenseTotal','CashAdvanceAmount','RejectionReason','QuickBooksReferenceNumber','ApprovedDate')]
        [String[]]
        $NotEquals ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('id','Name','SubmitDate','SubmitterID','ApproverID','WeekEnding','ExpenseTotal','CashAdvanceAmount','RejectionReason','QuickBooksReferenceNumber','ApprovedDate')]
        [String[]]
        $GreaterThan ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('id','Name','SubmitDate','SubmitterID','ApproverID','WeekEnding','ExpenseTotal','CashAdvanceAmount','RejectionReason','QuickBooksReferenceNumber','ApprovedDate')]
        [String[]]
        $GreaterThanOrEqual ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('id','Name','SubmitDate','SubmitterID','ApproverID','WeekEnding','ExpenseTotal','CashAdvanceAmount','RejectionReason','QuickBooksReferenceNumber','ApprovedDate')]
        [String[]]
        $LessThan ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('id','Name','SubmitDate','SubmitterID','ApproverID','WeekEnding','ExpenseTotal','CashAdvanceAmount','RejectionReason','QuickBooksReferenceNumber','ApprovedDate')]
        [String[]]
        $LessThanOrEquals ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('Name','RejectionReason','QuickBooksReferenceNumber')]
        [String[]]
        $Like ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('Name','RejectionReason','QuickBooksReferenceNumber')]
        [String[]]
        $NotLike ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('Name','RejectionReason','QuickBooksReferenceNumber')]
        [String[]]
        $BeginsWith ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('Name','RejectionReason','QuickBooksReferenceNumber')]
        [String[]]
        $EndsWith ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('Name','RejectionReason','QuickBooksReferenceNumber')]
        [String[]]
        $Contains
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

    If (-not($Filter))
    {
        $Fields = $Atws.GetFieldInfo('ExpenseReport')
        
        Foreach ($Parameter in $PSBoundParameters.GetEnumerator())
        {
            $Field = $Fields | Where-Object {$_.Name -eq $Parameter.Key}
            If ($Field)
            { 
                If ($Field.IsPickList)
                {
                  $PickListValue = $Field.PickListValues | Where-Object {$_.Label -eq $Parameter.Value}
                  $Value = $PickListValue.Value
                }
                Else
                {
                  $Value = $Parameter.Value
                }
                $Filter += $Parameter.Key
                If ($Parameter.Key -in $NotEquals)
                { $Filter += '-ne'}
                ElseIf ($Parameter.Key -in $GreaterThan)
                { $Filter += '-gt'}
                ElseIf ($Parameter.Key -in $GreaterThanOrEqual)
                { $Filter += '-ge'}
                ElseIf ($Parameter.Key -in $LessThan)
                { $Filter += '-lt'}
                ElseIf ($Parameter.Key -in $LessThanOrEquals)
                { $Filter += '-le'}
                ElseIf ($Parameter.Key -in $Like)
                { $Filter += '-like'}
                ElseIf ($Parameter.Key -in $NotLike)
                { $Filter += '-notlike'}
                ElseIf ($Parameter.Key -in $BeginsWith)
                { $Filter += '-beginswith'}
                ElseIf ($Parameter.Key -in $EndsWith)
                { $Filter += '-endswith'}
                ElseIf ($Parameter.Key -in $Contains)
                { $Filter += '-contains'}
                Else
                { $Filter += '-eq'}
                $Filter += $Value
            }
        }
        
    } #'NotEquals','GreaterThan','GreaterThanOrEqual','LessThan','LessThanOrEquals','Like','NotLike','BeginsWith','EndsWith

    Get-AtwsData -Entity ExpenseReport -Filter $Filter }   

  End
  {
    Write-Verbose ('{0}: End of function' -F $MyInvocation.MyCommand.Name)

  }


        
}
