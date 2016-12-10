param (
	[string]$esPath,
	[string]$pluginName,	
	[string]$pluginVersion,
	[string]$pluginUrl
)

Write-Host "Installing $pluginName as plugin for ElasticSearch"

$pathExists = Test-Path $esPath
if ($pathExists -eq $False){
	Write-Error "Path $esPath cannot be found"
	exit
}

$java_home = [Environment]::GetEnvironmentVariable("JAVA_HOME", "Machine")
if ($java_home -eq "") {
	Write-Error "JAVA_HOME environment variable must be set!"
	exit
}

$pluginBin = "bin\plugin.bat"
$pluginPath = Join-Path $esPath $pluginBin

Write-Host "ElasticSearch location: $esPath"
Write-Host "ElasticSearch plugin: $pluginPath"

if ($pluginUrl -eq "") {

	if ($pluginVersion -eq "") {
		& $pluginPath -install $pluginName | Write-Host
	} else {
		& $pluginPath -install $pluginName/$pluginVersion | Write-Host
	}

} else {
	
	if ($pluginVersion -eq "") {
		& $pluginPath -url $pluginUrl -install $pluginName | Write-Host
	} else {
		& $pluginPath -url $pluginUrl -install $pluginName/$pluginVersion | Write-Host
	}
}