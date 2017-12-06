﻿<#

.COPYRIGHT
Copyright (c) Office Center Hønefoss AS. All rights reserved. Based on code from Jan Egil Ring (Crayon). Licensed under the MIT license.
See https://github.com/officecenter/OCH-Public/blob/master/LICENSE for license information.

#>

Function Get-AtwsOpportunity
{
  <#
      .SYNOPSIS
      This function get one or more Opportunity through the Autotask Web Services API.
      .DESCRIPTION
      This function creates a query based on any parameters you give and returns any resulting 
objects from the Autotask Web Services Api. By default the function returns any objects with properties 
that are Equal (-eq) to the value of the parameter. To give you more flexibility you can modify the operator
by using -NotEquals [ParameterName[]], -LessThan [ParameterName[]] and so on. 
Use Get-help Get-AtwsOpportunity for all possible operators.
      .INPUTS
      Nothing. This function only takes parameters.
      .OUTPUTS
      [Autotask.Opportunity[]]. This function outputs the Autotask.Opportunity that was returned by the API.
      .EXAMPLE
      Get-AtwsOpportunity  -Parameter1 [Parameter1 value] -Parameter2 [Parameter2 Value] -GreaterThan Parameter2
Returns all objects where a property by name of "Parameter1" is equal to [Parameter1 value] and where a property
by name of "Parameter2" is greater than [Parameter2 Value].
      For parameters, use Get-Help Get-AtwsOpportunity
      .NOTES
      NAME: Get-AtwsOpportunity
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
         [Int]
         $AccountID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [decimal]
         $AdvancedField1
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [decimal]
         $AdvancedField2
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [decimal]
         $AdvancedField3
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [decimal]
         $AdvancedField4
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [decimal]
         $AdvancedField5
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [decimal]
         $Amount
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [string]
         $Barriers
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $ContactID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [decimal]
         $Cost
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [datetime]
         $CreateDate
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [string]
         $HelpNeeded
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $LeadReferral
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [string]
         $Market
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [string]
         $NextStep
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $OwnerResourceID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $ProductID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [datetime]
         $ProjectedCloseDate
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [datetime]
         $ProjectedLiveDate
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [string]
         $PromotionName
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [ValidateSet('Days','Months','Years')]

        [String]
         $RevenueSpreadUnit
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [ValidateSet('New Lead','Stage 1 First Contact','Stage 2 Qualification','Stage 3 Proposal Sent','Stage 4 Contract Sent','Stage 5 Closed')]

        [String]
         $Stage
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [ValidateSet('Not Ready To Buy','Active','Lost','Closed','Implemented')]

        [String]
         $Status
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [datetime]
         $ThroughDate
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [string]
         $Title
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [ValidateSet('Hot','Warm','Cold')]

        [String]
         $Rating
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [datetime]
         $ClosedDate
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [float]
         $AssessmentScore
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [float]
         $TechnicalAssessmentScore
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [float]
         $RelationshipAssessmentScore
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $PrimaryCompetitor
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [ValidateSet('Love the product','See the value','Couple of features we really like','Like our company','Trust our reputation')]

        [String]
         $WinReason
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [ValidateSet("Don’t need our product",'Not a good time','Too expensive',"Competitor’s version offers more",'Couple of features we really need','Not remotely interested')]

        [String]
         $LossReason
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [string]
         $WinReasonDetail
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [string]
         $LossReasonDetail
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [datetime]
         $LastActivity
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [datetime]
         $DateStamp
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $Probability
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $RevenueSpread
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [boolean]
         $UseQuoteTotals
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $TotalAmountMonths
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $SalesProcessPercentComplete
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [Int]
         $SalesOrderID
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [decimal]
         $OnetimeCost
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [decimal]
         $OnetimeRevenue
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [decimal]
         $MonthlyCost
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [decimal]
         $MonthlyRevenue
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [decimal]
         $QuarterlyCost
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [decimal]
         $QuarterlyRevenue
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [decimal]
         $SemiannualCost
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [decimal]
         $SemiannualRevenue
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [decimal]
         $YearlyCost
 ,

        [Parameter(
          Mandatory = $False,
          ParameterSetName = 'By_parameters'
        )]
         [decimal]
         $YearlyRevenue
 ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('id','AccountID','AdvancedField1','AdvancedField2','AdvancedField3','AdvancedField4','AdvancedField5','Amount','Barriers','ContactID','Cost','CreateDate','HelpNeeded','Market','NextStep','OwnerResourceID','ProductID','ProjectedCloseDate','ProjectedLiveDate','PromotionName','ThroughDate','Title','ClosedDate','AssessmentScore','TechnicalAssessmentScore','RelationshipAssessmentScore','WinReasonDetail','LossReasonDetail','LastActivity','DateStamp','Probability','RevenueSpread','UseQuoteTotals','TotalAmountMonths','SalesProcessPercentComplete','SalesOrderID','OnetimeCost','OnetimeRevenue','MonthlyCost','MonthlyRevenue','QuarterlyCost','QuarterlyRevenue','SemiannualCost','SemiannualRevenue','YearlyCost','YearlyRevenue')]
        [String[]]
        $NotEquals ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('id','AccountID','AdvancedField1','AdvancedField2','AdvancedField3','AdvancedField4','AdvancedField5','Amount','Barriers','ContactID','Cost','CreateDate','HelpNeeded','Market','NextStep','OwnerResourceID','ProductID','ProjectedCloseDate','ProjectedLiveDate','PromotionName','ThroughDate','Title','ClosedDate','AssessmentScore','TechnicalAssessmentScore','RelationshipAssessmentScore','WinReasonDetail','LossReasonDetail','LastActivity','DateStamp','Probability','RevenueSpread','UseQuoteTotals','TotalAmountMonths','SalesProcessPercentComplete','SalesOrderID','OnetimeCost','OnetimeRevenue','MonthlyCost','MonthlyRevenue','QuarterlyCost','QuarterlyRevenue','SemiannualCost','SemiannualRevenue','YearlyCost','YearlyRevenue')]
        [String[]]
        $GreaterThan ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('id','AccountID','AdvancedField1','AdvancedField2','AdvancedField3','AdvancedField4','AdvancedField5','Amount','Barriers','ContactID','Cost','CreateDate','HelpNeeded','Market','NextStep','OwnerResourceID','ProductID','ProjectedCloseDate','ProjectedLiveDate','PromotionName','ThroughDate','Title','ClosedDate','AssessmentScore','TechnicalAssessmentScore','RelationshipAssessmentScore','WinReasonDetail','LossReasonDetail','LastActivity','DateStamp','Probability','RevenueSpread','UseQuoteTotals','TotalAmountMonths','SalesProcessPercentComplete','SalesOrderID','OnetimeCost','OnetimeRevenue','MonthlyCost','MonthlyRevenue','QuarterlyCost','QuarterlyRevenue','SemiannualCost','SemiannualRevenue','YearlyCost','YearlyRevenue')]
        [String[]]
        $GreaterThanOrEqual ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('id','AccountID','AdvancedField1','AdvancedField2','AdvancedField3','AdvancedField4','AdvancedField5','Amount','Barriers','ContactID','Cost','CreateDate','HelpNeeded','Market','NextStep','OwnerResourceID','ProductID','ProjectedCloseDate','ProjectedLiveDate','PromotionName','ThroughDate','Title','ClosedDate','AssessmentScore','TechnicalAssessmentScore','RelationshipAssessmentScore','WinReasonDetail','LossReasonDetail','LastActivity','DateStamp','Probability','RevenueSpread','UseQuoteTotals','TotalAmountMonths','SalesProcessPercentComplete','SalesOrderID','OnetimeCost','OnetimeRevenue','MonthlyCost','MonthlyRevenue','QuarterlyCost','QuarterlyRevenue','SemiannualCost','SemiannualRevenue','YearlyCost','YearlyRevenue')]
        [String[]]
        $LessThan ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('id','AccountID','AdvancedField1','AdvancedField2','AdvancedField3','AdvancedField4','AdvancedField5','Amount','Barriers','ContactID','Cost','CreateDate','HelpNeeded','Market','NextStep','OwnerResourceID','ProductID','ProjectedCloseDate','ProjectedLiveDate','PromotionName','ThroughDate','Title','ClosedDate','AssessmentScore','TechnicalAssessmentScore','RelationshipAssessmentScore','WinReasonDetail','LossReasonDetail','LastActivity','DateStamp','Probability','RevenueSpread','UseQuoteTotals','TotalAmountMonths','SalesProcessPercentComplete','SalesOrderID','OnetimeCost','OnetimeRevenue','MonthlyCost','MonthlyRevenue','QuarterlyCost','QuarterlyRevenue','SemiannualCost','SemiannualRevenue','YearlyCost','YearlyRevenue')]
        [String[]]
        $LessThanOrEquals ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('Barriers','HelpNeeded','Market','NextStep','PromotionName','RevenueSpreadUnit','Title','WinReasonDetail','LossReasonDetail')]
        [String[]]
        $Like ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('Barriers','HelpNeeded','Market','NextStep','PromotionName','RevenueSpreadUnit','Title','WinReasonDetail','LossReasonDetail')]
        [String[]]
        $NotLike ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('Barriers','HelpNeeded','Market','NextStep','PromotionName','RevenueSpreadUnit','Title','WinReasonDetail','LossReasonDetail')]
        [String[]]
        $BeginsWith ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('Barriers','HelpNeeded','Market','NextStep','PromotionName','RevenueSpreadUnit','Title','WinReasonDetail','LossReasonDetail')]
        [String[]]
        $EndsWith ,        

        [Parameter(
          ParameterSetName = 'By_parameters'
        )]
        [ValidateSet('Barriers','HelpNeeded','Market','NextStep','PromotionName','RevenueSpreadUnit','Title','WinReasonDetail','LossReasonDetail')]
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
        $Fields = $Atws.GetFieldInfo('Opportunity')
        
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

    Get-AtwsData -Entity Opportunity -Filter $Filter }   

  End
  {
    Write-Verbose ('{0}: End of function' -F $MyInvocation.MyCommand.Name)

  }


        
}
