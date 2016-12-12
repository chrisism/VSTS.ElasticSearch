# ElasticSearch Tools (VSTS task)

VSTS tasks for configuring ElasticSearch and installing plugins.

Are these VSTS extensions helping you? 

[![](https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=BSMTZP9VKP8QN)

### Details
With these tasks you can configure your ElasticSearch cluster by altering the configuration file. Also supports installing new plugins.

## Available tasks
### Configuration
Configure your ElasticSearch servers.
Elasticsearch configuration files can be found under ES_HOME/config folder. The folder comes with two files, the elasticsearch.yml for configuring Elasticsearch different modules, and logging.yml for configuring the Elasticsearch logging.
The configuration format is YAML.

#### Available options
* **ElasticSearch path:** The location of where ElasticSearch is installed. Example: C:\\ProgramData\\chocolatey\\lib\\elastic\\tools\\elasticsearch-1.5.1
* **Service name:** The name of the service instance of ElasticSearch.
* **Cluster name:** The name of the cluster.
* **Node name:** The name for the node.
* **Master node:** Allow this node to be eligible as a master node (enabled by default).
* **Store data:** Allow this node to store data (enabled by default).
* **Data folder:** Path to directory where to store index data allocated for this node.
* **Amount of shards:** Set the number of shards (splits) of an index.
* **Amount of replicas:** Set the number of replicas (additional copies) of an index.
* **IP address:** Elasticsearch, by default, binds itself to the 0.0.0.0 address, and listens on port [9200-9300] for HTTP traffic and on port [9300-9400] for node-to-node communication. (the range means that if the port is busy, it will automatically try the next port).
* **Port:** Elasticsearch, by default, binds itself to the 0.0.0.0 address, and listens on port [9200-9300] for HTTP traffic and on port [9300-9400] for node-to-node communication. (the range means that if the port is busy, it will automatically try the next port).
* **TCP Port:** Elasticsearch, by default, binds itself to the 0.0.0.0 address, and listens on port [9200-9300] for HTTP traffic and on port [9300-9400] for node-to-node communication. (the range means that if the port is busy, it will automatically try the next port).
* **Use HTTP compression:** Use http compression server side.
* **Unicast hosts:** Other hosts ElasticSearch should check to discover more nodes. Example: \"host1\", \"host2:port"
* **Minimum amount of master nodes:** This setting tells Elasticsearch to not elect a master unless there are enough master-eligible nodes available. Only then will an election take place. This setting should always be configured to a quorum (majority) of your master-eligible nodes. A quorum is (number of master-eligible nodes / 2) + 1
* **Rejoin when Master gone:** Try to rejoin first when the master is gone, before declaring self as master.
* **Enable multicast:** Do not use in production!

### Install Plugin
Installs a plugin in ElasticSearch.
Plugins are a way to enhance the basic elasticsearch functionality in a custom manner. They range from adding custom mapping types, custom analyzers (in a more built in fashion), native scripts, custom discovery and more.

#### Available options
* **ElasticSearch path:** The location of where ElasticSearch is installed. Example: C:\\ProgramData\\chocolatey\\lib\\elastic\\tools\\elasticsearch-1.5.1
* **Plugin name:** The name of the plugin.
* **Version:** Version of the plugin. Leave empty if latests.
* **Custom URL:** A plugin can also be downloaded directly from a custom location by specifying the URL. Leave empty if using default online location.
