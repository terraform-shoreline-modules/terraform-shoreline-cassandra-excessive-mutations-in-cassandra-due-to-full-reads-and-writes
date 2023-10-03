
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Excessive Mutations in Cassandra Due to Full Reads and Writes
---

This incident type describes a problem where the number of mutations in a Cassandra database has reached an excessive level. This is usually caused by full reads and writes, which can lead to an increased number of changes within the database. Excessive mutations can cause performance issues and impact the overall stability of the system. Therefore, it is important to resolve this issue as soon as possible to ensure the system is running smoothly.

### Parameters
```shell
export KEYSPACE_TABLE="PLACEHOLDER"

export DATABASE_NAME="PLACEHOLDER"

export SCHEMA_NAME="PLACEHOLDER"

export CACHE_NAME="PLACEHOLDER"

export STORAGE_NAME="PLACEHOLDER"
```

## Debug

### Check if Cassandra is running
```shell
systemctl status cassandra.service
```

### Check Cassandra logs for errors
```shell
journalctl -u cassandra.service | grep ERROR
```

### Check Cassandra compaction history
```shell
nodetool compactionhistory
```

### Check Cassandra table statistics
```shell
nodetool tablestats ${KEYSPACE_TABLE}
```

### Check Cassandra node information
```shell
nodetool info
```

### Check Cassandra system statistics
```shell
nodetool cfstats
```

### Check for high I/O wait time
```shell
iostat -x 1
```

### Check for high CPU usage
```shell
top
```

## Repair

### Optimize Cassandra query performance to reduce the number of full reads and writes, and minimize the number of mutations caused by these operations. This can involve restructuring the database schema, introducing caching layers, or using alternative data storage solutions.
```shell


#!/bin/bash



# Set variables

database=${DATABASE_NAME}

schema=${SCHEMA_NAME}

cache=${CACHE_NAME}

storage=${STORAGE_NAME}



# Optimize schema

cqlsh -e "ALTER TABLE $database.$schema WITH compaction = {'class': 'LeveledCompactionStrategy'} AND compression = {'sstable_compression': 'LZ4Compressor'};"



# Introduce caching layer

cqlsh -e "CREATE $cache;"



# Use alternative data storage

cqlsh -e "CREATE $storage;"



# Restart Cassandra service

sudo service cassandra restart


```