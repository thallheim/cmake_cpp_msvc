$nl        = "`r`n" # Because backticking on my kb layout is ass
$pipeInput = ($input | Out-String).Trim() # Stringify any piped input
$argsInput = $args


function check_cmd ($command) {
    $found = $false
    $found = (Get-Command -type application -name $command -ErrorAction SilentlyContinue)
    if ($found) {
        return $found
        exit 0
    } else {
        Write-Host "FATAL: NOT_FOUND: ${command}"
        exit 1
    }
}


function check_args {
    switch ($argsInput.Count) {
        0       { return $false }
        1       { return $true  }
        default {
            $count = ($argsInput).Count
            Write-Error "Too many args (${count}). Paths with spaces need quoting."
            return $false }
    }
}

$argsOk = $false


# Check for piped input (take precedence if arg also provided)
$inputIsPipe = if (-not [string]::IsNullOrEmpty($pipeInput)) {
    $argsOk = check_args
    Write-Information -msg "inputIsPipe = ${inputIsPipe}"
    $true
} else {
    $argsOk = check_args
    Write-Information -msg "argsOk = ${argsOk}"
    $false
}



# Ensure EITHER piped or arg input; error if both are provided
# if ($argsInput.Count -gt 0 -and -not [string]::IsNullOrEmpty($pipeInput)) {
if ($argsOk -and $inputIsPipe) {
    Write-Error "Can't handle simultaneous pipe and arg input."
    exit 1
}


if ($argsOk) {
    check_cmd($argsInput)
    Write-Host "Hmmmmmm"
    exit 0
}

if ($inputIsPipe) {
    check_cmd($pipeInput)
    exit 0
}
