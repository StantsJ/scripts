#####################################################################################
# Title:  pcStatus
# Purpose: To provide at a glance computer status and basic troubleshooting utilities
# Author: Joseph Stants
# Date: 11/1/2012 Added ping and ipconfig boxes,
#       button controls, transparency,drag and move event handler
# Date: 11/2/2012 Added Get-Process box, the ability to interact with ping,
#       tons of button rigging, and To-HTML(whole can of worms)
# Date: 11/3/2012 Added Start and Stop process and some tooltips
# Date: 11/4/2012 Worked more on the web site generation
# Date: 1/21/2013 Added Windoes Update Status Box
#####################################################################################

#Load WPF
Add-Type -AssemblyName presentationframework

#Set XAML
[xml]$XAML = @'

<Window 
        Title="IP Status"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Height="699" 
        Width="1000"
        AllowsTransparency="True"
        WindowStyle="None"
        ResizeMode="NoResize" FontStretch="Normal">
    <Grid Width="957">
        <ListBox
            Name="lstIpconfig" 
            Height="200" 
            Width="400" 
            HorizontalAlignment="Left" 
            VerticalAlignment="Top"
            Padding="6" Margin="74,41,0,0" BorderBrush="Orange" FontFamily="Consolas" FontSize="12" Background="Black" Foreground="Orange" Opacity="0.75" Focusable="True" />
        <ListBox
            Name="lstPing"
            Height="200"
            Width="400" 
            HorizontalAlignment="Right" 
            Margin="0,41,0,0" 
            VerticalAlignment="Top"
            Padding="6" BorderBrush="Orange" FontFamily="Consolas" FontSize="12" Background="Black" Foreground="Orange" Opacity="0.75" Focusable="True" IsHitTestVisible="True" />
        <Label 
            Content="Ping" Height="35" HorizontalAlignment="Left" Name="label1" 
            VerticalAlignment="Top" 
            Width="269" 
            FontSize="18" 
            Margin="480,0,0,0" 
            BorderThickness="2" 
            BorderBrush="Orange" 
            FontFamily="Consolas" Background="Black" Foreground="Orange" Opacity="0.75"></Label>
        <Label Content="Ipconfig" FontSize="18" Height="35" HorizontalAlignment="Left" Name="label2" VerticalAlignment="Top" Width="474" BorderBrush="Orange" BorderThickness="2" Background="Black" FontFamily="Consolas" Foreground="Orange" Opacity="0.75"></Label>
        <Button Content="Refresh" Height="60" HorizontalAlignment="Left" Margin="0,41,0,0" Name="btnRefreshIpconfig" VerticalAlignment="Top" Width="68" BorderBrush="Orange" FontWeight="Bold" Background="Black" FontFamily="Consolas" Foreground="Orange" Opacity="0.75" FontSize="12"></Button>
        <Button BorderBrush="Orange" Content="Refresh" FontWeight="Bold" Height="60" HorizontalAlignment="Left" Margin="480,41,0,0" Name="btnPing" VerticalAlignment="Top" Width="68" Background="Black" FontFamily="Consolas" Foreground="Orange" Opacity="0.75" FontSize="12"></Button>
        <Label Content="IP Address:" Height="28" HorizontalAlignment="Left" Margin="557,247,0,0" Name="label3" VerticalAlignment="Top" Width="86" Background="Black" BorderBrush="Orange" BorderThickness="1" FontFamily="Consolas" Foreground="Orange" Opacity="0.75" FontSize="12" />
        <TextBox Height="28" HorizontalAlignment="Left" Margin="649,247,0,0" Name="tbIPAddress" VerticalAlignment="Top" Width="308" BorderBrush="Yellow" FontFamily="Consolas" Background="Black" Foreground="Yellow" Opacity="0.75" FontSize="12" />
        <Button Background="Black" BorderBrush="Orange" Content="Exit" FontWeight="Bold" Height="35" HorizontalAlignment="Left" Margin="859,0,0,0" Name="btnExit" VerticalAlignment="Top" Width="98" FontFamily="Consolas" Foreground="Orange" Opacity="0.75" FontSize="12" />
        <ListBox Background="Black" BorderBrush="Orange" FontFamily="Consolas" FontSize="12" Foreground="Orange" Height="192" HorizontalAlignment="Left" Margin="74,357,0,0" Name="lstProcess" Opacity="0.75" Padding="15" VerticalAlignment="Top" Width="400" Focusable="True" />
        <Label Background="Black" BorderBrush="Orange" BorderThickness="2" Content="Get-Process" FontFamily="Consolas" FontSize="18" Foreground="Orange" Height="35" HorizontalAlignment="Left" Margin="0,316,0,0" Name="label4" Opacity="0.75" VerticalAlignment="Top" Width="474" />
        <Button Background="Black" BorderBrush="Orange" Content="Refresh" FontFamily="Consolas" FontSize="12" FontWeight="Bold" Foreground="Orange" Height="60" HorizontalAlignment="Left" Margin="0,357,0,0" Name="btnRefreshGetProcess" Opacity="0.75" VerticalAlignment="Top" Width="68" />
        <Label Background="Black" BorderBrush="Orange" BorderThickness="1" Content="Times to ping:" FontFamily="Consolas" FontSize="12" Foreground="Orange" Height="28" HorizontalAlignment="Left" Margin="557,281,0,0" Name="label5" Opacity="0.75" VerticalAlignment="Top" Width="103" />
        <TextBox Background="Black" BorderBrush="Yellow" FontFamily="Consolas" FontSize="12" Foreground="Yellow" Height="28" HorizontalAlignment="Left" Margin="666,282,0,0" Name="tbPingAmount" Opacity="0.75" VerticalAlignment="Top" Width="83" />
        <Button Background="Black" BorderBrush="Orange" Content="Ping" FontFamily="Consolas" FontSize="12" FontWeight="Bold" Foreground="Orange" Height="28" HorizontalAlignment="Left" Margin="755,282,0,0" Name="btnPing2" Opacity="0.75" VerticalAlignment="Top" Width="98" />
        <Button Background="Black" BorderBrush="Orange" Content="To HTML" FontFamily="Consolas" FontSize="12" FontWeight="Bold" Foreground="Orange" Height="60" HorizontalAlignment="Left" Margin="0,107,0,0" Name="btnToHTMLipconfig" Opacity="0.75" VerticalAlignment="Top" Width="68" />
        <Button Background="Black" BorderBrush="Orange" Content="To HTML" FontFamily="Consolas" FontSize="12" FontWeight="Bold" Foreground="Orange" Height="60" HorizontalAlignment="Left" Margin="480,107,0,0" Name="btnToHTMLPing" Opacity="0.75" VerticalAlignment="Top" Width="68" />
        <Button Background="Black" BorderBrush="Orange" Content="To HTML" FontFamily="Consolas" FontSize="12" FontWeight="Bold" Foreground="Orange" Height="60" HorizontalAlignment="Left" Margin="0,423,0,0" Name="btnToHTMLGetProcess" Opacity="0.75" VerticalAlignment="Top" Width="68" />
        <Button Background="Black" BorderBrush="Orange" Content="Minimize" FontFamily="Consolas" FontSize="12" FontWeight="Bold" Foreground="Orange" Height="35" HorizontalAlignment="Left" Margin="755,0,0,0" Name="btnMinimize" Opacity="0.75" VerticalAlignment="Top" Width="98" />
        <TextBox Background="Black" BorderBrush="Yellow" FontFamily="Consolas" FontSize="12" Foreground="Yellow" Height="28" HorizontalAlignment="Left" Margin="154,555,0,0" Name="tbStopProcess" Opacity="0.75" VerticalAlignment="Top" Width="320" ToolTip="Enter process name to stop" />
        <TextBox Background="Black" BorderBrush="Yellow" FontFamily="Consolas" FontSize="12" Foreground="Yellow" Height="28" HorizontalAlignment="Left" Margin="154,589,0,0" Name="tbStartProcess" Opacity="0.75" VerticalAlignment="Top" Width="320" ToolTip="Enter process name to start" />
        <Button Background="Black" BorderBrush="Orange" Content="Stop" FontFamily="Consolas" FontSize="12" FontWeight="Bold" Foreground="Orange" Height="28" HorizontalAlignment="Left" Margin="74,555,0,0" Name="btnStopProcess" Opacity="0.75" VerticalAlignment="Top" Width="74" />
        <Button Background="Black" BorderBrush="Orange" Content="Start" FontFamily="Consolas" FontSize="12" FontWeight="Bold" Foreground="Orange" Height="28" HorizontalAlignment="Left" Margin="74,589,0,0" Name="btnStartProcess" Opacity="0.75" VerticalAlignment="Top" Width="74" />
        <TextBox Background="Black" BorderBrush="Yellow" FontFamily="Consolas" FontSize="12" Foreground="Yellow" Height="28" HorizontalAlignment="Right" Margin="0,282,483,0" Name="tbStaticIPGateway" Opacity="0.75" VerticalAlignment="Top" Width="128" />
        <TextBox Background="Black" BorderBrush="Yellow" FontFamily="Consolas" FontSize="12" Foreground="Yellow" Height="28" HorizontalAlignment="Left" Margin="346,247,0,0" Name="tbStaticIPAddress" Opacity="0.75" VerticalAlignment="Top" Width="128" />
        <Button Background="Black" BorderBrush="Orange" Content="Static" FontFamily="Consolas" FontSize="12" FontWeight="Bold" Foreground="Orange" Height="62" HorizontalAlignment="Left" Margin="0,247,0,0" Name="btnStaticIP" Opacity="0.75" VerticalAlignment="Top" Width="68" />
        <Button Background="Black" BorderBrush="Orange" Content="Dynamic" FontFamily="Consolas" FontSize="12" FontWeight="Bold" Foreground="Orange" Height="68" HorizontalAlignment="Left" Margin="0,173,0,0" Name="btnDynamicIP" Opacity="0.75" VerticalAlignment="Top" Width="68" />
        <TextBox Background="Black" BorderBrush="Yellow" FontFamily="Consolas" FontSize="12" Foreground="Yellow" Height="28" HorizontalAlignment="Left" Margin="122,247,0,0" Name="tbStaticIPName" Opacity="0.75" VerticalAlignment="Top" Width="149" />
        <TextBox Background="Black" BorderBrush="Yellow" FontFamily="Consolas" FontSize="12" Foreground="Yellow" Height="28" HorizontalAlignment="Right" Margin="0,281,686,0" Name="tbStaticIPMask" Opacity="0.75" VerticalAlignment="Top" Width="149" />
        <Label Background="Black" BorderBrush="Orange" BorderThickness="1" Content="Name:" FontFamily="Consolas" FontSize="12" Foreground="Orange" Height="28" HorizontalAlignment="Left" Margin="74,247,0,0" Name="label6" Opacity="0.75" VerticalAlignment="Top" Width="42" />
        <Label Background="Black" BorderBrush="Orange" BorderThickness="1" Content="Address:" FontFamily="Consolas" FontSize="12" Foreground="Orange" Height="28" HorizontalAlignment="Left" Margin="277,247,0,0" Name="label7" Opacity="0.75" VerticalAlignment="Top" Width="63" />
        <Label Background="Black" BorderBrush="Orange" BorderThickness="1" Content="Mask:" FontFamily="Consolas" FontSize="12" Foreground="Orange" Height="28" HorizontalAlignment="Left" Margin="74,281,0,0" Name="label8" Opacity="0.75" VerticalAlignment="Top" Width="42" />
        <Label Background="Black" BorderBrush="Orange" BorderThickness="1" Content="Gateway:" FontFamily="Consolas" FontSize="12" Foreground="Orange" Height="28" HorizontalAlignment="Left" Margin="277,282,0,0" Name="label9" Opacity="0.75" VerticalAlignment="Top" Width="63" />
        <Button Background="Black" BorderBrush="Orange" Content="Tracert" FontFamily="Consolas" FontSize="12" FontWeight="Bold" Foreground="Orange" Height="28" HorizontalAlignment="Left" Margin="859,282,0,0" Name="btnTracert" Opacity="0.75" VerticalAlignment="Top" Width="98" ToolTip="Warning: May take awhile to complete" />
        <Button Background="Black" BorderBrush="Orange" FontFamily="Consolas" FontSize="10" FontWeight="Bold" Foreground="Orange" Height="62" Margin="480,247,409,0" Name="btnBuildWebsite" Opacity="0.75" VerticalAlignment="Top" Content="To Website" FontStretch="Normal" />
        <ListBox Background="Black" BorderBrush="Orange" Focusable="True" FontFamily="Consolas" FontSize="12" Foreground="Orange" Height="192" HorizontalAlignment="Left" Margin="557,357,0,0" Name="lbxUpdateStatus" Opacity="0.75" Padding="15" VerticalAlignment="Top" Width="400" />
        <Label Background="Black" BorderBrush="Orange" BorderThickness="2" Content="Windows Update Status" FontFamily="Consolas" FontSize="18" Foreground="Orange" Height="35" HorizontalAlignment="Left" Margin="483,316,0,0" Name="label10" Opacity="0.75" VerticalAlignment="Top" Width="474" />
        <Button Background="Black" BorderBrush="Orange" Content="Refresh" FontFamily="Consolas" FontSize="12" FontWeight="Bold" Foreground="Orange" Height="60" HorizontalAlignment="Left" Margin="483,357,0,0" Name="btnUpdateStatusRefresh" Opacity="0.75" VerticalAlignment="Top" Width="68" />
        <Button Background="Black" BorderBrush="Orange" Content="To HTML" FontFamily="Consolas" FontSize="12" FontWeight="Bold" Foreground="Orange" Height="60" HorizontalAlignment="Left" Margin="483,423,0,0" Name="btnUpdateStatusHTML" Opacity="0.75" VerticalAlignment="Top" Width="68" />
        <Grid.Background>
            <SolidColorBrush />
        </Grid.Background>
    </Grid>
    <Window.Background>
        <SolidColorBrush />
    </Window.Background>
