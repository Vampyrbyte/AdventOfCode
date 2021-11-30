$Seats = Get-Content $PSScriptRoot\input.txt
$HighestSeatID = 0
$HighLetters = "BR"
$LowLetters = "FL"
$TakenSeats = @()
function ConvertTo-Int {
    param (
        [String]$Binary
    )
    return [convert]::ToInt32($Binary,2)
}

function Convert-Letters {
    param(
        [String]$SeatString
    )
    return [string]($SeatString -replace "[$HighLetters]","1") -replace "[$LowLetters]","0"
}

ForEach($Seat in $Seats){
    $BinarySeat = Convert-Letters($Seat)
    $Row = ConvertTo-Int($BinarySeat.Substring(0,7))
    $Column = ConvertTo-Int($binarySeat.Substring(7))
    $SeatNumber = $Row * 8 + $Column
    If($SeatNumber -gt $HighestSeatID){
        $HighestSeatID = $SeatNumber
    }
    $TakenSeats += $SeatNumber
}

$FirstTakenSeat = $TakenSeats | Sort-Object | Select-Object -First 1
$LastTakenSeat = $TakenSeats | Sort-Object | Select-Object -Last 1
ForEach($SeatValue in $FirstTakenSeat..$LastTakenSeat){
    if($SeatValue -notin $TakenSeats){
        Write-Host "My Seat Is:" $SeatValue
        Break
    }
}

Write-Host "Highest Seat Number:" $HighestSeatID