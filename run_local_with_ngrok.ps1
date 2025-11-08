# Run AJ API server and ngrok together (Windows PowerShell)
# Usage: Open PowerShell as Administrator and run: .\run_local_with_ngrok.ps1
# This script will:
# - Start the Flask API (api_server.py)
# - Start ngrok to expose port 5000
# - Keep both processes running and restart if they exit

$ApiScript = "api_server.py"
$Port = 5000
$NgrokPath = "ngrok" # assume ngrok is in PATH

function Start-Api {
    Write-Host "Starting API server..."
    $startInfo = New-Object System.Diagnostics.ProcessStartInfo
    $startInfo.FileName = "python"
    $startInfo.Arguments = $ApiScript
    $startInfo.WorkingDirectory = (Get-Location).Path
    $startInfo.RedirectStandardOutput = $true
    $startInfo.RedirectStandardError = $true
    $startInfo.UseShellExecute = $false
    $p = New-Object System.Diagnostics.Process
    $p.StartInfo = $startInfo
    $p.Start() | Out-Null
    return $p
}

function Start-Ngrok {
    Write-Host "Starting ngrok on port $Port..."
    $startInfo = New-Object System.Diagnostics.ProcessStartInfo
    $startInfo.FileName = $NgrokPath
    $startInfo.Arguments = "http $Port"
    $startInfo.RedirectStandardOutput = $true
    $startInfo.RedirectStandardError = $true
    $startInfo.UseShellExecute = $false
    $startInfo.WorkingDirectory = (Get-Location).Path
    $p = New-Object System.Diagnostics.Process
    $p.StartInfo = $startInfo
    $p.Start() | Out-Null
    return $p
}

function Tail-Output($process, $name) {
    Start-Job -ScriptBlock {
        param($pId, $n)
        $p = [System.Diagnostics.Process]::GetProcessById($pId)
        while (-not $p.HasExited) {
            $line = $p.StandardOutput.ReadLine()
            if ($line -ne $null) { Write-Host "[$n] $line" }
            Start-Sleep -Milliseconds 50
        }
    } -ArgumentList $process.Id, $name | Out-Null
}

# Start loop
while ($true) {
    $apiProc = Start-Api
    Start-Sleep -Seconds 2
    $ngrokProc = Start-Ngrok

    # Tail outputs
    Tail-Output $apiProc "API"
    Tail-Output $ngrokProc "NGROK"

    Write-Host "API PID: $($apiProc.Id), NGROK PID: $($ngrokProc.Id)"

    # Wait until either process exits
    while (-not $apiProc.HasExited -and -not $ngrokProc.HasExited) {
        Start-Sleep -Seconds 2
    }

    Write-Host "One of the processes exited. Restarting in 3 seconds..."
    if (-not $apiProc.HasExited) { $apiProc.Kill() }
    if (-not $ngrokProc.HasExited) { $ngrokProc.Kill() }
    Start-Sleep -Seconds 3
}