</Window>
'@
#Read XAML
$reader=(New-Object System.Xml.XmlNodeReader $xaml)

#Load XAML GUI into $form
$form=[Windows.Markup.XamlReader]::Load( $reader ) 

#Connect objects to form controls(remote controls)

#List Boxes ###################################
$lstIpconfig = $form.FindName('lstIpconfig')
$lstPing = $form.FindName('lstPing')
$lstProcess = $form.FindName('lstProcess')
###############################################

#Buttons ######################################
$btnExit = $form.FindName('btnExit')
$btnPing = $form.FindName('btnPing')
$btnPing2 = $form.FindName('btnPing2')
$btnMinimize = $form.FindName('btnMinimize')
$btnRefreshIpconfig = $form.FindName('btnRefreshIpconfig')
$btnRefreshGetProcess = $form.FindName('btnRefreshGetProcess')
$btnToHTMLipconfig = $form.FindName('btnToHTMLipconfig')
$btnToHTMLPing = $form.FindName('btnToHTMLPing')
$btnToHTMLGetProcess = $form.FindName('btnToHTMLGetProcess')
$btnStopProcess = $form.FindName('btnStopProcess')
$btnStartProcess = $form.FindName('btnStartProcess')
$btnStaticIP = $form.FindName('btnStaticIP')
$btnDynamicIP = $form.FindName('btnDynamicIP')
$btnTracert = $form.FindName('btnTracert')
$btnBuildWebsite = $form.FindName('btnBuildWebsite')
################################################

