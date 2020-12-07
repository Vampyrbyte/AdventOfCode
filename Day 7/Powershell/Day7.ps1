$InputData = Get-Content $PSScriptRoot\input.txt
$Bags = @()
$loopNum = 0

Function Get-IndexOfBag{
    param(
        [string]$Modifier,
        [string]$Colour
    )
    $Lookup = $Modifier + " " + $Colour + "bags*"
    $Found = $inputdata -like $Lookup
    return [array]::indexof($inputdata,$Found)
}

Function Get-ParentsList{
    param(
        [int32]$BagID
    )
    [System.Collections.ArrayList]$ParentsList = @()
    $Child= ""
    ForEach($Bag in $Bags){
        If($Bag.contains.count -gt 0){
            ForEach($Child in $Bag.contains.id){
                if($Child -eq $BagID){
                    $Null = $ParentsList.Add($Bag.id)
                }
            }
        }
    }
    [System.Collections.ArrayList]$GrandParentsList = @()
    If($ParentsList.count -gt 0){
        #Write-Host $ParentsList
        ForEach($Parent in $ParentsList){
            #Write-Host $Parent
            $GrandParents = Get-ParentsList($Parent)
            If($GrandParents -ne $null){
                #Write-Host $GrandParents
                if($GrandParents.count -eq 1){
                    $Null = $GrandParentsList.add($GrandParents)
                }
                else{
                    $Null = $GrandparentsList.AddRange($GrandParents)
                }
            }
        }
        $Null = $Parentslist.Addrange($GrandParentsList)
    }
    return $ParentsList
}
    

ForEach($InputD in $InputData){
    $SplitData = $InputD.Split(" ")
    $Modifier = $SplitData[0]
    $Colour = $Splitdata[1]
    $Bag = [PSCustomObject]@{
        ID = $LoopNum
        Modifier = $Modifier
        Colour = $Colour
        Contains = @()
    }
    $Containers = ($InputD.substring($InputD.IndexOf("contain")+8) -replace "[,.]","").split("bags",[System.StringSplitOptions]::RemoveEmptyEntries).split("bag",[System.StringSplitOptions]::RemoveEmptyEntries).Trim()
    if(-not ($Containers -contains "no other")){
        ForEach($Container in $Containers){
            $ContainerSplit = $Container.split(" ")
            $Quantity = $ContainerSplit[0]
            $Modifier = $ContainerSplit[1]
            $Colour = $ContainerSplit[2]
            $Index = Get-IndexOfBag($Modifier, $Colour)
            $Contain = @{"id" = $index; "Quantity" = $Quantity}
            $Bag.Contains += $Contain
        }
      }
    $Bags += $Bag
    $LoopNum++
}
#Write-Host (Get-ParentsList(Get-IndexOfBag("shiny","gold")))
$Result = Get-ParentsList(Get-IndexOfBag("shiny","gold"))
$UniqueResult = $Result | Sort-Object | Get-Unique
Write-Host $UniqueResult.Count
