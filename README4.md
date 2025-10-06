Governance (GV)

GV-1: Establish Security Strategy: Define a tenant-wide security policy using Azure Policy to enforce consistent configurations (e.g., require encryption) across all 40 subscriptions.
GV-2: Align with Standards: Map policies to NIST CSF or FedRAMP using MCSB’s control mappings in Defender for Cloud for compliance reporting.
GV-3: Assign Accountability: Designate a security owner per subscription, tracked via Microsoft Entra ID roles, to ensure responsibility for security tasks.
GV-4: Review Policies Regularly: Schedule quarterly reviews of Azure Policy assignments to ensure alignment with MCSB updates across subscriptions.
GV-5: Document Exceptions: Use Azure Policy exemptions to document and track any subscription-specific deviations from MCSB standards (e.g., legacy apps).

Identity Management (IM)

IM-1: Standardize Authentication: Use Microsoft Entra ID as the single identity provider for all subscriptions, enforcing MFA for all users.
IM-2: Manage Application Identities: Secure service principals with managed identities for Azure resources across subscriptions, avoiding hardcoded credentials.
IM-3: Restrict Privileged Access: Limit Owner/Contributor roles via RBAC, granting least privilege to admins managing the 40 subscriptions.
IM-4: Review Privileged Accounts: Enable Microsoft Entra Privileged Identity Management (PIM) to enforce just-in-time access for subscription admins.
IM-5: Secure External Identities: For B2B Direct Connect users (per your setup), apply Conditional Access to require MFA for external users accessing Teams shared channels.

Privileged Access (PA)

PA-1: Protect Privileged Accounts: Use dedicated admin accounts in Microsoft Entra ID for managing subscriptions, separate from daily-use accounts.
PA-2: Limit Standing Access: Configure PIM to require approval for elevating to privileged roles across all subscriptions.
PA-3: Monitor Privileged Activity: Enable Microsoft Entra ID audit logs to track privileged actions (e.g., subscription changes) across tenants.
PA-4: Secure Workstations: Enforce device compliance via Intune for admin workstations accessing subscription resources.
PA-5: Automate Access Reviews: Use Microsoft Entra ID Governance to schedule access reviews for privileged roles in all 40 subscriptions.

Data Protection (DP)

DP-1: Discover Sensitive Data: Use Microsoft Purview to classify and label sensitive data (e.g., PII) across Azure SQL, Blob Storage in all subscriptions.
DP-2: Protect Data at Rest: Enforce encryption (e.g., TDE for Azure SQL, SSE for Blob Storage) using Azure Key Vault across subscriptions.
DP-3: Protect Data in Transit: Mandate TLS 1.2+ for all Azure services (e.g., App Services, APIs) across subscriptions via Azure Policy.
DP-4: Manage Encryption Keys: Centralize key management in Azure Key Vault, with RBAC restricting access to key admins.
DP-5: Monitor Data Access: Enable diagnostic logs for storage accounts and databases to track data access across subscriptions.

Network Security (NS)

NS-1: Secure Network Perimeter: Deploy Azure Firewall across subscriptions to filter traffic, blocking unauthorized inbound connections.
NS-2: Restrict Public Access: Use NSGs to block RDP/SSH from the internet for VMs in all subscriptions, per MCSB guidance.
NS-3: Segment Networks: Implement Virtual Network (VNet) segmentation with subnets for each subscription to isolate workloads.
NS-4: Secure DNS: Use Azure Private DNS to resolve internal resources, preventing DNS spoofing across subscriptions.
NS-5: Monitor Network Traffic: Enable Azure Network Watcher to analyze traffic patterns and detect anomalies in all subscriptions.

Logging and Threat Detection (LT)

LT-1: Enable Security Monitoring: Activate Microsoft Defender for Cloud to monitor all 40 subscriptions for misconfigurations and threats.
LT-2: Centralize Logs: Configure Azure Monitor to collect logs from all subscriptions into a single Log Analytics workspace.
LT-3: Retain Logs: Set log retention (e.g., 90 days) in Log Analytics for compliance with MCSB and regulatory requirements.
LT-4: Enable Threat Detection: Use Defender for Cloud’s threat detection for VMs, databases, and containers across subscriptions.
LT-5: Correlate Alerts: Integrate Defender for Cloud with Azure Sentinel for centralized threat correlation and incident response.

Incident Response (IR)

IR-1: Develop IR Plan: Create an incident response plan for the tenant, covering all subscriptions, aligned with MCSB guidelines.
IR-2: Automate Notifications: Configure Azure Monitor alerts to notify security teams of critical incidents across subscriptions.
IR-3: Test IR Processes: Conduct quarterly tabletop exercises to simulate breaches affecting multiple subscriptions.
IR-4: Contain Incidents: Use Azure Policy to enforce rapid isolation (e.g., NSG rules) for compromised resources.
IR-5: Post-Incident Review: Log lessons learned in Azure Sentinel after incidents to improve controls across subscriptions.

Posture and Vulnerability Management (PV)

PV-1: Assess Security Posture: Use Defender for Cloud’s Secure Score to evaluate and prioritize security gaps across all subscriptions.
PV-2: Scan for Vulnerabilities: Enable Defender for Cloud’s vulnerability scanning for VMs and containers in each subscription.
PV-3: Remediate Misconfigurations: Automate remediation of common issues (e.g., open ports) using Defender for Cloud workflows.
PV-4: Patch Management: Use Azure Update Management to ensure consistent patching of VMs across subscriptions.
PV-5: Track Compliance: Monitor compliance with MCSB controls via Defender for Cloud’s regulatory compliance dashboard.

Endpoint Security (ES)

ES-1: Secure Endpoints: Deploy Microsoft Defender for Endpoint on VMs and clients accessing subscription resources.
ES-2: Enforce Device Compliance: Use Intune to enforce device compliance (e.g., encryption, AV) for endpoints accessing Azure.
ES-3: Monitor Endpoint Threats: Integrate Defender for Endpoint with Azure Sentinel for real-time threat detection.

Backup and Recovery (BR)

BR-1: Enable Backups: Configure Azure Backup for critical resources (e.g., VMs, Azure SQL) across all subscriptions.
BR-2: Protect Backup Data: Encrypt backups with customer-managed keys in Azure Key Vault for all subscriptions.
BR-3: Test Recovery: Schedule quarterly recovery tests to ensure data availability for each subscription.

DevOps Security (DS)

DS-1: Secure CI/CD Pipelines: Use Azure DevOps with RBAC to secure pipelines deploying to subscriptions, per MCSB.
DS-2: Scan Code: Integrate Microsoft Defender for DevOps to scan code and IaC templates for vulnerabilities before deployment.
DS-3: Secure Container Images: Use Defender for Containers to scan images in Azure Container Registry across subscriptions.
DS-4: Manage Secrets: Store pipeline secrets in Azure Key Vault, with access restricted via RBAC.