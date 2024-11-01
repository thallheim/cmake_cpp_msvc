$nl        = "`r`n" # Because backticking on my kb layout is ass
$pipeInput = ($input | Out-String).Trim() # Stringify any piped input
$argsInput =  $args


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
$pipedInput = if (-not [string]::IsNullOrEmpty($pipeInput)) {
    $argsOk = check_args
    Write-Information -msg "pipedInput = ${pipedInput}"
    $true
} else {
    $argsOk = check_args
    Write-Information -msg "argsOk = ${argsOk}"
    $false
}



# Ensure EITHER piped or arg input; error if both are provided
# if ($argsInput.Count -gt 0 -and -not [string]::IsNullOrEmpty($pipeInput)) {
if ($argsOk -and $pipedInput) {
    Write-Error "Can't handle simultaneous pipe and arg input."
    exit 1
}


if ($argsOk) {
    Write-Error "OH NOES ARGS"
    exit 1
}

if ($pipedInput) {
    Write-Error "OH NOES PIPE"
    exit 1
}
