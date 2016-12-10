# ElasticSearch Tools (VSTS task)

VSTS tasks for configuring ElasticSearch and installing plugins.

### Details
With these tasks you can configure your ElasticSearch cluster by altering the
configuration file. 

## Available tasks
### Configuration
Configure your ElasticSearch servers.

#### Available options
* **Upgrade (if needed):** If already installed, it will upgrade Chocolatey if needed.

### Install Plugin
Installs a plugin in ElasticSearch.

#### Available options
* **Package:** The package ID of the package to install. Check https://chocolatey.org/ for available packages
* **Version:** Specific version of the package to install. Leave empty if you want to install the latest stable version.
