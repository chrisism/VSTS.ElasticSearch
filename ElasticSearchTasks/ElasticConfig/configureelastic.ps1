param (
	[string]$esPath,
	[string]$serviceName,
	[string]$clusterName,
	[string]$nodeName,
	[string]$isMaster,
	[string]$dataStored,
	[string]$dataPath,
	[string]$hostIp,
	[string]$tcpPort,
	[string]$httpPort,
	[string]$amountShards,
	[string]$amountReplicas,
	[string]$unicasthosts,
	[string]$minimumMasters,
	[string]$rejoinMasterGone,
	[string]$useMulticast,
	[string]$useCompression
)

function Add-ConfigParameter([string]$parameterValue, $parameterName) {
	
	$configurationLine = ""
	if ($parameterValue.Trim() -ne "") {
		$configurationLine += "$parameterName : $parameterValue`r`n"
	} 

	return $configurationLine
}

function Add-ConfigParameterArray([string]$parameterValue, $parameterName) {
	
	$configurationLine = ""
	if ($parameterValue.Trim() -ne "") {
		$configurationLine += "$parameterName : [$parameterValue]`r`n"
	} 

	return $configurationLine
}

## --------------------------------------------------------------------------------------
## Check parameters and defaults
## --------------------------------------------------------------------------------------

$pathExists = Test-Path $esPath
if ($pathExists -eq $False){
	Write-Error "Path $esPath cannot be found"
	exit 1
}

$configFile = Join-Path $esPath "config\elasticsearch.yml"

Write-Host "ElasticSearch location: $esPath"
Write-Host "ElasticSearch config path: $configFile"

## --------------------------------------------------------------------------------------
## Create config file
## --------------------------------------------------------------------------------------

$configuration = ""
$configuration += Add-ConfigParameter $clusterName -parameterName "cluster.name"	
$configuration += Add-ConfigParameter $nodeName -parameterName "node.name"

$configuration += Add-ConfigParameter $isMaster.ToLower() -parameterName "node.master"
$configuration += Add-ConfigParameter $dataStored.ToLower() -parameterName "node.data"
$configuration += Add-ConfigParameter $dataPath -parameterName "path.data"	
$configuration += Add-ConfigParameter $amountShards -parameterName "index.number_of_shards"	
$configuration += Add-ConfigParameter $amountReplicas -parameterName "index.number_of_replicas"	

$configuration += Add-ConfigParameter $hostIp -parameterName "network.host"	
$configuration += Add-ConfigParameter $tcpPort -parameterName "transport.tcp.port"	
$configuration += Add-ConfigParameter $httpPort -parameterName "http.port"	
$configuration += Add-ConfigParameter $useCompression.ToLower() -parameterName "http.compression"	
$configuration += Add-ConfigParameterArray $unicasthosts -parameterName "discovery.zen.ping.unicast.hosts"	
$configuration += Add-ConfigParameter $minimumMasters -parameterName "discovery.zen.minimum_master_nodes"	
$configuration += Add-ConfigParameter $rejoinMasterGone.ToLower() -parameterName "rejoin_on_master_gone"
$configuration += Add-ConfigParameter $useMulticast.ToLower() -parameterName "discovery.zen.ping.multicast.enabled"



New-Item $configFile -type file -force -value $configuration

## --------------------------------------------------------------------------------------
## Restart Service
## --------------------------------------------------------------------------------------

$elasticService = Get-Service -Name $serviceName

if($elasticService.Status -ne "Running") {
	
	start-service $serviceName
	$elasticService.WaitForStatus('Running', '00:01:00')
	Write-Output "Started $serviceName"

} elseif ($elasticService.Status -eq "Running") {
	Restart-Service $serviceName
	Write-Output "Restarted $serviceName"
}