#Text Boxes ####################################
$tbIPAddress = $form.FindName('tbIPAddress')
$tbPingAmount = $form.FindName('tbPingAmount')
$tbStopProcess = $form.FindName('tbStopProcess')
$tbStartProcess = $form.FindName('tbStartProcess')
$tbStaticIPAddress = $form.FindName('tbStaticIPAddress')
$tbStaticIPMask = $form.FindName('tbStaticIPMask')
$tbStaticIPName = $form.FindName('tbStaticIPName')
$tbStaticIPGateway = $form.FindName('tbStaticIPGateway')
################################################

#CSS and html ##################################
$mainCSS = "

/*  Author: Joseph Stant
    Date: 11/3/2012
    Note: Main css sheet for this computer status website
*/    

* {
  padding:0;
  margin:0;
}

html{
    background-color:gray;
  }
body {
  margin:15px auto;
  background-color:white;
  width:500px;
  border:2px solid black;
  box-shadow: 3px 3px 16px 4px black;
}
Section {
  text-align:center;
  width:170px;
  margin: 15px auto;
}
section h2 {
  padding-bottom:15px;
}
ul {
  width:170px;
  list-style:none;
}
li {
  text-decoration:none;
  border: 2px solid black;
  margin-bottom:15px;
}
li a {
  display:block;
  text-decoration:none;
  color:black;
  padding:15px 0 15px 0;
  
}
header {
  background-color:black;
  color:orange;
  padding:15px;
  text-align:center;
  border-bottom:2px solid black;
}    
footer {
  background-color:black;
  color:orange;
  padding:15px;
  text-align:center;
  border-top:2px solid black;
}

