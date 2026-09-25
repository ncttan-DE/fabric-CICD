import os
from pathlib import Path

from azure.identity import ClientSecretCredential
from fabric_cicd import FabricWorkspace, publish_all_items


# =========================
# Configuration
# =========================

tenant_id = os.environ["FABRIC_TENANT_ID"]
client_id = os.environ["FABRIC_CLIENT_ID"]
client_secret = os.environ["FABRIC_CLIENT_SECRET"]

workspace_id = os.environ["FABRIC_WORKSPACE_ID"]

root_directory = Path(__file__).resolve().parent
repository_directory = root_directory / "resources"


# =========================
# Authentication
# =========================

credential = ClientSecretCredential(
    tenant_id=tenant_id,
    client_id=client_id,
    client_secret=client_secret,
)


# =========================
# Fabric Workspace
# =========================

workspace = FabricWorkspace(
    workspace_id=workspace_id,
    repository_directory=str(repository_directory),
    token_credential=credential,
)


# =========================
# Deploy
# =========================

publish_all_items(workspace)

print("Deployment completed successfully.")