﻿<#

.COPYRIGHT
Copyright (c) ECIT Solutions AS. All rights reserved. Based on code from Jan Egil Ring (Crayon). Licensed under the MIT license.
See https://github.com/ecitsolutions/Autotask/blob/master/LICENSE.md for license information.

#>
Function Import-AtwsCmdLet {
     <#
      .SYNOPSIS

      .DESCRIPTION

      .INPUTS

      .OUTPUTS

      .EXAMPLE

      .NOTES
      NAME: 
      .LINK

  #>
    [CmdLetBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'Medium'
    )]
    Param(
        [PSObject[]]
        $Entities = $(Get-AtwsFieldInfo -Dynamic)
    )
  
    begin { 

        # Enable modern -Debug behavior
        if ($PSCmdlet.MyInvocation.BoundParameters['Debug'].IsPresent) { $DebugPreference = 'Continue' }  
              
        Write-Debug -Message ('{0}: Start of functions.' -F $MyInvocation.MyCommand.Name)

        # Prepare parameters for @splatting
        $progressId = 2
        $progressParameters = @{
            Activity = 'Creating and importing functions for all Autotask entities with picklists.'
            Id       = $progressId
        }
        
        # The path to a users personal cache folder
        $rootPath = '{0}\WindowsPowershell\Cache\{1}' -f $([environment]::GetFolderPath('MyDocuments')), $Script:Atws.CI

        # Separate cache for beta module
        if ($Script:IsBeta) { 
            $rootPath += '\Beta'
        }
        else {
            $rootPath += '\Dynamic'
        }

        # Make sure directory exists
        if (-not (Test-Path "$rootPath")) {
            $null = New-Item -Path "$rootPath" -ItemType Directory -Force
        }
    
    } 
  
    process {
            
        # Prepare Index for progressbar
        $index = 0
    
        Write-Verbose -Message ('{0}: Creating functions for {1} entities' -F $MyInvocation.MyCommand.Name, $Entities.count) 
        
        foreach ($cacheEntry in $Entities.GetEnumerator()) {
            # EntityInfo()
            $entity = $cacheEntry.Value.EntityInfo
      
            Write-Debug -Message ('{0}: Creating functions for entity {1}' -F $MyInvocation.MyCommand.Name, $entity.Name) 
      
            # Calculating progress percentage and displaying it
            $index++
            $percentComplete = $index / $Entities.Count * 100
      
            # Add parameters for @splatting
            $progressParameters['percentComplete'] = $percentComplete
            $progressParameters['Status'] = 'Entity {0}/{1} ({2:n0}%)' -F $index, $Entities.Count, $percentComplete
            $progressParameters['CurrentOperation'] = 'Importing {0}' -F $entity.Name
      
            Write-Progress @progressParameters
      
            $caption = $MyInvocation.MyCommand.Name
            $verboseDescription = '{0}: Creating and Invoking functions for entity {1}' -F $caption, $entity.Name
            $verboseWarning = '{0}: About to create and Invoke functions for entity {1}. Do you want to continue?' -F $caption, $entity.Name
       
            $functionDefinition = Get-AtwsfunctionDefinition -Entity $entity -FieldInfo $cacheEntry.Value.FieldInfo
        
            if ($PSCmdlet.ShouldProcess($verboseDescription, $verboseWarning, $caption)) { 
        
                foreach ($function in $functionDefinition.GetEnumerator()) {
                    # Set path to powershell script file in user cache
                    $filePath = '{0}\{1}.ps1' -F $rootPath, $function.Key
          
                    # IMport the updated function
                    . ([ScriptBlock]::Create($function.Value))
          
                    # Export the module member
                    Export-ModuleMember -Function $function.Key
          
                    # Write the function to disk for faster load later
                    Set-Content -Path $filePath -Value $function.Value -Force -Encoding UTF8           
                }
            }
        }        

    }

    end {
        Write-Debug -Message ('{0}: Imported {1} dynamic functions' -F $MyInvocation.MyCommand.Name, $index)
    }
}