li a:hover, a:focus{ 
  background-color:black;
  color:orange;
  box-shadow: 2px 2px 16px 2px orange;

}
"
$tableCSS = "
/*  Author: Joseph Stant
    Date: 11/3/2012
    Note: Main css sheet for this computer status website
*/    
    * {
    margin:0;
    padding:0;
    }
  html{
    background-color:gray;
  }
body {
  margin:15px auto;
  background-color:white;
  width:500px;
  border:2px solid black;
  box-shadow: 3px 3px 16px 4px black;
}
body h2 {
    text-align:center;
    }

Section {
  text-align:center;
  width:170px;
  margin: 15px auto;
}
section h2 {
  padding-bottom:15px;
}
ul {
  width:170px;
  list-style:none;
}
li {
  text-decoration:none;
  border: 2px solid black;
  margin-bottom:15px;
}
li a {
  display:block;
  text-decoration:none;
  color:black;
  padding:15px 0 15px 0;
  
}
header {
  background-color:black;
  color:orange;
  padding:15px;
  text-align:center;
  border-bottom:2px solid black;
}    
footer {
  background-color:black;
  color:orange;
  padding:15px;
  text-align:center;
  border-top:2px solid black;
}

li a:hover, a:focus{ 
  background-color:black;
  color:orange;
  box-shadow: 2px 2px 16px 2px orange;

}
  table {
      background-color:white;
      margin: 15px auto;
      border:2px solid black;
      border-collapse:collapse;
      box-shadow: 3px 3px 16px 4px gray;
  }
  th {
      background-color:Black;
      color:orange; 

    }
  th, td {
      border:1px solid black;
      padding:5px;
  }

