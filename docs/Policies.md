
# Custom Policies

## The following custom policies are deployed to the 'lz-canary' and 'lz' Management Groups

Display Name: ['AppService append enable HTTPS only setting to enforce HTTPS setting.'](modules/policies/definitions/policy_definition_es_append_appservice_HTTPSonly.bicep)
    description: 'Appends the AppService sites object to ensure that  HTTPS only is enabled for  server/service authentication and protects data in transit from network layer eavesdropping attacks. Please note Append does not enforce compliance use then deny.'


Display Name: ['AppService append sites with minimum TLS version to enforce.'](modules/policies/definitions/policy_definition_es_append_appservice_latesttls.bicep)
    description: 'Append the AppService sites object to ensure that min Tls version is set to required minimum TLS version. Please note Append does not enforce compliance use then deny.'


Display Name: ['Azure Cache for Redis Append and the enforcement that enableNonSslPort is disabled.'](modules/policies/definitions/policy_definition_es_append_redis_disablenonsslport.bicep)
    description: 'Azure Cache for Redis Append and the enforcement that enableNonSslPort is disabled. Enables secure server to client by enforce  minimal Tls Version to secure the connection between your database server and your client applications helps protect against \'man in the middle\' attacks by encrypting the data stream between the server and your application.
    This configuration enforces that SSL is always enabled for accessing your database server.'


Display Name: ['Azure Cache for Redis Append a specific min TLS version requirement and enforce TLS.'](modules/policies/definitions/policy_definition_es_append_redis_sslenforcement.bicep)
    description: 'Append a specific min TLS version requirement and enforce SSL on Azure Cache for Redis. Enables secure server to client by enforce  minimal Tls Version to secure the connection between your database server and your client applications helps protect against \'man in the middle\' attacks by encrypting the data stream between the server and your application.
    This configuration enforces that SSL is always enabled for accessing your database server.'


Display Name: ['Control private endpoint connections to Azure Machine Learning'](modules/policies/definitions/policy_definition_es_audit_machinelearning_privateendpointid.bicep)
    description: 'Audit private endpoints that are created in other subscriptions and/or tenants for Azure Machine Learning.'


Display Name: ['No child resources in Automation Account'](modules/policies/definitions/policy_definition_es_deny_aa_child_resources.bicep)
    description: 'This policy denies the creation of child resources on the Automation Account'


Display Name: ['Application Gateway should be deployed with WAF enabled'](modules/policies/definitions/policy_definition_es_deny_appgw_without_waf.bicep)
    description: 'This policy enables you to restrict that Application Gateways is always deployed with WAF enabled'


Display Name: ['API App should only be accessible over HTTPS'](modules/policies/definitions/policy_definition_es_deny_appserviceapiapp_http.bicep)
    description: 'Use of HTTPS ensures server/service authentication and protects data in transit from network layer eavesdropping attacks.'


Display Name: ['Function App should only be accessible over HTTPS'](modules/policies/definitions/policy_definition_es_deny_appservicefunctionapp_http.bicep)
    description: 'Use of HTTPS ensures server/service authentication and protects data in transit from network layer eavesdropping attacks.'


Display Name: ['Web Application should only be accessible over HTTPS'](modules/policies/definitions/policy_definition_es_deny_appservicewebapp_http.bicep)
    description: 'Use of HTTPS ensures server/service authentication and protects data in transit from network layer eavesdropping attacks.'


Display Name: ['Deny public IPs for Databricks cluster'](modules/policies/definitions/policy_definition_es_deny_databricks_nopublicip.bicep)
    description: 'Denies the deployment of workspaces that do not use the noPublicIp feature to host Databricks clusters without public IPs.'


Display Name: ['Deny non-premium Databricks sku'](modules/policies/definitions/policy_definition_es_deny_databricks_sku.bicep)
    description: 'Enforces the use of Premium Databricks workspaces to make sure appropriate security features are available including Databricks Access Controls, Credential Passthrough and SCIM provisioning for AAD.'


Display Name: ['Deny Databricks workspaces without Vnet injection'](modules/policies/definitions/policy_definition_es_deny_databricks_virtualnetwork.bicep)
    description: 'Enforces the use of vnet injection for Databricks workspaces.'


Display Name: ['Deny AKS cluster creation in Azure Machine Learning'](modules/policies/definitions/policy_definition_es_deny_machinelearning_aks.bicep)
    description: 'Deny AKS cluster creation in Azure Machine Learning and enforce connecting to existing clusters.'


