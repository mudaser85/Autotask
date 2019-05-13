﻿#Requires -Version 4.0
<#

.COPYRIGHT
Copyright (c) Office Center Hønefoss AS. All rights reserved. Based on code from Jan Egil Ring (Crayon). Licensed under the MIT license.
See https://github.com/officecenter/Autotask/blob/master/LICENSE.md for license information.

#>
Function Get-AtwsResource
{


<#
.SYNOPSIS
This function get one or more Resource through the Autotask Web Services API.
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

EmailTypeCode
 

EmailTypeCode2
 

EmailTypeCode3
 

Gender
 

Greeting
 

LocationID
 

ResourceType
 

Suffix
 

TravelAvailabilityPct
 

UserType
 

DateFormat
 

TimeFormat
 

PayrollType
 

NumberFormat
 

LicenseType
 

Entities that have fields that refer to the base entity of this CmdLet:

Account
 AccountNote
 AccountTeam
 AccountToDo
 Appointment
 AttachmentInfo
 BillingItem
 BillingItemApprovalLevel
 BusinessDivisionSubdivisionResource
 ContractCost
 ContractMilestone
 ContractNote
 ContractRoleCost
 Currency
 ExpenseReport
 InstalledProduct
 InventoryLocation
 InventoryTransfer
 Invoice
 NotificationHistory
 Opportunity
 Phase
 Project
 ProjectCost
 ProjectNote
 PurchaseOrder
 PurchaseOrderReceive
 Quote
 QuoteTemplate
 ResourceRole
 ResourceRoleDepartment
 ResourceRoleQueue
 ResourceServiceDeskRole
 ResourceSkill
 SalesOrder
 Service
 ServiceBundle
 ServiceCallTaskResource
 ServiceCallTicketResource
 ServiceLevelAgreementResults
 Task
 TaskNote
 TaskSecondaryResource
 Ticket
 TicketChangeRequestApproval
 TicketChecklistItem
 TicketCost
 TicketHistory
 TicketNote
 TicketSecondaryResource
 TimeEntry

.INPUTS
Nothing. This function only takes parameters.
.OUTPUTS
[Autotask.Resource[]]. This function outputs the Autotask.Resource that was returned by the API.
.EXAMPLE
Get-AtwsResource -Id 0
Returns the object with Id 0, if any.
 .EXAMPLE
Get-AtwsResource -ResourceName SomeName
Returns the object with ResourceName 'SomeName', if any.
 .EXAMPLE
Get-AtwsResource -ResourceName 'Some Name'
Returns the object with ResourceName 'Some Name', if any.
 .EXAMPLE
Get-AtwsResource -ResourceName 'Some Name' -NotEquals ResourceName
Returns any objects with a ResourceName that is NOT equal to 'Some Name', if any.
 .EXAMPLE
Get-AtwsResource -ResourceName SomeName* -Like ResourceName
Returns any object with a ResourceName that matches the simple pattern 'SomeName*'. Supported wildcards are * and %.
 .EXAMPLE
Get-AtwsResource -ResourceName SomeName* -NotLike ResourceName
Returns any object with a ResourceName that DOES NOT match the simple pattern 'SomeName*'. Supported wildcards are * and %.
 .EXAMPLE
Get-AtwsResource -EmailTypeCode <PickList Label>
Returns any Resources with property EmailTypeCode equal to the <PickList Label>. '-PickList' is any parameter on .
 .EXAMPLE
Get-AtwsResource -EmailTypeCode <PickList Label> -NotEquals EmailTypeCode 
Returns any Resources with property EmailTypeCode NOT equal to the <PickList Label>.
 .EXAMPLE
Get-AtwsResource -EmailTypeCode <PickList Label1>, <PickList Label2>
Returns any Resources with property EmailTypeCode equal to EITHER <PickList Label1> OR <PickList Label2>.
 .EXAMPLE
Get-AtwsResource -EmailTypeCode <PickList Label1>, <PickList Label2> -NotEquals EmailTypeCode
Returns any Resources with property EmailTypeCode NOT equal to NEITHER <PickList Label1> NOR <PickList Label2>.
 .EXAMPLE
Get-AtwsResource -Id 1234 -ResourceName SomeName* -EmailTypeCode <PickList Label1>, <PickList Label2> -Like ResourceName -NotEquals EmailTypeCode -GreaterThan Id
An example of a more complex query. This command returns any Resources with Id GREATER THAN 1234, a ResourceName that matches the simple pattern SomeName* AND that has a EmailTypeCode that is NOT equal to NEITHER <PickList Label1> NOR <PickList Label2>.

.LINK
Set-AtwsResource

#>

  [CmdLetBinding(DefaultParameterSetName='Filter', ConfirmImpact='None')]
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
    [ValidateSet('DefaultServiceDeskRoleID')]
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
    [ValidateSet('SalesOrder:OwnerResourceID', 'Project:CreatorResourceID', 'Project:ProjectLeadResourceID', 'Project:CompanyOwnerResourceID', 'Project:LastActivityResourceID', 'Invoice:CreatorResourceID', 'Invoice:VoidedByResourceID', 'Service:CreatorResourceID', 'Service:UpdateResourceID', 'BillingItemApprovalLevel:ApprovalResourceID', 'Account:OwnerResourceID', 'AccountTeam:ResourceID', 'NotificationHistory:InitiatingResourceID', 'TaskNote:CreatorResourceID', 'TaskNote:ImpersonatorCreatorResourceID', 'TaskNote:ImpersonatorUpdaterResourceID', 'AttachmentInfo:AttachedByResourceID', 'ResourceServiceDeskRole:ResourceID', 'PurchaseOrderReceive:ReceivedByResourceID', 'ContractNote:CreatorResourceID', 'ContractNote:ImpersonatorCreatorResourceID', 'ContractNote:ImpersonatorUpdaterResourceID', 'TaskSecondaryResource:ResourceID', 'QuoteTemplate:CreatedBy', 'QuoteTemplate:LastActivityBy', 'ResourceRole:ResourceID', 'ServiceBundle:CreatorResourceID', 'ServiceBundle:UpdateResourceID', 'BillingItem:ItemApproverID', 'BillingItem:AccountManagerWhenApprovedID', 'Ticket:AssignedResourceID', 'Ticket:CreatorResourceID', 'Ticket:CompletedByResourceID', 'Ticket:LastActivityResourceID', 'ContractMilestone:CreatorResourceID', 'InstalledProduct:InstalledByID', 'InstalledProduct:LastActivityPersonID', 'TicketCost:CreatorResourceID', 'PurchaseOrder:CreatorResourceID', 'Appointment:ResourceID', 'Appointment:CreatorResourceID', 'ResourceRoleDepartment:ResourceID', 'ProjectCost:CreatorResourceID', 'TicketChecklistItem:CompletedByResourceID', 'Currency:UpdateResourceId', 'TicketSecondaryResource:ResourceID', 'BusinessDivisionSubdivisionResource:ResourceID', 'ServiceLevelAgreementResults:FirstResponseInitiatingResourceID', 'ServiceLevelAgreementResults:FirstResponseResourceID', 'ServiceLevelAgreementResults:ResolutionPlanResourceID', 'ServiceLevelAgreementResults:ResolutionResourceID', 'ServiceCallTaskResource:ResourceID', 'Phase:CreatorResourceID', 'ContractCost:CreatorResourceID', 'TicketNote:CreatorResourceID', 'TicketNote:ImpersonatorCreatorResourceID', 'TicketNote:ImpersonatorUpdaterResourceID', 'TicketChangeRequestApproval:ResourceID', 'AccountNote:AssignedResourceID', 'AccountNote:ImpersonatorCreatorResourceID', 'AccountNote:ImpersonatorUpdaterResourceID', 'ServiceCallTicketResource:ResourceID', 'ExpenseReport:SubmitterID', 'ExpenseReport:ApproverID', 'Quote:CreatorResourceID', 'Quote:LastModifiedBy', 'TicketHistory:ResourceID', 'ProjectNote:CreatorResourceID', 'ProjectNote:ImpersonatorCreatorResourceID', 'ProjectNote:ImpersonatorUpdaterResourceID', 'TimeEntry:ResourceID', 'TimeEntry:BillingApprovalResourceID', 'TimeEntry:ImpersonatorCreatorResourceID', 'TimeEntry:ImpersonatorUpdaterResourceID', 'Opportunity:OwnerResourceID', 'ResourceSkill:ResourceID', 'ResourceRoleQueue:ResourceID', 'AccountToDo:AssignedToResourceID', 'AccountToDo:CreatorResourceID', 'ContractRoleCost:ResourceID', 'Task:AssignedResourceID', 'Task:CreatorResourceID', 'Task:CompletedByResourceID', 'Task:LastActivityResourceID', 'InventoryTransfer:TransferByResourceID', 'InventoryLocation:ResourceID')]
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

# Status
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [boolean[]]
    $Active,

# Email
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1,254)]
    [string[]]
    $Email,

