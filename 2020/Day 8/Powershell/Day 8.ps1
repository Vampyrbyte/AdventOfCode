$Stopwatch = [system.diagnostics.stopwatch]::StartNew()
$InputData = Get-Content $PSScriptRoot\input.txt
$Acc = 0
$ProgramCounter = 0
$LoopTracker = [System.Collections.ArrayList]@()
$ChangeTracker = [System.Collections.ArrayList]@()
$CanSwapInstruction = $true
$SavedAcc = 0
$SavedProgramCounter = 0
$SavedInstruction = ""
$ResetInstruction = $False
do{
    #Write-Host "PC:" $ProgramCounter
    $instruction = $InputData[$ProgramCounter].split(" ")[0]
    $data = $InputData[$ProgramCounter].split(" ")[1] -as [int]
    if ($ResetInstruction){
        $Instruction = $SavedInstruction
        $ResetInstruction = $false
        $CanSwapInstruction = $True
    }
    if ($ProgramCounter -in $LoopTracker){
        Write-Host "Loop Detected! Acc:" $Acc
        $Acc = $SavedAcc
        $ProgramCounter = $SavedProgramCounter
        $ResetInstruction = $true
        $LoopTracker.Clear()
        continue
    }
    if(($instruction -eq "jmp" -and $CanSwapInstruction) -and ($ProgramCounter -notin $ChangeTracker)){
        $SavedAcc = $Acc
        $SavedProgramCounter = $ProgramCounter
        $SavedInstruction = $instruction
        $Instruction = "nop"
        [void]$ChangeTracker.add($ProgramCounter)
        $CanSwapInstruction = $False
        Write-Host "Swapped jmp for nop"
    }
    if(($instruction -eq "nop" -and $CanSwapInstruction) -and ($ProgramCounter -notin $ChangeTracker)){
        $SavedAcc = $Acc
        $SavedProgramCounter = $ProgramCounter
        $SavedInstruction = $instruction
        $Instruction = "nop"
        [void]$ChangeTracker.add($ProgramCounter)
        $CanSwapInstruction = $False
        Write-Host "Swapped nop for jmp"
    }
    if(-not $CanSwapInstruction){
        [void]$LoopTracker.add($ProgramCounter)
    }
    switch($instruction){
        "nop" {$ProgramCounter++}
        "jmp" {$ProgramCounter = $ProgramCounter + $Data}
        "acc" {$acc = $acc + $data; $ProgramCounter++}
    }
}
while ($ProgramCounter -lt $InputData.count)
Write-Host "Final ACC: " $Acc
$Stopwatch.stop()
$Stopwatch