package 'System' {
  requirement def 'DMSR-4419' { doc /* Similarly, DMSR-4419 requires that the pipelines fed by Prompt Processing Ingest and producing output via the Telemetry Gateway be down for no more than 24 hours at a time. */ }
  requirement def 'DMSR-4837' { doc /* All of these services need to function sufficiently to meet requirement DMSR-4837, which says that DM as a whole must not prevent observing for more than 1 day total per year. */ }
  requirement def 'DMSR-4245' { doc /* Requirement DMSR-4245 already specifies that reliability (i.e. correctness and consistency of service) should be prioritized over availability to end users, given equal cost. */ }
  part def 'Archiving Def';
  part 'Archiving' : 'Archiving Def';
  satisfy 'DMSR-4419' by 'Archiving';
  satisfy 'DMSR-4837' by 'Archiving';
  part def 'Planned Observation Publication Def';
  part 'Planned Observation Publication' : 'Planned Observation Publication Def';
  part def 'Prompt Processing Ingest Def';
  part 'Prompt Processing Ingest' : 'Prompt Processing Ingest Def';
  satisfy 'DMSR-4419' by 'Prompt Processing Ingest';
  satisfy 'DMSR-4837' by 'Prompt Processing Ingest';
  part def 'Prompt Processing Def';
  part 'Prompt Processing' : 'Prompt Processing Def';
  satisfy 'DMSR-4419' by 'Prompt Processing';
  satisfy 'DMSR-4837' by 'Prompt Processing';
  part def 'Observatory Operations Data Def';
  part 'Observatory Operations Data' : 'Observatory Operations Data Def';
  satisfy 'DMSR-4837' by 'Observatory Operations Data';
  part def 'OCS-Driven Batch Def';
  part 'OCS-Driven Batch' : 'OCS-Driven Batch Def';
  satisfy 'DMSR-4419' by 'OCS-Driven Batch';
  satisfy 'DMSR-4837' by 'OCS-Driven Batch';
  part def 'Telemetry Gateway Def';
  part 'Telemetry Gateway' : 'Telemetry Gateway Def';
  satisfy 'DMSR-4419' by 'Telemetry Gateway';
  satisfy 'DMSR-4837' by 'Telemetry Gateway';
  part def 'Alert Distribution Def';
  part 'Alert Distribution' : 'Alert Distribution Def';
  satisfy 'DMSR-4419' by 'Alert Distribution';
  satisfy 'DMSR-4245' by 'Alert Distribution';
  satisfy 'DMSR-4837' by 'Alert Distribution';
  part def 'Prompt Quality Control Def';
  part 'Prompt Quality Control' : 'Prompt Quality Control Def';
  satisfy 'DMSR-4837' by 'Prompt Quality Control';
  part def 'Batch Production Def';
  part 'Batch Production' : 'Batch Production Def';
  satisfy 'DMSR-4419' by 'Batch Production';
  satisfy 'DMSR-4837' by 'Batch Production';
  part def 'Bulk Distribution Def';
  part 'Bulk Distribution' : 'Bulk Distribution Def';
  satisfy 'DMSR-4837' by 'Bulk Distribution';
  part def 'DBB Lifetime Management Def';
  part 'DBB Lifetime Management' : 'DBB Lifetime Management Def';
  part def 'Commissioning Cluster Enclave Def';
  part 'Commissioning Cluster Enclave' : 'Commissioning Cluster Enclave Def';
  satisfy 'DMSR-4245' by 'Commissioning Cluster Enclave';
  satisfy 'DMSR-4837' by 'Commissioning Cluster Enclave';
}