

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