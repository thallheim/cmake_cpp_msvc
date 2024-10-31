$inputFromPipe = $false
$inputFromArgs = $false

# Stringify pipe input
$pipeInput = ($input | Out-String).Trim()
$argsInput = $args

# Determine if input is pipe or args
if ([string]::IsNullOrEmpty($pipeInput) -and $args.Count -eq 0) {
    Write-Host "No command supplied. Please provide a command or path."
    exit 1
}

# Check if args provided
if (-not $inputFromPipe -and $args.Count -eq 1)

# Handle arg
if ($args.Count -gt 1) {
    Write-Host "Supply only one command. If supplying a path with spaces, quote it (<'cmd'>/<\"cmd\">)"
    Write-Host "Note: Path resolution not yet implemented" -BackgroundColor DarkRed
    exit 1
} else {
    have_cmd $args[0]
}


function have_cmd ($command) {
    $found = $false
    $res = (Get-Command -type application -name $command -ErrorAction SilentlyContinue)
    if ($res) {
        $found = $true
        return $found
    } else {
        Write-Host "FATAL: NOT_FOUND: ${command}"
        exit 1
    }
}

function is_single_arg {
    switch ($args.Count) {
        0 { return $false }
        1 { return $true  }
        default {
            Write-Host "Too many args provided. If passing a path, quote it."
            return $false
        }
    }
}

 elseif ($pipeInput -and $pipeInput -match "\s") {
    Write-Host "Use 'echo <command>' or quote the command name."
    Write-Host "Note: Path resolution not yet implemented" -BackgroundColor DarkRed
    exit 1
} elseif ($pipeInput) {
    # Handle piped
    have_cmd $pipeInput
} else {
}
