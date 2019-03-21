#
# Module manifest for module 'AutotaskBeta'
#
# Generated by: Hugo Klemmestad
#
# Generated on: 21.03.2019
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'AutotaskBeta.psm1'

# Version number of this module.
ModuleVersion = '1.6.1.1'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = 'ff62b403-3520-4b98-a12b-343bb6b79255'

# Author of this module
Author = 'Hugo Klemmestad'

# Company or vendor of this module
CompanyName = 'Office Center Hønefoss AS'

# Copyright statement for this module
Copyright = 'Copyright (c) Office Center Honefoss AS. All rights reserved. Licensed under the MIT license.
See https://github.com/officecenter/Autotask/blob/master/LICENSE.md for license information.'

# Description of the functionality provided by this module
Description = 'This module connects to the Autotask web services API. It downloads information about entities and fields and generates Powershell functions with parameter validation to support Intellisense script editing. To download first all entities and then detailed information about all fields and selection lists is quite time consuming. To speed up module load time and get to coding faster the module caches both script functions and the field info cache to disk.'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '4.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Connect-WebAPI', 'Get-Account', 'Get-AccountAlert', 
               'Get-AccountLocation', 'Get-AccountNote', 
               'Get-AccountPhysicalLocation', 'Get-AccountTeam', 'Get-AccountToDo', 
               'Get-ActionType', 'Get-AdditionalInvoiceFieldValue', 
               'Get-AllocationCode', 'Get-Appointment', 'Get-AttachmentInfo', 
               'Get-BillingItem', 'Get-BillingItemApprovalLevel', 
               'Get-BusinessDivision', 'Get-BusinessDivisionSubdivision', 
               'Get-BusinessDivisionSubdivisionResource', 'Get-BusinessLocation', 
               'Get-BusinessSubdivision', 'Get-ChangeRequestLink', 
               'Get-ClassificationIcon', 'Get-ClientPortalUser', 'Get-Contact', 
               'Get-ContactGroup', 'Get-ContactGroupContact', 'Get-Contract', 
               'Get-ContractBlock', 'Get-ContractCost', 
               'Get-ContractExclusionAllocationCode', 'Get-ContractExclusionRole', 
               'Get-ContractFactor', 'Get-ContractMilestone', 'Get-ContractNote', 
               'Get-ContractRate', 'Get-ContractRetainer', 'Get-ContractRoleCost', 
               'Get-ContractService', 'Get-ContractServiceBundle', 
               'Get-ContractServiceBundleUnit', 'Get-ContractServiceUnit', 
               'Get-ContractTicketPurchase', 'Get-Country', 'Get-Currency', 
               'Get-Department', 'Get-ExpenseItem', 'Get-ExpenseReport', 
               'Get-FieldInfo', 'Get-Holiday', 'Get-HolidaySet', 
               'Get-InstalledProduct', 'Get-InstalledProductType', 
               'Get-InstalledProductTypeUdfAssociation', 'Get-InternalLocation', 
               'Get-InventoryItem', 'Get-InventoryItemSerialNumber', 
               'Get-InventoryLocation', 'Get-InventoryTransfer', 'Get-Invoice', 
               'Get-InvoiceInfo', 'Get-InvoiceTemplate', 'Get-NotificationHistory', 
               'Get-Opportunity', 'Get-PaymentTerm', 'Get-Phase', 
               'Get-PriceListMaterialCode', 'Get-PriceListProduct', 
               'Get-PriceListRole', 'Get-PriceListService', 
               'Get-PriceListServiceBundle', 'Get-PriceListWorkTypeModifier', 
               'Get-Product', 'Get-ProductVendor', 'Get-Project', 'Get-ProjectCost', 
               'Get-ProjectNote', 'Get-PurchaseApproval', 'Get-PurchaseOrder', 
               'Get-PurchaseOrderItem', 'Get-PurchaseOrderReceive', 'Get-Quote', 
               'Get-QuoteItem', 'Get-QuoteLocation', 'Get-QuoteTemplate', 
               'Get-Resource', 'Get-ResourceRole', 'Get-ResourceRoleDepartment', 
               'Get-ResourceRoleQueue', 'Get-ResourceServiceDeskRole', 
               'Get-ResourceSkill', 'Get-Role', 'Get-SalesOrder', 'Get-Service', 
               'Get-ServiceBundle', 'Get-ServiceBundleService', 'Get-ServiceCall', 
               'Get-ServiceCallTask', 'Get-ServiceCallTaskResource', 
               'Get-ServiceCallTicket', 'Get-ServiceCallTicketResource', 
               'Get-ServiceLevelAgreementResults', 'Get-ShippingType', 'Get-Skill', 
               'Get-Subscription', 'Get-SubscriptionPeriod', 'Get-Survey', 
               'Get-SurveyResults', 'Get-Task', 'Get-TaskNote', 'Get-TaskPredecessor', 
               'Get-TaskSecondaryResource', 'Get-Tax', 'Get-TaxCategory', 
               'Get-TaxRegion', 'Get-Ticket', 'Get-TicketAdditionalContact', 
               'Get-TicketAdditionalInstalledProduct', 'Get-TicketCategory', 
               'Get-TicketCategoryFieldDefaults', 
               'Get-TicketChangeRequestApproval', 'Get-TicketChecklistItem', 
               'Get-TicketCost', 'Get-TicketHistory', 'Get-TicketNote', 
               'Get-TicketSecondaryResource', 'Get-TimeEntry', 
               'Get-UserDefinedFieldDefinition', 'Get-UserDefinedFieldListItem', 
               'Get-WorkTypeModifier', 'New-Account', 'New-AccountAlert', 
               'New-AccountNote', 'New-AccountPhysicalLocation', 'New-AccountTeam', 
               'New-AccountToDo', 'New-ActionType', 'New-Appointment', 
               'New-BillingItemApprovalLevel', 'New-BusinessDivision', 
               'New-BusinessDivisionSubdivision', 'New-BusinessLocation', 
               'New-BusinessSubdivision', 'New-ChangeRequestLink', 
               'New-ClientPortalUser', 'New-Contact', 'New-ContactGroup', 
               'New-ContactGroupContact', 'New-Contract', 'New-ContractBlock', 
               'New-ContractCost', 'New-ContractExclusionAllocationCode', 
               'New-ContractExclusionRole', 'New-ContractFactor', 
               'New-ContractMilestone', 'New-ContractNote', 'New-ContractRate', 
               'New-ContractRetainer', 'New-ContractRoleCost', 'New-ContractService', 
               'New-ContractServiceAdjustment', 'New-ContractServiceBundle', 
               'New-ContractServiceBundleAdjustment', 'New-ContractTicketPurchase', 
               'New-Department', 'New-ExpenseItem', 'New-ExpenseReport', 'New-Holiday', 
               'New-HolidaySet', 'New-InstalledProduct', 'New-InstalledProductType', 
               'New-InstalledProductTypeUdfAssociation', 'New-InventoryItem', 
               'New-InventoryItemSerialNumber', 'New-InventoryLocation', 
               'New-InventoryTransfer', 'New-Opportunity', 'New-PaymentTerm', 
               'New-Phase', 'New-Product', 'New-ProductVendor', 'New-Project', 
               'New-ProjectCost', 'New-ProjectNote', 'New-PurchaseOrder', 
               'New-PurchaseOrderItem', 'New-PurchaseOrderReceive', 'New-Quote', 
               'New-QuoteItem', 'New-QuoteLocation', 'New-ResourceRoleDepartment', 
               'New-ResourceRoleQueue', 'New-ResourceServiceDeskRole', 'New-Role', 
               'New-Service', 'New-ServiceBundle', 'New-ServiceBundleService', 
               'New-ServiceCall', 'New-ServiceCallTask', 
               'New-ServiceCallTaskResource', 'New-ServiceCallTicket', 
               'New-ServiceCallTicketResource', 'New-Subscription', 'New-Task', 
               'New-TaskNote', 'New-TaskPredecessor', 'New-TaskSecondaryResource', 
               'New-Tax', 'New-TaxCategory', 'New-TaxRegion', 'New-Ticket', 
               'New-TicketAdditionalContact', 
               'New-TicketAdditionalInstalledProduct', 
               'New-TicketChangeRequestApproval', 'New-TicketChecklistItem', 
               'New-TicketCost', 'New-TicketNote', 'New-TicketSecondaryResource', 
               'New-TimeEntry', 'New-UserDefinedFieldDefinition', 
               'New-UserDefinedFieldListItem', 'Remove-AccountPhysicalLocation', 
               'Remove-AccountTeam', 'Remove-AccountToDo', 'Remove-ActionType', 
               'Remove-Appointment', 'Remove-ChangeRequestLink', 
               'Remove-ContactGroup', 'Remove-ContactGroupContact', 
               'Remove-ContractCost', 'Remove-ContractExclusionAllocationCode', 
               'Remove-ContractExclusionRole', 'Remove-Holiday', 'Remove-HolidaySet', 
               'Remove-InstalledProductType', 
               'Remove-InstalledProductTypeUdfAssociation', 'Remove-ProjectCost', 
               'Remove-QuoteItem', 'Remove-ServiceBundle', 
               'Remove-ServiceBundleService', 'Remove-ServiceCall', 
               'Remove-ServiceCallTask', 'Remove-ServiceCallTaskResource', 
               'Remove-ServiceCallTicket', 'Remove-ServiceCallTicketResource', 
               'Remove-Subscription', 'Remove-TaskPredecessor', 
               'Remove-TaskSecondaryResource', 'Remove-TicketAdditionalContact', 
               'Remove-TicketAdditionalInstalledProduct', 
               'Remove-TicketChangeRequestApproval', 'Remove-TicketChecklistItem', 
               'Remove-TicketCost', 'Remove-TicketSecondaryResource', 'Set-Account', 
               'Set-AccountAlert', 'Set-AccountLocation', 'Set-AccountNote', 
               'Set-AccountPhysicalLocation', 'Set-AccountToDo', 'Set-ActionType', 
               'Set-Appointment', 'Set-BillingItem', 'Set-BusinessDivision', 
               'Set-BusinessDivisionSubdivision', 'Set-BusinessLocation', 
               'Set-BusinessSubdivision', 'Set-ClientPortalUser', 'Set-Contact', 
               'Set-ContactGroup', 'Set-Contract', 'Set-ContractBlock', 
               'Set-ContractCost', 'Set-ContractFactor', 'Set-ContractMilestone', 
               'Set-ContractNote', 'Set-ContractRate', 'Set-ContractRetainer', 
               'Set-ContractRoleCost', 'Set-ContractService', 
               'Set-ContractServiceBundle', 'Set-ContractTicketPurchase', 
               'Set-Country', 'Set-Currency', 'Set-Department', 'Set-ExpenseItem', 
               'Set-ExpenseReport', 'Set-Holiday', 'Set-HolidaySet', 
               'Set-InstalledProduct', 'Set-InstalledProductType', 
               'Set-InstalledProductTypeUdfAssociation', 'Set-InventoryItem', 
               'Set-InventoryItemSerialNumber', 'Set-InventoryLocation', 
               'Set-Invoice', 'Set-Opportunity', 'Set-PaymentTerm', 'Set-Phase', 
               'Set-PriceListMaterialCode', 'Set-PriceListProduct', 
               'Set-PriceListRole', 'Set-PriceListService', 
               'Set-PriceListServiceBundle', 'Set-PriceListWorkTypeModifier', 
               'Set-Product', 'Set-ProductVendor', 'Set-Project', 'Set-ProjectCost', 
               'Set-ProjectNote', 'Set-PurchaseApproval', 'Set-PurchaseOrder', 
               'Set-PurchaseOrderItem', 'Set-Quote', 'Set-QuoteItem', 
               'Set-QuoteLocation', 'Set-Resource', 'Set-ResourceRoleDepartment', 
               'Set-ResourceRoleQueue', 'Set-ResourceServiceDeskRole', 
               'Set-ResourceSkill', 'Set-Role', 'Set-SalesOrder', 'Set-Service', 
               'Set-ServiceBundle', 'Set-ServiceCall', 'Set-Subscription', 'Set-Task', 
               'Set-TaskNote', 'Set-TaskPredecessor', 'Set-Tax', 'Set-TaxCategory', 
               'Set-TaxRegion', 'Set-Ticket', 'Set-TicketCategory', 
               'Set-TicketChecklistItem', 'Set-TicketCost', 'Set-TicketNote', 
               'Set-TimeEntry', 'Set-UserDefinedFieldDefinition', 
               'Set-UserDefinedFieldListItem', 'Set-WorkTypeModifier', 
               'Uninstall-OldModuleVersion', 'Update-DiskCache', 'Update-Functions', 
               'Update-Manifest'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
# VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'Autotask', 'Function', 'SOAP'

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/officecenter/Autotask/blob/master/LICENSE.md'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/officecenter/Autotask'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = 'https://github.com/officecenter/Autotask/blob/master/README.md'

    } # End of PSData hashtable


} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
DefaultCommandPrefix = 'Atws'

}