"
$htmlHead = '
<!--
  Author: Joseph Stant
  Date: 11/3/2012
  Notes: Worked on head css link
  -->
  <meta charset="utf-8"/>
  <title>PC Status</title>
  <link type="text/css" rel="stylesheet" href="../styles/table.css">
'
$htmlBody = '
  <header>
    <hgroup>
      <h1>PC Status</h1>  
    </hgroup>
  </header>
  <section>
    <h2>Click for details</h2>  
    <nav>
      <ul>
        <li><a href="../status/ipconfig.html">ipconfig</a></li>
      </ul>
      <ul>
        <li><a href="../status/ping.html">ping</a></li>
      </ul>
      <ul>
        <li><a href="../status/GetProcess.html">Get-Process</a></li>
      </ul>
    </nav>
  </section>
  '
$htmlIndex = '
<!DOCTYPE HTML>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>PC Status</title>
  <link rel="stylesheet" href="styles/main.css">
</head>
<body>
  <header>
    <hgroup>
      <h1>PC Status</h1>  
    </hgroup>
  </header>
  <section>
    <h2>Click for details</h2>  
    <nav>
      <ul>
        <li><a href="status/ipconfig.html">ipconfig</a></li>
      </ul>
      <ul>
        <li><a href="status/ping.html">ping</a></li>
      </ul>
      <ul>
        <li><a href="status/GetProcess.html">Get-Process</a></li>
      </ul>
    </nav>
  </section>
  <footer>
    <p>By: Joseph Stants</p>
  </footer>
