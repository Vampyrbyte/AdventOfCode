$SkiSlope = Get-Content $PSScriptRoot\input.txt
$SkiSlope[0]
$i = 0
$y = 0
$trees = 0
$down = 1
$right = 3
Do{
  $i = $i + $down
  if($y + $right -gt $skislope[0].length -1){
      $y = ($y + $right) - $skislope[0].Length
  }
  else{
    $y = $y + $right  
  }
  if($SkiSlope[$i][$y] -eq "#"){
      $trees++
  }
}
While ($i -lt $SkiSlope.count -1)
Write-Host Trees: $trees