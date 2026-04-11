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

How to create a simple appservice and deploy to Azure?
----------------------------------------------------------------------------
        Create a resource group in central location
        az group create --name SecureNodeAppGroup_central --location centralus

        Create a service principal with Contributor role for the subscription
        az ad sp create-for-rbac --name "secure-node-app-sp" --role Contributor --scopes /subscriptions/d142b1fc-9376-4248-93fb-7f8602c24e09 --sdk-auth

        Create an App Service plan
        az appservice plan create --name SecureNodeAppServicePlan --resource-group SecureNodeAppGroup_central --sku F1 --is-linux

        Create an App Service
        az webapp create --resource-group SecureNodeAppGroup_central --plan SecureNodeAppServicePlan --name secure-node-app-123 --runtime "NODE|18-lts"

        Zip the app for deployment
        zip -r app.zip . -x ".git/*" "*.zip"

        Deploy the app
        az webapp deployment source config-zip --resource-group SecureNodeAppGroup_central --name secure-node-app --src app.zip

        Optional: Stream logs to verify deployment
        az webapp log tail --resource-group SecureNodeAppGroup_central --name secure-node-app

        Additional Details 

            How the Service Principal Fits

                The Service Principal is used in the GitHub Actions workflow to replace manual deployment commands like:

                zip -r app.zip . -x ".git/*" "*.zip"
                az webapp deployment source config-zip --resource-group SecureNodeAppGroup_central --name secure-node-app --src app.zip

                Instead of running these manually, the workflow uses the Service Principal to authenticate and deploy the app programmatically.


How to display details of user-assigned managed identity (oidc-msi-85e5) ?
----------------------------------------------------------------------------
az identity show --resource-group SecureNodeAppGroup_central --name oidc-msi-85e5
    
        {
            "clientId": "d8a439d9-8a4e-4dce-a51d-24f2937b25bc",
            "id": "/subscriptions/d142b1fc-9376-4248-93fb-7f8602c24e09/resourcegroups/SecureNodeAppGroup_central/providers/Microsoft.ManagedIdentity/userAssignedIdentities/oidc-msi-85e5",
            "location": "centralus",
            "name": "oidc-msi-85e5",
            "principalId": "cd0be6fc-f619-49c6-8ab8-82e5f5f66970",
            "resourceGroup": "SecureNodeAppGroup_central",
            "systemData": null,
            "tags": {},
            "tenantId": "550420cd-a4f2-4642-941d-ec8d931bcceb",
            "type": "Microsoft.ManagedIdentity/userAssignedIdentities"
        }

        What It Does:
            Retrieves metadata for the specified managed identity.
            Output includes:

            clientId: d8a439d9-8a4e-4dce-a51d-24f2937b25bc (used for authentication).
            principalId: cd0be6fc-f619-49c6-8ab8-82e5f5f66970 (used for role assignments).
            tenantId: 550420cd-a4f2-4642-941d-ec8d931bcceb (matches your subscription’s tenant).
            id: The resource ID of the managed identity.
            location, name, resourceGroup, type: Metadata about the identity.

        Next Step 
            take the principal id from the ABOVE output and put it in the next cmd

            az role assignment list --assignee cd0be6fc-f619-49c6-8ab8-82e5f5f66970 --scope /subscriptions/d142b1fc-9376-4248-93fb-7f8602c24e09/resourceGroups/SecureNodeAppGroup_central/providers/Microsoft.Web/sites/secure-node-app-123
                [
                    {
                        "condition": null,
                        "conditionVersion": null,
                        "createdBy": "104d0b66-ee84-4fe2-ae6c-e1a9a8f0bc31",
                        "createdOn": "2025-09-04T18:42:05.130980+00:00",
                        "delegatedManagedIdentityResourceId": null,
                        "description": null,
                        "id": "/subscriptions/d142b1fc-9376-4248-93fb-7f8602c24e09/resourceGroups/SecureNodeAppGroup_central/providers/Microsoft.Web/sites/secure-node-app-123/providers/Microsoft.Authorization/roleAssignments/60260273-65f3-492b-b99c-3df13b0874c6",
                        "name": "60260273-65f3-492b-b99c-3df13b0874c6",
                        "principalId": "cd0be6fc-f619-49c6-8ab8-82e5f5f66970",
                        "principalName": "d8a439d9-8a4e-4dce-a51d-24f2937b25bc",
                        "principalType": "ServicePrincipal",
                        "resourceGroup": "SecureNodeAppGroup_central",
                        "roleDefinitionId": "/subscriptions/d142b1fc-9376-4248-93fb-7f8602c24e09/providers/Microsoft.Authorization/roleDefinitions/de139f84-1756-47ae-9be6-808fbbe84772",
                        "roleDefinitionName": "Website Contributor",
                        "scope": "/subscriptions/d142b1fc-9376-4248-93fb-7f8602c24e09/resourceGroups/SecureNodeAppGroup_central/providers/Microsoft.Web/sites/secure-node-app-123",
                        "type": "Microsoft.Authorization/roleAssignments",
                        "updatedBy": "104d0b66-ee84-4fe2-ae6c-e1a9a8f0bc31",
                        "updatedOn": "2025-09-04T18:42:05.130980+00:00"
                    }
                ]
            What It Does:
                if you look at the above output it displayes the scope or permissions