# Add Email 1
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,254)]
    [string[]]
    $Email2,

# Add Email 2
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,254)]
    [string[]]
    $Email3,

# Email Type
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1,20)]
    [string[]]
    $EmailTypeCode,

# Add Email 1 Type
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,20)]
    [string[]]
    $EmailTypeCode2,

# Add Email 2 Type
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,20)]
    [string[]]
    $EmailTypeCode3,

# First Name
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1,50)]
    [string[]]
    $FirstName,

# Gender
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,1)]
    [string[]]
    $Gender,

# Greeting
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [Int[]]
    $Greeting,

# Home Phone
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,25)]
    [string[]]
    $HomePhone,

# Resource ID
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [long[]]
    $id,

# Pay Roll Identifier
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,32)]
    [string[]]
    $Initials,

# Last Name
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1,50)]
    [string[]]
    $LastName,

# Pimary Location
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [Int[]]
    $LocationID,

# Middle Initial
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,50)]
    [string[]]
    $MiddleName,

# Mobile Phone
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,25)]
    [string[]]
    $MobilePhone,

# Office Extension
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,10)]
    [string[]]
    $OfficeExtension,

# Office Phone
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,25)]
    [string[]]
    $OfficePhone,

# Resource Type
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1,15)]
    [string[]]
    $ResourceType,

