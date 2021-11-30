$SkiSlope = Get-Content $PSScriptRoot\input.txt
#Part 1
$i = 0
$j = 0
$trees = 0
$down = 1
$right = 3
Do{
  $i = $i + $down
  if($j + $right -gt $skislope[0].length -1){
      $j = ($j + $right) - $skislope[0].Length
  }
  else{
    $j = $j + $right  
  }
  if($SkiSlope[$i][$j] -eq "#"){
      $trees++
  }
}
While ($i -lt $SkiSlope.count -1)
Write-Host Trees: $trees
#Part 2
$Totaltrees = 1
$Vectors =
@(@{x=1;y=1},
@{x=3;y=1},
@{x=5;y=1},
@{x=7;y=1},
@{x=1;y=2}
)
ForEach($vector in $vectors) {
    $i = 0
    $j = 0
    $trees = 0
    Do{
        $i = $i + $vector.y
        if($j + $vector.x -gt $skislope[0].length -1){
            $j = ($j + $vector.x) - $skislope[0].Length
        }
        else{
          $j = $j + $vector.x  
        }
        if($SkiSlope[$i][$j] -eq "#"){
            $trees++
        }
      }
      While ($i -lt $SkiSlope.count -1)
      $TotalTrees = $Totaltrees * $trees

}
Write-Host "Trees Part 2: " $TotalTrees
