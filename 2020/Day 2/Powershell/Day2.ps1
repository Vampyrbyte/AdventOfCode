$Passwords = Get-Content $PSScriptRoot\input.txt
$P1CorrectPasswords = 0
$P2CorrectPasswords = 0
#part one
ForEach($Password in $Passwords){
    $Split = $Password.Split(" ")
    $LowValue = $Split[0].Split("-")[0]
    $HighValue = $Split[0].Split("-")[1]
    $Letter = $split[1][0]
    $pwstring = $split[2]
    $validchars = ($pwstring.ToCharArray() | Where-Object {$_ -eq $letter} | Measure-Object).count
    if($validchars -ige $LowValue -and $validchars -ile $HighValue){
        $P1CorrectPasswords++
    }
}
$P1CorrectPasswords
#part 2
ForEach($Password in $Passwords){
    $Split = $Password.Split(" ")
    $LowValue = ($Split[0].Split("-")[0] -1)
    $HighValue = ($Split[0].Split("-")[1] -1)
    $Letter = $split[1][0]
    $pwstring = $split[2]
    if($pwstring[$LowValue] -eq $Letter -xor $pwstring[$HighValue] -eq $letter){
        $P2CorrectPasswords++
    }
}
$P2CorrectPasswords