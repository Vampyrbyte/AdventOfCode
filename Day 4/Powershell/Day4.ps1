[string]$Passports = Get-Content $PSScriptRoot\input.txt
$CleanPassports = ($Passports.Replace("`n","  ")).split("  ")
$ValidPassportsP1 = 0
$ValidPassportsP2 = 0
[array]$Invalid = @()
ForEach($Passport in $CleanPassports){
    $Data = ConvertFrom-StringData -StringData $Passport.replace(" ",[System.Environment]::NewLine) -Delimiter ":"
    $data.remove("cid")
    if($data.keys.count -eq 7){
        $ValidPassportsP1++
    }
    else{ 
        $Invalid += $data
        Continue
    }
    if(($data.byr -as [int]) -ge 1920 -and ($data.byr -as [int]) -le 2002){
        if(($data.iyr -as [int]) -ge 2010 -and ($data.iyr -as [int]) -le 2020){
            if(($data.eyr -as [int]) -ge 2020 -and ($data.eyr -as [int]) -le 2030){
            }
            else{
                $Invalid += $data
                continue
            }
        }else{
            $Invalid += $data
            continue
        }
    }
    else {
        $Invalid += $data
        continue
    }
    $HeightUnits = ""
    $HeightValue = ""
    $HeightUnits = $data.hgt.Substring($data.hgt.length -2)
    $HeightValue = $data.hgt.substring(0,$data.hgt.length -2) -as [int]
    if($HeightUnits -eq "cm"){
        if($HeightValue -ge 150 -and $HeightValue -le 193){
        }
        else{
            $Invalid += $data
            continue
        }
    }
    elseif($HeightUnits -eq "in"){
        if($HeightValue -ge 59 -and $HeightValue -le 76){
        }
        else{
            $Invalid += $data
            continue
        }            
    }
    else{
        $Invalid += $data
        continue
    }
    if($data.hcl -match '#[\dA-Fa-f]{6}?'){

    }
    else {
        $Invalid += $data
        continue
    }
    if($data.ecl -in "amb","blu","brn","gry","grn","hzl","oth"){

    }
    else{
        $Invalid += $data
        continue
    }
    if($data.pid -match '^\d{9}$'){
    }
    else {
        $Invalid += $data
        continue
    }

    $ValidPassportsP2++
}
Write-Host "Total passports:" $CleanPassports.Count
#Write-Host "Valid Part 1 Passports:" $ValidPassportsP1
Write-Host "Valid Part 2 Passports:" $ValidPassportsP2
Write-Host "Invalid Passports:" $Invalid.count