Display Name: ['Deny public access of Azure Machine Learning clusters via SSH'](modules/policies/definitions/policy_definition_es_deny_machinelearning_computecluster_remoteloginportpublicaccess.bicep)
    description: 'Deny public access of Azure Machine Learning clusters via SSH.'


Display Name: ['Enforce scale settings for Azure Machine Learning compute clusters'](modules/policies/definitions/policy_definition_es_deny_machinelearning_computecluster_scale.bicep)
    description: 'Enforce scale settings for Azure Machine Learning compute clusters.'


Display Name: ['Enforce subnet connectivity for Azure Machine Learning compute clusters and compute instances'](modules/policies/definitions/policy_definition_es_deny_machinelearning_compute_subnetid.bicep)
    description: 'Enforce subnet connectivity for Azure Machine Learning compute clusters and compute instances.'


Display Name: ['Limit allowed vm sizes for Azure Machine Learning compute clusters and compute instances'](modules/policies/definitions/policy_definition_es_deny_machinelearning_compute_vmsize.bicep)
    description: 'Limit allowed vm sizes for Azure Machine Learning compute clusters and compute instances.'


Display Name: ['Enforces high business impact Azure Machine Learning Workspaces'](modules/policies/definitions/policy_definition_es_deny_machinelearning_hbiworkspace.bicep)
    description: 'Enforces high business impact Azure Machine Learning workspaces.'


Display Name: ['Deny public acces behind vnet to Azure Machine Learning workspace'](modules/policies/definitions/policy_definition_es_deny_machinelearning_publicaccesswhenbehindvnet.bicep)
    description: 'Deny public access behind vnet to Azure Machine Learning workspaces.'


Display Name: ['Azure Machine Learning should have disabled public network access'](modules/policies/definitions/policy_definition_es_deny_machinelearning_publicnetworkaccess.bicep)
    description: 'Denies public network access for Azure Machine Learning workspaces.'


Display Name: ['MySQL database servers enforce SSL connections.'](modules/policies/definitions/policy_definition_es_deny_mysql_http.bicep)
    description: 'Azure Database for MySQL supports connecting your Azure Database for MySQL server to client applications using Secure Sockets Layer (SSL). Enforcing SSL connections between your database server and your client applications helps protect against \'man in the middle\' attacks by encrypting the data stream between the server and your application.
    This configuration enforces that SSL is always enabled for accessing your database server.'


Display Name: ['PostgreSQL database servers enforce SSL connection.'](modules/policies/definitions/policy_definition_es_deny_postgresql_http.bicep)
    description: 'Azure Database for PostgreSQL supports connecting your Azure Database for PostgreSQL server to client applications using Secure Sockets Layer (SSL). Enforcing SSL connections between your database server and your client applications helps protect against \'man in the middle\' attacks by encrypting the data stream between the server and your application.
     This configuration enforces that SSL is always enabled for accessing your database server.'


Display Name: ['Deny the creation of private DNS'](modules/policies/definitions/policy_definition_es_deny_private_dns_zones.bicep)
    description: 'This policy denies the creation of a private DNS in the current scope, used in combination with policies that create centralized private DNS in connectivity subscription'


Display Name: ['Public network access should be disabled for MariaDB'](modules/policies/definitions/policy_definition_es_deny_publicendpoint_mariadb.bicep)
    description: 'This policy denies the creation of Maria DB accounts with exposed public endpoints'


Display Name: ['Deny the creation of public IP'](modules/policies/definitions/policy_definition_es_deny_publicip.bicep)
    description: 'This policy denies creation of Public IPs under the assigned scope.'


Display Name: ['RDP access from the internet should be blocked'](modules/policies/definitions/policy_definition_es_deny_rdp_from_internet.bicep)
    description: 'This policy denies any network security rule that allows RDP access from internet'


Display Name: ['Azure Cache for Redis only secure connections should be enabled'](modules/policies/definitions/policy_definition_es_deny_redis_http.bicep)
    description: 'Audit enabling of only connections via SSL to Azure Cache for Redis. Validate both minimum TLS version and enableNonSslPort is disabled. Use of secure connections ensures authentication between the server and the service and protects data in transit from network layer attacks such as man-in-the-middle, eavesdropping, and session-hijacking'


Display Name: ['SQL Managed Instance should have the minimal TLS version set to the highest version'](modules/policies/definitions/policy_definition_es_deny_sqlmi_mintls.bicep)
    description: 'Setting minimal TLS version to 1.2 improves security by ensuring your SQL Managed Instance can only be accessed from clients using TLS 1.2. Using versions of TLS less than 1.2 is not reccomended since they have well documented security vunerabilities.'


