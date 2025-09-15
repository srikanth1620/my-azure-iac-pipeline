What is RTO and RPO ? 
----------------------------------------------------------------------------
RTO (Recovery Time Objective) and RPO (Recovery Point Objective) are both disaster recovery (DR) metrics, not features like point-in-time restore. Here’s a quick clarification in the context of your Azure Blob Storage account in US East (RA-GRS, soft delete enabled for 7 days, no versioning):

RTO (Recovery Time Objective): The maximum acceptable time an application or data (e.g., your Blob Storage) can be unavailable before recovery after a failure.

Example: If your app needs to be back online in 1 hour, RTO is 1 hour.

RPO (Recovery Point Objective): The maximum amount of data (in time) that can be lost due to a failure, measured as the time between the last backup and the failure.

Example: If you back up every 4 hours and lose data since the last backup, RPO is 4 hours.


DR Features - Versioning and Point in time recovery? 
----------------------------------------------------------------------------

Versioning - Automatically creates and stores a new version of a blob each time it’s modified or overwritten, allowing recovery of specific previous versions.

Purpose: Protects against accidental overwrites or deletions by maintaining a history of blob versions.

Example: If you overwrite “file.txt” three times, versioning keeps all three versions, and you can restore any specific version.

Point-in-Time Restore:

Restores an entire container to its state at a specific moment within the retention period (e.g., up to 7 days, matching your soft delete period).

Purpose: Recovers from large-scale data loss or corruption (e.g., ransomware or mass deletions) by reverting the container to a prior state.

Scope of Recovery: Versioning lets you pick a specific blob version; point-in-time restore reverts all blobs in a container to a single timestamp.

what is the difference between soft delete and versioning ? 
----------------------------------------------------------------------------

Soft Delete vs. Versioning in Azure Blob Storage, using a simple example with a text file (file.txt):

Soft Delete:

What It Is: Keeps deleted or overwritten blobs for a set period (e.g., your 7-day retention) for recovery.
Scope: Individual blobs, latest state only.
Example: You delete file.txt or overwrite it with new content. Soft delete retains the original file.txt for 7 days, recoverable via Undelete.
Key Point: Only the last deleted/overwritten state is saved; no history of multiple changes.
Your Setup: Enabled for 7 days.


Versioning:

What It Is: Saves a new version of a blob each time it’s modified or overwritten, allowing recovery of any previous version.
Scope: Individual blobs, all versions.
Example: You edit file.txt three times (v1: "Hello", v2: "World", v3: "Azure"). Versioning keeps all three versions, and you can restore any (e.g., v1: "Hello").
Key Point: Tracks full version history, not just the last state.
Your Setup: Not enabled.

what is life cycle management ? 
----------------------------------------------------------------------------

Lifecycle Management: Automates blob transitions (e.g., to cool tier) or deletions based on rules, optimizing costs while maintaining ZRS redundancy in US East.

what is Redundancy ?
----------------------------------------------------------------------------

Redundancy (Replication Types)

ZRS (Zone-Redundant Storage): Synchronously replicates data across three Availability Zones in US East for high availability during zone failures.

RA-GRS (Read-Access Geo-Redundant Storage): Replicates data within one US East data center (LRS) and to a secondary region with read access, not ideal for your single-region DR.

RA-GZRS: Combines ZRS in US East (across AZs) with read-access replication to a secondary region, better for AZ redundancy but involves another region.

LRS (Locally-Redundant Storage): Replicates data three times in one US East data center, no AZ redundancy, less resilient for DR.