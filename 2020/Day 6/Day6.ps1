$Plane = Get-Content $PSScriptRoot\input.txt -Delimiter "`n`n"
$Sum = 0
$Part2Sum = 0
ForEach($Group in $Plane){
    $UniqueAnswers = ($Group -replace "`n","").ToCharArray() | Sort-Object | Get-Unique
    $sum += $UniqueAnswers.count
    $Splitgroup = $Group -split "`n"
    $Splitgroup = $Splitgroup.Split('',[System.StringSplitOptions]::RemoveEmptyEntries)
    $GroupMemberCount = $Splitgroup.count
    ForEach($Answer in $UniqueAnswers){
        $CharCount = ($Group.ToCharArray() | Where-Object {$_ -eq $Answer} | Measure-Object).Count
        If($CharCount -eq $GroupMemberCount){
            $Part2Sum++
        }
    }
}
Write-Host "Part 1:" $Sum
Write-Host "Part 2" $Part2Sum