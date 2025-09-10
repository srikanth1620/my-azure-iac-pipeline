How to update service principle credentials ? 
----------------------------------------------------------------------------

......First find out app id by 

az ad sp list --display-name "github-actions-sp" --query "[].{appId:appId, displayName:displayName, objectId:objectId}" -o table

    output
        AppId DisplayName
        130b5cbe-c92c-4b51-b6d4-0cf05e1e3775  github-actions-sp

.......Second use this cmd to display sp credentils 

    az ad sp credential reset --id 130b5cbe-c92c-4b51-b6d4-0cf05e1e3775 --append
    
    output

        {
         "appId": "",
         "password": "",
         "tenant": "550420cd-a4f2-4642-941d-ec8d931bcceb"
        }


How to verify or find out the subscription id ? 
----------------------------------------------------------------------------
    az account show --query "id" -o tsv

    output
        d142b1fc-9376-4248-93fb-7f8602c24e09

How to verify or find out the tenant id ? 
----------------------------------------------------------------------------
    az account show --query "tenantId" -o tsv

    output
        550420cd-a4f2-4642-941d-ec8d931bcceb

How to show account info ? 
----------------------------------------------------------------------------
    az account show

    output
        {
            "environmentName": "AzureCloud",
            "homeTenantId": "550420cd-a4f2-4642-941d-ec8d931bcceb",
            "id": "d142b1fc-9376-4248-93fb-7f8602c24e09",
            "isDefault": true,
            "managedByTenants": [],
            "name": "Azure subscription 1",
            "state": "Enabled",
            "tenantDefaultDomain": "srisrib.onmicrosoft.com",
            "tenantDisplayName": "Self",
            "tenantId": "550420cd-a4f2-4642-941d-ec8d931bcceb",
            "user": {
                "name": "SriSrinivasan@srisrib.onmicrosoft.com",
                "type": "user"
            }
            }

How to create service principal ? 
----------------------------------------------------------------------------
    az ad sp create-for-rbac --name "github-actions-sp" --role "Contributor" --scopes /subscriptions/d142b1fc-9376-4248-93fb-7f8602c24e09 --sdk-auth

    output
        {
            "clientId": "",
            "clientSecret": "",
            "subscriptionId": "d142b1fc-9376-4248-93fb-7f8602c24e09",
            "tenantId": "550420cd-a4f2-4642-941d-ec8d931bcceb",
            "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
            "resourceManagerEndpointUrl": "https://management.azure.com/",
            "activeDirectoryGraphResourceId": "https://graph.windows.net/",
            "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
            "galleryEndpointUrl": "https://gallery.azure.com/",
            "managementEndpointUrl": "https://management.core.windows.net/"
            }
How to show signed in user ? 
----------------------------------------------------------------------------
    az ad signed-in-user show

    output
        {
            "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#users/$entity",
            "businessPhones": [
                    "2243581599"
            ],
            "displayName": "Sri Srinivasan",
            "givenName": "Sri",
            "id": "104d0b66-ee84-4fe2-ae6c-e1a9a8f0bc31",
            "jobTitle": null,
            "mail": null,
            "mobilePhone": null,
            "officeLocation": null,
            "preferredLanguage": "en",
            "surname": "Srinivasan",
            "userPrincipalName": "SriSrinivasan@srisrib.onmicrosoft.com"
            }

How to show what permissions we have for a role ? 
----------------------------------------------------------------------------
    az role assignment list --assignee 130b5cbe-c92c-4b51-b6d4-0cf05e1e3775 --scope /subscriptions/d142b1fc-9376-4248-93fb-7f8602c24e09 -o table

    output
        Principal                             Role                       Scope
        ------------------------------------  -------------------------  ---------------------------------------------------
        130b5cbe-c92c-4b51-b6d4-0cf05e1e3775  Contributor                /subscriptions/d142b1fc-9376-4248-93fb-7f8602c24e09
        130b5cbe-c92c-4b51-b6d4-0cf05e1e3775  User Access Administrator  /subscriptions/d142b1fc-9376-4248-93fb-7f8602c24e09