</body>
</html>
'
###############################################

#Default setup and storage######################
$tbIPAddress.Text = "www.google.com"
$tbPingAmount.Text = "4"
$ping = ping $tbIPAddress.Text -n $tbPingAmount.Text
$ipconfig = ipconfig
#get process where cpu time usage is greater than 1 sort by cpu in decending order and select name,ID,CPU, and WS format it conver it to a string and store it in a variable
$getProcess = Get-Process * | Where-Object { $_.cpu -gt 1 } | Sort-Object cpu -Descending | Select-Object name,ID,CPU,WS | Format-table -AutoSize | Out-String
#Defaults for static ip boxes
$tbStaticIPName.Text = "Local Area Connection"
$tbStaticIPAddress.Text = "192.168.1.123"
$tbStaticIPMask.Text = "255.255.255.0"
$tbStaticIPGateway.Text = "192.168.1.1"


#Populate the list boxes#######################
#Populate the ipconfig list box
foreach ($item in ($ipconfig))
{
    $lstIpconfig.Items.Add($item)
}
#Populate the ping list box
foreach ($item in ($ping))
{
    $lstPing.Items.Add($item)
}
#Populate the process list Box
foreach ($item in ($getProcess))
{
    $lstProcess.Items.Add($Item)
}
###############################################

