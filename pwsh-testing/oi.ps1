$nl        = "`r`n" # Because backticking on my kb layout is ass
$pipeInput = ($input | Out-String).Trim() # Stringify any piped input
$argsInput =  $args

# Only supports a single input arg, so make sure there aren't more
function check_args {
    switch ($argsInput.Count) {
        0       { return $false }
        1       { return $true  }
        default { return $false }
    }
}
$argsOk = check_args
Write-Debug "argsOk = ${argsOk}"


# function check_pipe {
#     if (-not [string]::IsNullOrEmpty($pipeInput)) {
#         return $true
#     } else {
#         return $false
#     }
# }

$is_pipe = if (-not [string]::IsNullOrEmpty($pipeInput)) {
    $true
} else {
    $false
}

# Ensure EITHER piped or arg input; error if both are provided
# if ($argsInput.Count -gt 0 -and -not [string]::IsNullOrEmpty($pipeInput)) {
if ($argsInput.Count -gt 0 -and $is_pipe) {
    Write-Error "Can't handle simultaneous pipe and arg input."
    exit 1
}


if ($argsOk) {
    $count = ($args).Count
    Write-Information -msg "Arg count: ${count}"
} else {
    $count = ($args).Count
    Write-Error "Too many args (${count}). If providing a path, ensure it is quoted."
    exit 1
}

# Write-Debug -msg "Processesing piped input:" -InformationAction Continue