# Suffix
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,10)]
    [string[]]
    $Suffix,

# Title
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,50)]
    [string[]]
    $Title,

# Travel Availability Pct
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,15)]
    [string[]]
    $TravelAvailabilityPct,

# UserName
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1,32)]
    [string[]]
    $UserName,

# User Type
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [Int[]]
    $UserType,

# Date Format
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,20)]
    [string[]]
    $DateFormat,

# Time Format
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,20)]
    [string[]]
    $TimeFormat,

# Payroll Type
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [Int[]]
    $PayrollType,

# Number Format
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [ValidateLength(1,20)]
    [string[]]
    $NumberFormat,

# Accounting Reference ID
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateLength(1,100)]
    [string[]]
    $AccountingReferenceID,

# Interal Cost
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [double[]]
    $InternalCost,

# Hire Date
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [datetime[]]
    $HireDate,

# Survey Resource Rating
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [double[]]
    $SurveyResourceRating,

# License Type
    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateNotNullOrEmpty()]
    [Int[]]
    $LicenseType,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateSet('Active', 'Email', 'Email2', 'Email3', 'EmailTypeCode', 'EmailTypeCode2', 'EmailTypeCode3', 'FirstName', 'Gender', 'Greeting', 'HomePhone', 'id', 'Initials', 'LastName', 'LocationID', 'MiddleName', 'MobilePhone', 'OfficeExtension', 'OfficePhone', 'ResourceType', 'Suffix', 'Title', 'TravelAvailabilityPct', 'UserName', 'UserType', 'DateFormat', 'TimeFormat', 'PayrollType', 'NumberFormat', 'AccountingReferenceID', 'InternalCost', 'HireDate', 'SurveyResourceRating', 'LicenseType')]
    [String[]]
    $NotEquals,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateSet('Active', 'Email', 'Email2', 'Email3', 'EmailTypeCode', 'EmailTypeCode2', 'EmailTypeCode3', 'FirstName', 'Gender', 'Greeting', 'HomePhone', 'id', 'Initials', 'LastName', 'LocationID', 'MiddleName', 'MobilePhone', 'OfficeExtension', 'OfficePhone', 'ResourceType', 'Suffix', 'Title', 'TravelAvailabilityPct', 'UserName', 'UserType', 'DateFormat', 'TimeFormat', 'PayrollType', 'NumberFormat', 'AccountingReferenceID', 'InternalCost', 'HireDate', 'SurveyResourceRating', 'LicenseType')]
    [String[]]
    $IsNull,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateSet('Active', 'Email', 'Email2', 'Email3', 'EmailTypeCode', 'EmailTypeCode2', 'EmailTypeCode3', 'FirstName', 'Gender', 'Greeting', 'HomePhone', 'id', 'Initials', 'LastName', 'LocationID', 'MiddleName', 'MobilePhone', 'OfficeExtension', 'OfficePhone', 'ResourceType', 'Suffix', 'Title', 'TravelAvailabilityPct', 'UserName', 'UserType', 'DateFormat', 'TimeFormat', 'PayrollType', 'NumberFormat', 'AccountingReferenceID', 'InternalCost', 'HireDate', 'SurveyResourceRating', 'LicenseType')]
    [String[]]
    $IsNotNull,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateSet('Email', 'Email2', 'Email3', 'EmailTypeCode', 'EmailTypeCode2', 'EmailTypeCode3', 'FirstName', 'Gender', 'Greeting', 'HomePhone', 'id', 'Initials', 'LastName', 'LocationID', 'MiddleName', 'MobilePhone', 'OfficeExtension', 'OfficePhone', 'ResourceType', 'Suffix', 'Title', 'TravelAvailabilityPct', 'UserName', 'UserType', 'DateFormat', 'TimeFormat', 'PayrollType', 'NumberFormat', 'AccountingReferenceID', 'InternalCost', 'HireDate', 'SurveyResourceRating', 'LicenseType')]
    [String[]]
    $GreaterThan,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateSet('Email', 'Email2', 'Email3', 'EmailTypeCode', 'EmailTypeCode2', 'EmailTypeCode3', 'FirstName', 'Gender', 'Greeting', 'HomePhone', 'id', 'Initials', 'LastName', 'LocationID', 'MiddleName', 'MobilePhone', 'OfficeExtension', 'OfficePhone', 'ResourceType', 'Suffix', 'Title', 'TravelAvailabilityPct', 'UserName', 'UserType', 'DateFormat', 'TimeFormat', 'PayrollType', 'NumberFormat', 'AccountingReferenceID', 'InternalCost', 'HireDate', 'SurveyResourceRating', 'LicenseType')]
    [String[]]
    $GreaterThanOrEquals,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateSet('Email', 'Email2', 'Email3', 'EmailTypeCode', 'EmailTypeCode2', 'EmailTypeCode3', 'FirstName', 'Gender', 'Greeting', 'HomePhone', 'id', 'Initials', 'LastName', 'LocationID', 'MiddleName', 'MobilePhone', 'OfficeExtension', 'OfficePhone', 'ResourceType', 'Suffix', 'Title', 'TravelAvailabilityPct', 'UserName', 'UserType', 'DateFormat', 'TimeFormat', 'PayrollType', 'NumberFormat', 'AccountingReferenceID', 'InternalCost', 'HireDate', 'SurveyResourceRating', 'LicenseType')]
    [String[]]
    $LessThan,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateSet('Email', 'Email2', 'Email3', 'EmailTypeCode', 'EmailTypeCode2', 'EmailTypeCode3', 'FirstName', 'Gender', 'Greeting', 'HomePhone', 'id', 'Initials', 'LastName', 'LocationID', 'MiddleName', 'MobilePhone', 'OfficeExtension', 'OfficePhone', 'ResourceType', 'Suffix', 'Title', 'TravelAvailabilityPct', 'UserName', 'UserType', 'DateFormat', 'TimeFormat', 'PayrollType', 'NumberFormat', 'AccountingReferenceID', 'InternalCost', 'HireDate', 'SurveyResourceRating', 'LicenseType')]
    [String[]]
    $LessThanOrEquals,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateSet('Email', 'Email2', 'Email3', 'EmailTypeCode', 'EmailTypeCode2', 'EmailTypeCode3', 'FirstName', 'Gender', 'HomePhone', 'Initials', 'LastName', 'MiddleName', 'MobilePhone', 'OfficeExtension', 'OfficePhone', 'ResourceType', 'Suffix', 'Title', 'TravelAvailabilityPct', 'UserName', 'DateFormat', 'TimeFormat', 'NumberFormat', 'AccountingReferenceID')]
    [String[]]
    $Like,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateSet('Email', 'Email2', 'Email3', 'EmailTypeCode', 'EmailTypeCode2', 'EmailTypeCode3', 'FirstName', 'Gender', 'HomePhone', 'Initials', 'LastName', 'MiddleName', 'MobilePhone', 'OfficeExtension', 'OfficePhone', 'ResourceType', 'Suffix', 'Title', 'TravelAvailabilityPct', 'UserName', 'DateFormat', 'TimeFormat', 'NumberFormat', 'AccountingReferenceID')]
    [String[]]
    $NotLike,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateSet('Email', 'Email2', 'Email3', 'EmailTypeCode', 'EmailTypeCode2', 'EmailTypeCode3', 'FirstName', 'Gender', 'HomePhone', 'Initials', 'LastName', 'MiddleName', 'MobilePhone', 'OfficeExtension', 'OfficePhone', 'ResourceType', 'Suffix', 'Title', 'TravelAvailabilityPct', 'UserName', 'DateFormat', 'TimeFormat', 'NumberFormat', 'AccountingReferenceID')]
    [String[]]
    $BeginsWith,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateSet('Email', 'Email2', 'Email3', 'EmailTypeCode', 'EmailTypeCode2', 'EmailTypeCode3', 'FirstName', 'Gender', 'HomePhone', 'Initials', 'LastName', 'MiddleName', 'MobilePhone', 'OfficeExtension', 'OfficePhone', 'ResourceType', 'Suffix', 'Title', 'TravelAvailabilityPct', 'UserName', 'DateFormat', 'TimeFormat', 'NumberFormat', 'AccountingReferenceID')]
    [String[]]
    $EndsWith,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateSet('Email', 'Email2', 'Email3', 'EmailTypeCode', 'EmailTypeCode2', 'EmailTypeCode3', 'FirstName', 'Gender', 'HomePhone', 'Initials', 'LastName', 'MiddleName', 'MobilePhone', 'OfficeExtension', 'OfficePhone', 'ResourceType', 'Suffix', 'Title', 'TravelAvailabilityPct', 'UserName', 'DateFormat', 'TimeFormat', 'NumberFormat', 'AccountingReferenceID')]
    [String[]]
    $Contains,

    [Parameter(
      ParameterSetName = 'By_parameters'
    )]
    [ValidateSet('HireDate')]
    [String[]]
    $IsThisDay
  )

  Begin
  { 
    $EntityName = 'Resource'
    
    # Enable modern -Debug behavior
    If ($PSCmdlet.MyInvocation.BoundParameters['Debug'].IsPresent) {$DebugPreference = 'Continue'}
    
    Write-Debug ('{0}: Begin of function' -F $MyInvocation.MyCommand.Name)
        
    # Set up TimeZone offset handling
    If (-not($script:ESTzone)) {
      $script:ESTzone = [System.TimeZoneInfo]::FindSystemTimeZoneById("Eastern Standard Time")
    }
    
    If (-not($script:ESToffset)) {
      $Now = Get-Date
      $ESTtime = [System.TimeZoneInfo]::ConvertTimeFromUtc($Now.ToUniversalTime(), $ESTzone)

      $script:ESToffset = (New-TimeSpan -Start $ESTtime -End $Now).TotalHours
    }
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
              
      # $Filter is usually passed as a flat string. Convert it to an array.
      If ($Filter.Count -eq 1 -and $Filter -match ' ' )
      { 
        # First, make sure it is a single string and replace parenthesis with our special operator
        $Filter = $Filter -join ' ' -replace '\(',' -begin ' -replace '\)', ' -end '
    
        # Removing double possible spaces we may have introduced
        Do {$Filter = $Filter -replace '  ',' '}
        While ($Filter -match '  ')

        # Split back in to array, respecting quotes
        $Words = $Filter.Trim().Split(' ')
        [String[]]$Filter = @()
        $Temp = @()
        Foreach ($Word in $Words)
        {
          If ($Temp.Count -eq 0 -and $Word -match '^[\"\'']')
          {
            $Temp += $Word.TrimStart('"''')
          }
          ElseIf ($Temp.Count -gt 0 -and $Word -match "[\'\""]$")
          {
            $Temp += $Word.TrimEnd("'""")
            $Filter += $Temp -join ' '
            $Temp = @()
          }
          ElseIf ($Temp.Count -gt 0)
          {
            $Temp += $Word
          }
          Else
          {
            $Filter += $Word
          }
        }
      }
      
      Write-Debug ('{0}: Checking query for variables that have survived as string' -F $MyInvocation.MyCommand.Name)
      
      $NewFilter = @()
      Foreach ($Word in $Filter)
      {
        $Value = $Word
        # Is it a variable name?
        If ($Word -match '^\$\{?(\w+:)?(\w+)\}?(\.\w[\.\w]+)?$')
        {
          # If present, first group is SCOPE. In the context of this function, the only possible scope
          # is Global; Script = the module, local is internal to this function.
          $Scope = 'Global' # or numbered scope 2
        
          # The variable name MUST be present
          $VariableName = $Matches[2]

          # A property tail CAN be present
          $PropertyTail = $Matches[3]
        
          # Check that the variable exists
          $Variable = Try
          { Get-Variable -Name $VariableName -Scope $Scope -ValueOnly -ErrorAction Stop }
          Catch
          {
            Write-Error ('{0}: Could not find any variable called ${1}. Is it misspelled or has it not been set yet?' -f $MyInvocation.MyCommand.Name, $VariableName)
            # Force stop of calling script, because this will completely break the query
            Return
          }

          # Test if the variable "Variable" has been set
          If (Test-Path Variable:Variable) {
            Write-Debug ('{0}: Substituting {1} for its value' -F $MyInvocation.MyCommand.Name, $Word)
            If ($PropertyTail) {
              # Add properties back 
              $Expression = '$Variable{0}' -F $PropertyTail
  
              # Invoke-Expression is considered risky from an SQL injection kind of perspective. But by only
              # permitting a .dot separated string of [a-zA-Z0-9_] we are PROBABLY safe...
              $Value = Invoke-Expression -Command $Expression
            }
            Else {
              $Value = $Variable
            }
            If ($Value -eq $Null) {
              Write-Error ('{0}: Could not find any variable called {1}. Is it misspelled or has it not been set yet?' -F $MyInvocation.MyCommand.Name, $Expression)
              # Force stop of calling script, because this will completely break the query
              Return
            }
            Else { 
              # Normalize dates. Important to avoid QueryXML problems
              If ($Value.GetType().Name -eq 'DateTime')
              {[String]$Value = ConvertTo-AtwsDate -ParameterName $NewFilter[-2] -DateTime $Value}
            }
          }
        }
        $NewFilter += $Value
      }
    } 

    $Result = Get-AtwsData -Entity $EntityName -Filter $Filter

    Write-Verbose ('{0}: Number of entities returned by base query: {1}' -F $MyInvocation.MyCommand.Name, $Result.Count)
    
    # Datetimeparameters
    $DateTimeParams = $Fields.Where({$_.Type -eq 'datetime'}).Name
    
    # Expand UDFs by default
    Foreach ($Item in $Result)
    {
      # Any userdefined fields?
      If ($Item.UserDefinedFields.Count -gt 0)
      { 
        # Expand User defined fields for easy filtering of collections and readability
        Foreach ($UDF in $Item.UserDefinedFields)
        {
          # Make names you HAVE TO escape...
          $UDFName = '#{0}' -F $UDF.Name
          Add-Member -InputObject $Item -MemberType NoteProperty -Name $UDFName -Value $UDF.Value
        }  
      }
      
      # Adjust TimeZone on all DateTime properties
      Foreach ($DateTimeParam in $DateTimeParams) {
      
        # Get the datetime value
        $ParameterValue = $Item.$DateTimeParam
                
        # Skip if parameter is empty
        If (-not ($ParameterValue)) {
          Continue
        }
        
        $TimePresent = $ParameterValue.Hour -gt 0 -or $ParameterValue.Minute -gt 0 -or $ParameterValue.Second -gt 0 -or $ParameterValue.Millisecond -gt 0 
                
        # If this is a DATE it should not be touched
        If ($DateTimeParam -like "*DateTime" -or $TimePresent) {

          # This is DATETIME 
          # We need to adjust the timezone difference 

          # Yes, you really have to ADD the difference
          $ParameterValue = $ParameterValue.AddHours($script:ESToffset)
            
          # Store the value back to the object (not the API!)
          $Item.$DateTimeParam = $ParameterValue
        }
      }
    }
    
    # Should we return an indirect object?
    if ( ($Result) -and ($GetReferenceEntityById))
    {
      Write-Debug ('{0}: User has asked for external reference objects by {1}' -F $MyInvocation.MyCommand.Name, $GetReferenceEntityById)
      
      $Field = $Fields.Where({$_.Name -eq $GetReferenceEntityById})
      $ResultValues = $Result | Where-Object {$null -ne $_.$GetReferenceEntityById}
      If ($ResultValues.Count -lt $Result.Count)
      {
        Write-Warning ('{0}: Only {1} of the {2}s in the primary query had a value in the property {3}.' -F $MyInvocation.MyCommand.Name, 
          $ResultValues.Count,
          $EntityName,
        $GetReferenceEntityById) -WarningAction Continue
      }
      $Filter = 'id -eq {0}' -F $($ResultValues.$GetReferenceEntityById -join ' -or id -eq ')
      $Result = Get-Atwsdata -Entity $Field.ReferenceEntityType -Filter $Filter
    }
    ElseIf ( ($Result) -and ($GetExternalEntityByThisEntityId))
    {
      Write-Debug ('{0}: User has asked for {1} that are referencing this result' -F $MyInvocation.MyCommand.Name, $GetExternalEntityByThisEntityId)
      $ReferenceInfo = $GetExternalEntityByThisEntityId -Split ':'
      $Filter = '{0} -eq {1}' -F $ReferenceInfo[1], $($Result.id -join (' -or {0}id -eq ' -F $ReferenceInfo[1]))
      $Result = Get-Atwsdata -Entity $ReferenceInfo[0] -Filter $Filter
     }
    # Do the user want labels along with index values for Picklists?
    ElseIf ( ($Result) -and -not ($NoPickListLabel))
    {
      Foreach ($Field in $Fields.Where{$_.IsPickList})
      {
        $FieldName = '{0}Label' -F $Field.Name
        Foreach ($Item in $Result)
        {
          $Value = ($Field.PickListValues.Where{$_.Value -eq $Item.$($Field.Name)}).Label
          Add-Member -InputObject $Item -MemberType NoteProperty -Name $FieldName -Value $Value -Force
          
        }
      }
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
