---
name: netbox
description: Interact with NetBox instances (brainmill.com, csbnet.se, chsfg.se) to query and manage network infrastructure data including devices, IP addresses, VLANs, sites, racks, and cables. Use when the user asks about network devices, IP addresses, VLANs, sites, or other DCIM/IPAM data.
compatibility: Requires curl and jq. Requires NETBOX_TOKEN environment variable for each instance.
metadata:
  author: opencode
  version: "1.0"
  instances: netbox.brainmill.com, netbox.csbnet.se, netbox.chsfg.se
---

# NetBox Skill

Interact with NetBox instances to query and manage network infrastructure data.

## When to use this skill

Use this skill when the user wants to:
- Query devices, IP addresses, VLANs, sites, or racks from NetBox
- Search for network infrastructure information
- List or filter DCIM (Data Center Infrastructure Management) objects
- List or filter IPAM (IP Address Management) objects
- Create, update, or delete NetBox objects
- Get information about cables, connections, or interfaces

## IMPORTANT: Explore Before Modifying

**Before creating or modifying any objects in NetBox, ALWAYS explore the existing structure first.** This ensures you use the correct patterns and relationships already established in the instance.

### Required exploration steps:

1. **When adding components to a device** (HDDs, NICs, modules, etc.):
   - First query the device to understand its structure: `/api/dcim/devices/?name=<device>`
   - Check for module bays: `/api/dcim/module-bays/?device_id=<id>`
   - Check for existing modules: `/api/dcim/modules/?device_id=<id>`
   - Check for inventory items: `/api/dcim/inventory-items/?device_id=<id>`
   - Look at existing patterns - if the device has module bays for HDDs, use modules, not inventory items

2. **When creating new object types** (manufacturers, device types, module types):
   - Search for existing similar objects first to avoid duplicates
   - Follow naming conventions used in the instance

3. **When unsure about the correct approach**:
   - Look at similar devices in the same instance
   - Examine existing relationships and patterns
   - The device type often defines what module bays/components are expected

## NetBox Instances

The following NetBox instances are available:

| Instance | URL | Token Variable |
|----------|-----|----------------|
| Brainmill | `https://netbox.brainmill.com` | `NETBOX_TOKEN_BRAINMILL` |
| CSBNet | `https://netbox.csbnet.se` | `NETBOX_TOKEN_CSBNET` |
| CHSFG | `https://netbox.chsfg.se` | `NETBOX_TOKEN_CHSFG` |

If a single `NETBOX_TOKEN` is set, it will be used as fallback for all instances.

## Instructions

### Step 1: Determine the target instance

Ask the user which NetBox instance to query if not specified:
- `brainmill` or `brainmill.com` → netbox.brainmill.com
- `csbnet` or `csbnet.se` → netbox.csbnet.se
- `chsfg` or `chsfg.se` → netbox.chsfg.se

If the user says "all instances", query each one sequentially.

### Step 2: Use the helper script

Use the provided script at `.skills/netbox/scripts/netbox-api.sh` for API calls:

```bash
# Basic syntax
.skills/netbox/scripts/netbox-api.sh <instance> <endpoint> [method] [data]

# Examples
.skills/netbox/scripts/netbox-api.sh brainmill /api/dcim/devices/
.skills/netbox/scripts/netbox-api.sh csbnet /api/ipam/ip-addresses/ GET
.skills/netbox/scripts/netbox-api.sh chsfg /api/dcim/devices/ POST '{"name":"new-device",...}'
```

### Step 3: Common API Endpoints

#### DCIM (Data Center Infrastructure Management)
| Endpoint | Description |
|----------|-------------|
| `/api/dcim/devices/` | Network devices (servers, switches, routers) |
| `/api/dcim/sites/` | Physical locations/sites |
| `/api/dcim/racks/` | Equipment racks |
| `/api/dcim/interfaces/` | Device interfaces |
| `/api/dcim/cables/` | Cable connections |
| `/api/dcim/device-types/` | Device hardware models |
| `/api/dcim/manufacturers/` | Equipment manufacturers |
| `/api/dcim/platforms/` | Software platforms (OS) |
| `/api/dcim/module-bays/` | Slots/bays for installable modules (HDDs, cards, etc.) |
| `/api/dcim/module-types/` | Module hardware models (HDD models, NIC models, etc.) |
| `/api/dcim/modules/` | Installed modules in module bays |
| `/api/dcim/inventory-items/` | Generic inventory tracking (use modules for structured components) |

#### IPAM (IP Address Management)
| Endpoint | Description |
|----------|-------------|
| `/api/ipam/ip-addresses/` | IP addresses |
| `/api/ipam/prefixes/` | IP prefixes/subnets |
| `/api/ipam/vlans/` | VLANs |
| `/api/ipam/vlan-groups/` | VLAN groups |
| `/api/ipam/vrfs/` | VRFs (Virtual Routing and Forwarding) |
| `/api/ipam/aggregates/` | IP aggregates |

#### Virtualization
| Endpoint | Description |
|----------|-------------|
| `/api/virtualization/virtual-machines/` | Virtual machines |
| `/api/virtualization/clusters/` | VM clusters |
| `/api/virtualization/interfaces/` | VM interfaces |

#### Tenancy
| Endpoint | Description |
|----------|-------------|
| `/api/tenancy/tenants/` | Tenants/customers |
| `/api/tenancy/contacts/` | Contact information |

### Step 4: Filtering results

NetBox API supports query parameters for filtering:

