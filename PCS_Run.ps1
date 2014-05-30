# Create a runspace to run Hello World
$rs = [Management.Automation.Runspaces.RunspaceFactory]::CreateRunspace()
$rs.ApartmentState, $rs.ThreadOptions = "STA", "ReuseThread"
$rs.Open()
# Reference the WPF assemblies
$psCmd = {Add-Type}.GetPowerShell()
$psCmd.Runspace =$rs
$psCmd.AddParameter("AssemblyName", "PresentationCore").Invoke()
$psCmd.Commands.Clear()
$psCmd = $psCmd.AddCommand("Add-Type")
$psCmd.AddParameter("AssemblyName", "PresentationFramework").Invoke()
$psCmd.Commands.Clear()
$psCmd = $psCmd.AddCommand("Add-Type")
$psCmd.AddParameter("AssemblyName", "WindowsBase").Invoke()
$sb = $executionContext.InvokeCommand.NewScriptBlock(
(Join-Path $pwd "PCStatus.ps1")
)
$psCmd = $sb.GetPowerShell()
$psCmd.Runspace = $rs
$null = $psCmd.BeginInvoke()
