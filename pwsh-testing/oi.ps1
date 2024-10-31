$nl        = "`r`n" # Because backticking on my kb layout is ass
$pipeInput = ($input | Out-String).Trim() # Stringify any piped input
$argsInput =  $args

function is_single_arg { 
    switch ($argsInput.Count) {
        0       { return $false }
        1       { return $true  }
        default { return $false }
    }
}

# Ensure EITHER piped or arg input; error if both are provided
if ($argsInput.Count -gt 0 -and -not [string]::IsNullOrEmpty($pipeInput)) {
    Write-Error "Can't handle simultaneous pipe and arg input."
    exit 1
}

# Ensure singular input arg
$argsInputOk = is_single_arg

if (argsInputOk) {
    $count = ($argsInput).Count
    Write-Information -msg "Arg count: ${count}"
} else {
    $count = ($argsInput).Count
    Write-Error "Too many args (${count}). If providing a path, ensure it is quoted."
    exit 1
}

# Write-Debug -msg "Processesing piped input:" -InformationAction Continue