Display Name: ['Azure SQL Database should have the minimal TLS version set to the highest version'](modules/policies/definitions/policy_definition_es_deny_sql_mintls.bicep)
    description: 'Setting minimal TLS version to 1.2 improves security by ensuring your Azure SQL Database can only be accessed from clients using TLS 1.2. Using versions of TLS less than 1.2 is not reccomended since they have well documented security vunerabilities.'


Display Name: ['Storage Account set to minimum TLS and Secure transfer should be enabled'](modules/policies/definitions/policy_definition_es_deny_storage_mintls.bicep)
    description: 'Audit requirement of Secure transfer in your storage account. Secure transfer is an option that forces your storage account to accept requests only from secure connections (HTTPS). Use of HTTPS ensures authentication between the server and the service and protects data in transit from network layer attacks such as man-in-the-middle, eavesdropping, and session-hijacking'


Display Name: ['Subnets should have a Network Security Group'](modules/policies/definitions/policy_definition_es_deny_subnet_without_nsg.bicep)
    description: 'This policy denies the creation of a subnet without a Network Security Group. NSG help to protect traffic across subnet-level.'


Display Name: ['Subnets should have a User Defined Route'](modules/policies/definitions/policy_definition_es_deny_subnet_without_udr.bicep)
    description: 'This policy denies the creation of a subnet without a User Defined Route (UDR).'


Display Name: ['Deny vNet peering '](modules/policies/definitions/policy_definition_es_deny_vnet_peering.bicep)
    description: 'This policy denies the creation of vNet Peerings under the assigned scope.'


Display Name: ['Deny vNet peering to non-approved vNets'](modules/policies/definitions/policy_definition_es_deny_vnet_peering_to_non_approved_vnets.bicep)
    description: 'This policy denies the creation of vNet Peerings to non-approved vNets under the assigned scope.'


Display Name: ['Deny vNet peering cross subscription.'](modules/policies/definitions/policy_definition_es_deny_vnet_peer_cross_sub.bicep)
    description: 'This policy denies the creation of vNet Peerings outside of the same subscriptions under the assigned scope.'


Display Name: ['Deploy Azure Security Center Security Contacts'](modules/policies/definitions/policy_definition_es_deploy_asc_securitycontacts.bicep)
    description: 'Deploy Azure Security Center Security Contacts'


Display Name: ['Deploy a default budget on all subscriptions under the assigned scope'](modules/policies/definitions/policy_definition_es_deploy_budget.bicep)
    description: 'Deploy a default budget on all subscriptions under the assigned scope'


Display Name: ['Deploy a route table with specific user defined routes'](modules/policies/definitions/policy_definition_es_deploy_custom_route_table.bicep)
    description: 'Deploys a route table with specific user defined routes when one does not exist. The route table deployed by the policy must be manually associated to subnet(s)'


Display Name: ['Deploy an Azure DDoS Protection Standard plan'](modules/policies/definitions/policy_definition_es_deploy_ddosprotection.bicep)
    description: 'Deploys an Azure DDoS Protection Standard plan'


