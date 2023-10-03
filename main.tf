terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "excessive_mutations_in_cassandra_due_to_full_reads_and_writes" {
  source    = "./modules/excessive_mutations_in_cassandra_due_to_full_reads_and_writes"

  providers = {
    shoreline = shoreline
  }
}