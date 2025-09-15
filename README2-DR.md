What is RTO and RPO ? 
----------------------------------------------------------------------------
RTO (Recovery Time Objective) and RPO (Recovery Point Objective) are both disaster recovery (DR) metrics, not features like point-in-time restore. Here’s a quick clarification in the context of your Azure Blob Storage account in US East (RA-GRS, soft delete enabled for 7 days, no versioning):

RTO (Recovery Time Objective): The maximum acceptable time an application or data (e.g., your Blob Storage) can be unavailable before recovery after a failure.

Example: If your app needs to be back online in 1 hour, RTO is 1 hour.

RPO (Recovery Point Objective): The maximum amount of data (in time) that can be lost due to a failure, measured as the time between the last backup and the failure.

Example: If you back up every 4 hours and lose data since the last backup, RPO is 4 hours.