Display Name: ['Deploy Diagnostic Settings for Automation to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_aa.bicep)
    description: 'Deploys the diagnostic settings for Automation to stream to a Log Analytics workspace when any Automation which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Container Instances to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_aci.bicep)
    description: 'Deploys the diagnostic settings for Container Instances to stream to a Log Analytics workspace when any ACR which is missing this diagnostic settings is created or updated. The Policy willset the diagnostic with all metrics enabled.'


Display Name: ['Deploy Diagnostic Settings for Container Registry to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_acr.bicep)
    description: 'Deploys the diagnostic settings for Container Registry to stream to a Log Analytics workspace when any ACR which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics  enabled.'


Display Name: ['Deploy Diagnostic Settings for Analysis Services to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_analysisservice.bicep)
    description: 'Deploys the diagnostic settings for Analysis Services to stream to a Log Analytics workspace when any Analysis Services which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Azure API for FHIR to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_apiforfhir.bicep)
    description: 'Deploys the diagnostic settings for Azure API for FHIR to stream to a Log Analytics workspace when any Azure API for FHIR which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for API Management to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_apimgmt.bicep)
    description: 'Deploys the diagnostic settings for API Management to stream to a Log Analytics workspace when any API Management which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Application Gateway to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_applicationgateway.bicep)
    description: 'Deploys the diagnostic settings for Application Gateway to stream to a Log Analytics workspace when any Application Gateway which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for AVD Scaling Plans to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_avdscalingplans.bicep)
    description: 'Deploys the diagnostic settings for AVD Scaling Plans to stream to a Log Analytics workspace when any Scaling Plan which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all and categorys enabled.'


Display Name: ['Deploy Diagnostic Settings for Azure Bastion to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_bastion.bicep)
    description: 'Deploys the diagnostic settings for Azure Bastion to stream to a Log Analytics workspace when any Azure Bastion which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for CDN Endpoint to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_cdnendpoints.bicep)
    description: 'Deploys the diagnostic settings for CDN Endpoint to stream to a Log Analytics workspace when any CDN Endpoint which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Cognitive Services to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_cognitiveservices.bicep)
    description: 'Deploys the diagnostic settings for Cognitive Services to stream to a Log Analytics workspace when any Cognitive Services which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Cosmos DB to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_cosmosdb.bicep)
    description: 'Deploys the diagnostic settings for Cosmos DB to stream to a Log Analytics workspace when any Cosmos DB which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Databricks to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_databricks.bicep)
    description: 'Deploys the diagnostic settings for Databricks to stream to a Log Analytics workspace when any Databricks which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Azure Data Explorer Cluster to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_dataexplorercluster.bicep)
    description: 'Deploys the diagnostic settings for Azure Data Explorer Cluster to stream to a Log Analytics workspace when any Azure Data Explorer Cluster which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Data Factory to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_datafactory.bicep)
    description: 'Deploys the diagnostic settings for Data Factory to stream to a Log Analytics workspace when any Data Factory which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Data Lake Analytics to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_dlanalytics.bicep)
    description: 'Deploys the diagnostic settings for Data Lake Analytics to stream to a Log Analytics workspace when any Data Lake Analytics which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Event Grid subscriptions to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_eventgridsub.bicep)
    description: 'Deploys the diagnostic settings for Event Grid subscriptions to stream to a Log Analytics workspace when any Event Grid subscriptions which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Event Grid System Topic to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_eventgridsystemtopic.bicep)
    description: 'Deploys the diagnostic settings for Event Grid System Topic to stream to a Log Analytics workspace when any Event Grid System Topic which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Event Grid Topic to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_eventgridtopic.bicep)
    description: 'Deploys the diagnostic settings for Event Grid Topic to stream to a Log Analytics workspace when any Event Grid Topic which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for ExpressRoute to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_expressroute.bicep)
    description: 'Deploys the diagnostic settings for ExpressRoute to stream to a Log Analytics workspace when any ExpressRoute which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Firewall to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_firewall.bicep)
    description: 'Deploys the diagnostic settings for Firewall to stream to a Log Analytics workspace when any Firewall which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Front Door to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_frontdoor.bicep)
    description: 'Deploys the diagnostic settings for Front Door to stream to a Log Analytics workspace when any Front Door which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Azure Function App to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_function.bicep)
    description: 'Deploys the diagnostic settings for Azure Function App to stream to a Log Analytics workspace when any function app which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for HDInsight to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_hdinsight.bicep)
    description: 'Deploys the diagnostic settings for HDInsight to stream to a Log Analytics workspace when any HDInsight which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for IoT Hub to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_iothub.bicep)
    description: 'Deploys the diagnostic settings for IoT Hub to stream to a Log Analytics workspace when any IoT Hub which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Load Balancer to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_loadbalancer.bicep)
    description: 'Deploys the diagnostic settings for Load Balancer to stream to a Log Analytics workspace when any Load Balancer which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Logic Apps integration service environment to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_logicappsise.bicep)
    description: 'Deploys the diagnostic settings for Logic Apps integration service environment to stream to a Log Analytics workspace when any Logic Apps integration service environment which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for MariaDB to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_mariadb.bicep)
    description: 'Deploys the diagnostic settings for MariaDB to stream to a Log Analytics workspace when any MariaDB  which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Azure Media Service to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_mediaservice.bicep)
    description: 'Deploys the diagnostic settings for Azure Media Service to stream to a Log Analytics workspace when any Azure Media Service which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Machine Learning workspace to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_mlworkspace.bicep)
    description: 'Deploys the diagnostic settings for Machine Learning workspace to stream to a Log Analytics workspace when any Machine Learning workspace which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Database for MySQL to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_mysql.bicep)
    description: 'Deploys the diagnostic settings for Database for MySQL to stream to a Log Analytics workspace when any Database for MySQL which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Network Security Groups to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_networksecuritygroups.bicep)
    description: 'Deploys the diagnostic settings for Network Security Groups to stream to a Log Analytics workspace when any Network Security Groups which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Network Interfaces to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_nic.bicep)
    description: 'Deploys the diagnostic settings for Network Interfaces to stream to a Log Analytics workspace when any Network Interfaces which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Database for PostgreSQL to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_postgresql.bicep)
    description: 'Deploys the diagnostic settings for Database for PostgreSQL to stream to a Log Analytics workspace when any Database for PostgreSQL which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Power BI Embedded to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_powerbiembedded.bicep)
    description: 'Deploys the diagnostic settings for Power BI Embedded to stream to a Log Analytics workspace when any Power BI Embedded which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Redis Cache to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_rediscache.bicep)
    description: 'Deploys the diagnostic settings for Redis Cache to stream to a Log Analytics workspace when any Redis Cache which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Relay to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_relay.bicep)
    description: 'Deploys the diagnostic settings for Relay to stream to a Log Analytics workspace when any Relay which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for SignalR to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_signalr.bicep)
    description: 'Deploys the diagnostic settings for SignalR to stream to a Log Analytics workspace when any SignalR which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for SQL Elastic Pools to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_sqlelasticpools.bicep)
    description: 'Deploys the diagnostic settings for SQL Elastic Pools to stream to a Log Analytics workspace when any SQL Elastic Pools which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for SQL Managed Instances to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_sqlmi.bicep)
    description: 'Deploys the diagnostic settings for SQL Managed Instances to stream to a Log Analytics workspace when any SQL Managed Instances which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Time Series Insights to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_timeseriesinsights.bicep)
    description: 'Deploys the diagnostic settings for Time Series Insights to stream to a Log Analytics workspace when any Time Series Insights which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Traffic Manager to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_trafficmanager.bicep)
    description: 'Deploys the diagnostic settings for Traffic Manager to stream to a Log Analytics workspace when any Traffic Manager which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Virtual Network to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_virtualnetwork.bicep)
    description: 'Deploys the diagnostic settings for Virtual Network to stream to a Log Analytics workspace when any Virtual Network which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Virtual Machines to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_vm.bicep)
    description: 'Deploys the diagnostic settings for Virtual Machines to stream to a Log Analytics workspace when any Virtual Machines which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for Virtual Machine Scale Sets to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_vmss.bicep)
    description: 'Deploys the diagnostic settings for Virtual Machine Scale Sets  to stream to a Log Analytics workspace when any Virtual Machine Scale Sets  which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for VPN Gateway to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_vnetgw.bicep)
    description: 'Deploys the diagnostic settings for VPN Gateway to stream to a Log Analytics workspace when any VPN Gateway which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled.'


Display Name: ['Deploy Diagnostic Settings for App Service Plan to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_webserverfarm.bicep)
    description: 'Deploys the diagnostic settings for App Service Plan to stream to a Log Analytics workspace when any App Service Plan which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for App Service to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_website.bicep)
    description: 'Deploys the diagnostic settings for Web App to stream to a Log Analytics workspace when any Web App which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'


Display Name: ['Deploy Diagnostic Settings for AVD Application group to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_wvdappgroup.bicep)
    description: 'Deploys the diagnostic settings for AVD Application group to stream to a Log Analytics workspace when any application group which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all and categorys enabled.'


Display Name: ['Deploy Diagnostic Settings for AVD Host Pools to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_wvdhostpools.bicep)
    description: 'Deploys the diagnostic settings for AVD Host Pools to stream to a Log Analytics workspace when any Host Pools which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all and categorys enabled.'


Display Name: ['Deploy Diagnostic Settings for AVD Workspace to Log Analytics workspace'](modules/policies/definitions/policy_definition_es_deploy_diagnostics_wvdworkspace.bicep)
    description: 'Deploys the diagnostic settings for AVD Workspace to stream to a Log Analytics workspace when any Workspace which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all and categorys enabled.'


Display Name: ['Deploy Azure Firewall Manager policy in the subscription'](modules/policies/definitions/policy_definition_es_deploy_firewallpolicy.bicep)
    description: 'Deploys Azure Firewall Manager policy in subscription where the policy is assigned.'


Display Name: ['Azure Database for MySQL server deploy a specific min TLS version and enforce SSL.'](modules/policies/definitions/policy_definition_es_deploy_mysql_sslenforcement.bicep)
    description: 'Deploy a specific min TLS version requirement and enforce SSL on Azure Database for MySQL server. Enforce the Server to client applications using minimum version of Tls to secure the connection between your database server and your client applications helps protect against \'man in the middle\' attacks by encrypting the data stream between the server and your application.
    This configuration enforces that SSL is always enabled for accessing your database server.'


Display Name: ['Deploys NSG flow logs and traffic analytics'](modules/policies/definitions/policy_definition_es_deploy_nsg_flowlogs.bicep)
    description: 'Deploys NSG flow logs and traffic analytics to a storageaccountid with a specfied retention period.'


Display Name: ['Deploys NSG flow logs and traffic analytics to Log Analytics'](modules/policies/definitions/policy_definition_es_deploy_nsg_flowlogs_to_la.bicep)
    description: 'Deploys NSG flow logs and traffic analytics to Log Analytics with a specfied retention period.'


Display Name: ['Azure Database for PostgreSQL server deploy a specific min TLS version requirement and enforce SSL '](modules/policies/definitions/policy_definition_es_deploy_postgresql_sslenforcement.bicep)
    description: 'Deploy a specific min TLS version requirement and enforce SSL on Azure Database for PostgreSQL server. Enables secure server to client by enforce  minimal Tls Version to secure the connection between your database server and your client applications helps protect against \'man in the middle\' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server.'


Display Name: ['SQL managed instances deploy a specific min TLS version requirement.'](modules/policies/definitions/policy_definition_es_deploy_sqlmi_mintls.bicep)
    description: 'Deploy a specific min TLS version requirement and enforce SSL on SQL managed instances. Enables secure server to client by enforce  minimal Tls Version to secure the connection between your database server and your client applications helps protect against \'man in the middle\' attacks by encrypting the data stream between the server and your application.
    This configuration enforces that SSL is always enabled for accessing your database server.'


Display Name: ['Deploy SQL database auditing settings'](modules/policies/definitions/policy_definition_es_deploy_sql_auditingsettings.bicep)
    description: 'Deploy auditing settings to SQL Database when it not exist in the deployment'


Display Name: ['SQL servers deploys a specific min TLS version requirement.'](modules/policies/definitions/policy_definition_es_deploy_sql_mintls.bicep)
    description: 'Deploys a specific min TLS version requirement and enforce SSL on SQL servers. Enables secure server to client by enforce  minimal Tls Version to secure the connection between your database server and your client applications helps protect against \'man in the middle\' attacks by encrypting the data stream between the server and your application.
    This configuration enforces that SSL is always enabled for accessing your database server.'


Display Name: ['Deploy SQL Database security Alert Policies configuration with email admin accounts'](modules/policies/definitions/policy_definition_es_deploy_sql_securityalertpolicies.bicep)
    description: 'Deploy the security Alert Policies configuration with email admin accounts when it not exist in current configuration'


Display Name: ['Deploy SQL Database Transparent Data Encryption '](modules/policies/definitions/policy_definition_es_deploy_sql_tde.bicep)
    description: 'Deploy the Transparent Data Encryption when it is not enabled in the deployment'


Display Name: ['Deploy SQL Database vulnerability Assessments'](modules/policies/definitions/policy_definition_es_deploy_sql_vulnerabilityassessments.bicep)
    description: 'Deploy SQL Database vulnerability Assessments when it not exist in the deployment. To the specific  storage account in the parameters'


Display Name: ['Azure Storage deploy a specific min TLS version requirement and enforce SSL/HTTPS '](modules/policies/definitions/policy_definition_es_deploy_storage_sslenforcement.bicep)
    description: 'Deploy a specific min TLS version requirement and enforce SSL on Azure Storage. Enables secure server to client by enforce minimal Tls Version to secure the connection between your database server and your client applications helps protect against \'man in the middle\' attacks by encrypting the data stream between the server and your application.
    This configuration enforces that SSL is always enabled for accessing your Azure Storage.'


Display Name: ['Deploy Virtual Network with peering to the hub'](modules/policies/definitions/policy_definition_es_deploy_vnet_hubspoke.bicep)
    description: 'This policy deploys virtual network and peer to the hub'


Display Name: ['Deploy Windows Domain Join Extension with keyvault configuration'](modules/policies/definitions/policy_definition_es_deploy_windows_domainjoin.bicep)
    description: 'Deploy Windows Domain Join Extension with keyvault configuration when the extension does not exist on a given windows Virtual Machine'
