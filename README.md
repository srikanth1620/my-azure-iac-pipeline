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