```bash
# Filter devices by name (contains)
.skills/netbox/scripts/netbox-api.sh brainmill "/api/dcim/devices/?name__ic=switch"

# Filter by site
.skills/netbox/scripts/netbox-api.sh brainmill "/api/dcim/devices/?site=main-dc"

# Filter IP addresses by prefix
.skills/netbox/scripts/netbox-api.sh csbnet "/api/ipam/ip-addresses/?parent=10.0.0.0/8"

# Filter VLANs by ID range
.skills/netbox/scripts/netbox-api.sh chsfg "/api/ipam/vlans/?vid__gte=100&vid__lte=200"

# Combine multiple filters
.skills/netbox/scripts/netbox-api.sh brainmill "/api/dcim/devices/?status=active&role=switch"
```

Common filter suffixes:
- `__ic` - case-insensitive contains
- `__nic` - case-insensitive does not contain
- `__ie` - case-insensitive exact
- `__gte` - greater than or equal
- `__lte` - less than or equal
- `__n` - not equal

### Step 5: Creating and updating objects

For POST/PUT/PATCH requests, provide JSON data:

```bash
# Create a new device
.skills/netbox/scripts/netbox-api.sh brainmill /api/dcim/devices/ POST '{
  "name": "sw-core-01",
  "device_type": 1,
  "role": 1,
  "site": 1,
  "status": "active"
}'

# Update a device (full replacement)
.skills/netbox/scripts/netbox-api.sh brainmill /api/dcim/devices/123/ PUT '{"name": "sw-core-01-renamed", ...}'

# Partial update
.skills/netbox/scripts/netbox-api.sh brainmill /api/dcim/devices/123/ PATCH '{"status": "planned"}'

# Delete an object
.skills/netbox/scripts/netbox-api.sh brainmill /api/dcim/devices/123/ DELETE
```

## Examples

### Example 1: List all devices at a site

Input: "Show me all devices at the main datacenter in brainmill"

```bash
.skills/netbox/scripts/netbox-api.sh brainmill "/api/dcim/devices/?site__name__ic=main"
```

### Example 2: Find an IP address

Input: "What device has IP 10.0.1.50 in csbnet?"

```bash
.skills/netbox/scripts/netbox-api.sh csbnet "/api/ipam/ip-addresses/?address=10.0.1.50"
```

### Example 3: List VLANs

Input: "List all VLANs in chsfg"

```bash
.skills/netbox/scripts/netbox-api.sh chsfg /api/ipam/vlans/
```

### Example 4: Search across all instances

Input: "Find device named core-sw-01 in all NetBox instances"

```bash
for instance in brainmill csbnet chsfg; do
  echo "=== $instance ==="
  .skills/netbox/scripts/netbox-api.sh $instance "/api/dcim/devices/?name__ic=core-sw-01"
done
```

### Example 5: Add hardware components (HDDs, modules) to a device

Input: "Add hard drives to server proxmox5"

**Step 1: Explore the device structure first**
```bash
# Get device ID
.skills/netbox/scripts/netbox-api.sh csbnet "/api/dcim/devices/?name=proxmox5"

# Check for module bays (slots for HDDs, cards, etc.)
.skills/netbox/scripts/netbox-api.sh csbnet "/api/dcim/module-bays/?device_id=835"

# Check existing modules to understand the pattern
.skills/netbox/scripts/netbox-api.sh csbnet "/api/dcim/modules/?device_id=835"
```

**Step 2: Create module type if needed (the HDD model)**
```bash
# First check if manufacturer exists
.skills/netbox/scripts/netbox-api.sh csbnet "/api/dcim/manufacturers/?name__ic=seagate"

# Create manufacturer if needed
.skills/netbox/scripts/netbox-api.sh csbnet /api/dcim/manufacturers/ POST '{"name": "Seagate", "slug": "seagate"}'

# Create module type for the HDD model
.skills/netbox/scripts/netbox-api.sh csbnet /api/dcim/module-types/ POST '{
  "manufacturer": 24,
  "model": "ST22000NM001E-3HM103",
  "description": "Seagate Exos X22 22TB SATA HDD"
}'
```

**Step 3: Install modules in module bays**
```bash
# Create module and install in bay
.skills/netbox/scripts/netbox-api.sh csbnet /api/dcim/modules/ POST '{
  "device": 835,
  "module_bay": 1,
  "module_type": 2,
  "serial": "ZX25NQQ7",
  "status": "active"
}'
```

**Important:** Use modules + module bays for structured hardware (HDDs, NICs, expansion cards). Only use inventory items for unstructured tracking when no module bays exist.

## Audit Your Changes

**After making changes to NetBox, always review the changelog to verify the intended outcome.**

```bash
# Review recent changes by user (filter by username and time)
.skills/netbox/scripts/netbox-api.sh csbnet "/api/core/object-changes/?user_name=<username>&time_after=2026-01-19T12:00:00" | jq '[.results[] | {time, action: .action.label, type: .changed_object_type, object: .object_repr}]'
```

This helps you:
- Confirm all intended changes were made
- Catch any unintended side effects
- Verify deletions/cleanups completed
- Provide an audit trail summary to the user

## Edge cases

- **Missing token**: If the API returns 403 Forbidden, check that the appropriate `NETBOX_TOKEN_*` environment variable is set
- **Instance not found**: Validate instance name against the three known instances
- **Empty results**: NetBox returns `{"count": 0, "results": []}` for empty queries - this is normal
- **Pagination**: By default, NetBox returns 50 results. Use `?limit=0` to get all results or `?limit=100&offset=100` for pagination
- **Rate limiting**: If you get 429 errors, add delays between requests

## Troubleshooting

1. **Check connectivity**: `curl -I https://netbox.brainmill.com`
2. **Verify token**: Ensure `NETBOX_TOKEN_BRAINMILL` (or similar) is set
3. **Test simple query**: `.skills/netbox/scripts/netbox-api.sh brainmill /api/status/`
4. **Check API version**: Different NetBox versions may have different endpoints