#Functions ####################################
function do_ping
{
    $ping = ping $tbIPAddress.text -n $tbPingAmount.Text
    $lstPing.Items.Clear()
    foreach ($item in ($ping))
    {
        $lstPing.Items.Add($item)
    }
}
function do_ipconfig
{
    $ipconfig = ipconfig
    $lstIpconfig.Items.Clear()
    foreach ($item in ($ipconfig))
    {
        $lstIpconfig.Items.Add($item)
    }
}
function do_getProcess
{
  $getProcess = Get-Process * | Where-Object { $_.cpu -gt 1 } | Sort-Object cpu -Descending | Select-Object name,ID,CPU,WS | Format-table -AutoSize | Out-String  
  $lstProcess.Items.Clear()  
    foreach ($item in ($getProcess))
    {
        $lstProcess.Items.Add($Item)
    }
}
function do_ToHTMLipconfig
{
    $ipconfigLines=@() #not sure what @() means
    #Found this foreach while googeling it was used to take a text file and turn it into html
    #Figured thats roughly what I need to do with ipconfig as its current object properties do not work(do not contain the actual data)
    foreach ($line in $ipconfig){
        $myCustomObject=new-object -TypeName PSObject
        Add-Member -InputObject $MyCustomObject -Type NoteProperty -Name Log -Value $Line
        $ipconfigLines += $myCustomObject
        }
    $ipconfigLines | ConvertTo-Html -Head $htmlHead -Body "$htmlBody <h2>ipconfig</h2>" | Set-Content C:\pcStatusWebSite\status\ipconfig.html
}
function do_ToHTMLPing
{
    $ping = ping $tbIPAddress.text -n $tbPingAmount.Text   
    #needed a custom object to parse correctly to convertTo-HTML
    $pingLines=@()
    foreach ($line in $ping){
        $myCustomObject=new-object -TypeName PSObject
        Add-Member -InputObject $MyCustomObject -Type NoteProperty -Name Log -Value $Line
        $pingLines += $myCustomObject
        }
    $pingLines | ConvertTo-Html -Head $htmlHead -Body "$htmlBody <h2>ping</h2>" | Set-Content C:\pcStatusWebSite\status\ping.html
}
function do_ToHTMLGetProcess
{
    Get-Process * | Where-Object { $_.cpu -gt 1 } | Sort-Object cpu -Descending | Select-Object name,ID,CPU,WS | ConvertTo-Html -Head $htmlHead -Body "$htmlBody <h2>Get-Process</h2>"| Set-Content C:\pcStatusWebSite\status\GetProcess.html
}
function do_StopProcess
{
    Stop-Process -Name $tbStopProcess.Text
}
function do_StartProcess
{
    Start-Process $tbStartProcess.Text
}
function do_SetStaticIP
{
    Netsh interface ip set address name= $tbStaticIPName.Text source=static addr= $tbStaticIPAddress.Text mask= $tbStaticIPMask.Text gateway= $tbStaticIPGateway.text gwmetric=1
}
function do_SetDynamicIP
{
    Netsh interface ip set address name="Local Area Connection" source=dhcp
}
function do_Tracert
{
    $tracert = tracert $tbIPAddress.Text
    $lstPing.Items.Clear()
    foreach ($item in $tracert){
    $lstPing.Items.Add($item)
    }
}
# old
# function do_BuildWebsite {
#     del -force -r ~\Desktop\pcStatusWebSite
#     mkdir ~\Desktop\pcStatusWebSite\styles
#     mkdir ~\Desktop\pcStatusWebSite\status
#     new-item ~\Desktop\pcStatusWebSite\index.html -ItemType file
#     new-item ~\Desktop\pcStatusWebSite\styles\main.css -ItemType file 
#     new-item ~\Desktop\pcStatusWebSite\styles\table.css -ItemType file
#     set-content ~\Desktop\pcStatusWebSite\styles\main.css $mainCSS
#     set-content ~\Desktop\pcStatusWebSite\styles\table.css $tableCSS
#     Set-Content ~\Desktop\pcStatusWebSite\index.html $htmlIndex
#     do_ToHTMLGetProcess
#     do_ToHTMLipconfig
#     do_ToHTMLPing
# }
function do_BuildWebsite {
    del -force -r C:\pcStatusWebSite
    mkdir C:\pcStatusWebSite\styles
    mkdir C:\pcStatusWebSite\status
    new-item C:\pcStatusWebSite\index.html -ItemType file
    new-item C:\pcStatusWebSite\styles\main.css -ItemType file 
    new-item C:\pcStatusWebSite\styles\table.css -ItemType file
    set-content C:\pcStatusWebSite\styles\main.css $mainCSS
    set-content C:\pcStatusWebSite\styles\table.css $tableCSS
    Set-Content C:\pcStatusWebSite\index.html $htmlIndex
    do_ToHTMLGetProcess
    do_ToHTMLipconfig
    do_ToHTMLPing
}
################################################


#Form/Window/Button Events #####################
#Bring the window to the foreground
$form.Activate()

#Adding transparency and removing borders broke my ability to move the window
#so I had to add this event handler to move the window.

$dragWindow = [windows.Input.MouseButtonEventHandler]{$this.DragMove()}

#When the form is clicked down on, allow it to be draged
$form.Add_MouseDown($dragWindow)

#Ping on click
$btnPing.add_click({do_ping})
$btnPing2.add_click({do_ping})

#refresh on click
$btnRefreshIpconfig.add_click({do_ipconfig})
$btnRefreshGetProcess.add_click({do_getProcess})

#HTML on click
$btnToHTMLGetProcess.add_click({do_ToHTMLGetProcess})
$btnToHTMLPing.add_click({do_ToHTMLPing})
$btnToHTMLipconfig.add_click({do_ToHTMLipconfig})

#Start or Stop Process on click
$btnStopProcess.add_click({do_StopProcess})
$btnStartProcess.add_click({do_StartProcess})

#set static/dynamic IP on click
$btnStaticIP.add_click({do_SetStaticIP})
$btnDynamicIP.add_click({do_SetDynamicIP})

#tracert on click
$btnTracert.add_click({do_Tracert})

#build website on click
$btnBuildWebsite.add_click({do_BuildWebsite})

#minimize on button click
$btnMinimize.add_click({$form.WindowState = "minimized"})

#exit on button click
$btnExit.add_click({$form.Close()})

#display the form
$form.ShowDialog() | out-null
##############################################################################