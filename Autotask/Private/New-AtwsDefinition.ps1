﻿Function New-AtwsDefinition
{ 
  Begin
  { 
    $EntityName = '#EntityName'
    $Prefix = '#Prefix'
        
    If ($Verbose)
    {
      # Make sure the -Verbose parameter is inherited
      $VerbosePreference = 'Continue'
    }

    Write-Verbose ('{0}: Begin of function' -F $MyInvocation.MyCommand.Name)
    $ProcessObject = @()

  }

  Process
  {
    $Fields = Get-AtwsFieldInfo -Entity $EntityName -Connection $Prefix
    
    If ($InputObject)
    {
      Write-Verbose ('{0}: Copy Object mode: Setting ID property to zero' -F $MyInvocation.MyCommand.Name)  
      
      $CopyNo = 1

      Foreach ($Object in $InputObject) 
      { 
        # Create a new object and copy properties
        $NewObject = New-Object Autotask.$EntityName
        
        # Copy every non readonly property
        Foreach ($Field in $Fields.Where({$_.IsReadOnly -eq $False}).Name)
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

        Foreach ($Object in $ProcessObject) 
        { 
          $Object.$($Parameter.Key) = $Value
        }
      }
    }
    $Result = New-AtwsData -Entity $ProcessObject -Connection $Prefix -Verbose:$Verbose.IsPresent  -WhatIf:$WhatIf.IsPresent
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
