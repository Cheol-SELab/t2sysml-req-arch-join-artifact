package 'System' {
  requirement def 'SVC-CDHCORE-001' { doc /* The subtopology shall provide command dispatching functionality to route incoming commands to components. */ }
  requirement def 'SVC-CDHCORE-002' { doc /* The subtopology shall provide event management functionality to collect events. */ }
  requirement def 'SVC-CDHCORE-003' { doc /* The subtopology shall provide health monitoring functionality including for active components. */ }
  requirement def 'SVC-CDHCORE-004' { doc /* The subtopology shall provide version and configuration reporting functionality at system startup. */ }
  requirement def 'SVC-CDHCORE-005' { doc /* The subtopology shall provide text logging functionality for console logged event messages. */ }
  requirement def 'SVC-CDHCORE-006' { doc /* The subtopology shall provide **assert to fatal handling functionality** to convert `FW_ASSERT`s into `FATAL` events. */ }
  requirement def 'SVC-CDHCORE-007' { doc /* The subtopology shall provide fatal-event routing functionality to forward fatal announcements to a configurable handler. */ }
  requirement def 'SVC-CDHCORE-008' { doc /* The subtopology shall provide telemetry sending functionality through a configurable telemetry interface. */ }
  requirement def 'SVC-CDHCORE-009' { doc /* The subtopology shall support **configurable instance properties** for IDs, queue sizes, stack sizes, priorities, and CPU affinities. */ }
  requirement def 'SVC-CDHCORE-010' { doc /* The subtopology shall expose rate-group connection points for any rate-drive components it contains. */ }
  requirement def 'SVC-COMFPRIME-004' { doc /* Provide a **subtopology variant that supplies `Svc::ComStub`** designed to connect to a ByteStream driver. */ }
  requirement def 'SVC-COMFPRIME-005' { doc /* Provide a **subtopology variant that expects an external `Svc::ComInterface`** supplied by the deployment. */ }
  requirement def 'SVC-COMCCSDS-006' { doc /* Support **configurable instance properties** (IDs, queue sizes, stack sizes, priorities, CPU affinities, aggregation size, packet spanning) via `ComCcsdsConfig`. */ }
  requirement def 'SVC-COMCCSDS-007' { doc /* Provide **composable layer topologies**: a Space Packet packet layer (`SpacePacketFraming`, `SpacePacket`) and a TM/TC transfer frame layer (`TmTcFraming`), from which the full stack is composed. */ }
  requirement def 'SVC-COMFPRIME-001' { doc /* Provide an F´ framer to convert COM buffers into framed packets for downlink using the F Prime format. */ }
  requirement def 'SVC-COMFPRIME-002' { doc /* Provide an F´ deframer to parse incoming packets into com buffers for uplink. */ }
  requirement def 'SVC-COMFPRIME-003' { doc /* Provide an F´ router to route deframed packets (e.g., commands/files) into the flight software. */ }
  requirement def 'SVC-COMFPRIME-006' { doc /* Support **configurable instance properties** (IDs, queue sizes, stack sizes, priorities, CPU affinities) via `ComFprimeConfig`. */ }
  requirement def 'SVC-DATAPRODUCTS-001' { doc /* The subtopology shall provide **data product buffer management** for client components requesting product buffers. */ }
  requirement def 'SVC-DATAPRODUCTS-002' { doc /* The subtopology shall provide **data product writing functionality** to store filled products on the filesystem. */ }
  requirement def 'SVC-DATAPRODUCTS-003' { doc /* The subtopology shall provide data product cataloging functionality for prioritized downlink of stored products. */ }
  requirement def 'SVC-DATAPRODUCTS-004' { doc /* The subtopology shall provide **buffer accumulation** between product management and product writing. */ }
  requirement def 'SVC-DATAPRODUCTS-005' { doc /* The subtopology shall support configurable instance properties (IDs, queue sizes, stack sizes, priorities). */ }
  requirement def 'SVC-DATAPRODUCTS-006' { doc /* The subtopology shall expose rate-group connection points for components requiring scheduling. */ }
  requirement def 'SVC-DPCOMPRESSION-001' { doc /* The subtopology shall provide data product compression processing for product buffers. */ }
  requirement def 'SVC-DPCOMPRESSION-002' { doc /* The subtopology shall provide ZLib-based compression of product data. */ }
  requirement def 'SVC-DPCOMPRESSION-003' { doc /* The subtopology shall provide buffer management for compression working and output buffers. */ }
  requirement def 'SVC-DPCOMPRESSION-004' { doc /* The subtopology shall support configurable buffer store properties (sizes, counts, allocator ID). */ }
  requirement def 'SVC-DPCOMPRESSION-005' { doc /* The subtopology shall expose a rate-group connection point for buffer manager telemetry. */ }
  requirement def 'SVC-FILEHANDLINGCFDP-001' { doc /* The subtopology shall provide **CFDP file transfer functionality** for reliable bidirectional file delivery. */ }
  requirement def 'SVC-FILEHANDLINGCFDP-002' { doc /* The subtopology shall provide **on-board file management functionality** (e.g., list, remove, hash, mkdir). */ }
  requirement def 'SVC-FILEHANDLINGCFDP-003' { doc /* The subtopology shall provide **parameter management** via the filesystem. */ }
  requirement def 'SVC-FILEHANDLINGCFDP-004' { doc /* The subtopology shall support **configurable instance properties** (IDs, queue sizes, stack sizes, priorities, CPU affinities). */ }
  requirement def 'SVC-FILEHANDLINGCFDP-005' { doc /* The subtopology shall expose **rate-group connection points** for the CFDP manager component. */ }
  requirement def 'SVC-FILEHANDLING-001' { doc /* The subtopology shall provide **file uplink functionality** to receive and reconstruct files from ground. */ }
  requirement def 'SVC-FILEHANDLING-002' { doc /* The subtopology shall provide **file downlink functionality** to segment and transmit files to ground. */ }
  requirement def 'SVC-FILEHANDLING-003' { doc /* The subtopology shall provide **on-board file management functionality** (e.g., list, remove, hash, mkdir). */ }
  requirement def 'SVC-FILEHANDLING-004' { doc /* The subtopology shall provide **parameter management** via the filesystem. */ }
  requirement def 'SVC-FILEHANDLING-005' { doc /* The subtopology shall support **configurable instance properties** (IDs, queue sizes, stack sizes, priorities, CPU affinities). */ }
  requirement def 'SVC-FILEHANDLING-006' { doc /* The subtopology shall expose **rate-group connection points** for any rate-drive components it contains. */ }
  part def 'cmdDisp Def';
  part 'cmdDisp' : 'cmdDisp Def' {
    satisfy requirement 'r SVC-CDHCORE-001' : 'SVC-CDHCORE-001' by 'cmdDisp';
  }
  part def 'events Def';
  part 'events' : 'events Def' {
    satisfy requirement 'r SVC-CDHCORE-002' : 'SVC-CDHCORE-002' by 'events';
  }
  part def '$health Def';
  part '$health' : '$health Def' {
    satisfy requirement 'r SVC-CDHCORE-003' : 'SVC-CDHCORE-003' by '$health';
  }
  part def 'version Def';
  part 'version' : 'version Def' {
    satisfy requirement 'r SVC-CDHCORE-004' : 'SVC-CDHCORE-004' by 'version';
  }
  part def 'textLogger Def';
  part 'textLogger' : 'textLogger Def' {
    satisfy requirement 'r SVC-CDHCORE-005' : 'SVC-CDHCORE-005' by 'textLogger';
  }
  part def 'fatalAdapter Def';
  part 'fatalAdapter' : 'fatalAdapter Def' {
    satisfy requirement 'r SVC-CDHCORE-006' : 'SVC-CDHCORE-006' by 'fatalAdapter';
  }
  part def 'fatalHandler Def';
  part 'fatalHandler' : 'fatalHandler Def' {
    satisfy requirement 'r SVC-CDHCORE-007' : 'SVC-CDHCORE-007' by 'fatalHandler';
  }
  part def 'tlmSend Def';
  part 'tlmSend' : 'tlmSend Def' {
    satisfy requirement 'r SVC-CDHCORE-008' : 'SVC-CDHCORE-008' by 'tlmSend';
  }
  part def 'CdhCoreConfig Def';
  part 'CdhCoreConfig' : 'CdhCoreConfig Def' {
    satisfy requirement 'r SVC-CDHCORE-009' : 'SVC-CDHCORE-009' by 'CdhCoreConfig';
  }
  part def 'CdhCoreFatalHandlerConfig Def';
  part 'CdhCoreFatalHandlerConfig' : 'CdhCoreFatalHandlerConfig Def' {
    satisfy requirement 'r SVC-CDHCORE-009' : 'SVC-CDHCORE-009' by 'CdhCoreFatalHandlerConfig';
  }
  part def 'CdhCoreTlmConfig Def';
  part 'CdhCoreTlmConfig' : 'CdhCoreTlmConfig Def' {
    satisfy requirement 'r SVC-CDHCORE-009' : 'SVC-CDHCORE-009' by 'CdhCoreTlmConfig';
  }
  part def '$health.Run Def';
  part '$health.Run' : '$health.Run Def' {
    satisfy requirement 'r SVC-CDHCORE-010' : 'SVC-CDHCORE-010' by '$health.Run';
  }
  part def 'spacePacketFramer Def';
  part 'spacePacketFramer' : 'spacePacketFramer Def' {
  }
  part def 'tmFramer Def';
  part 'tmFramer' : 'tmFramer Def' {
  }
  part def 'frameAccumulator Def';
  part 'frameAccumulator' : 'frameAccumulator Def' {
  }
  part def 'fprimeRouter Def';
  part 'fprimeRouter' : 'fprimeRouter Def' {
  }
  part def 'Subtopology Def';
  part 'Subtopology' : 'Subtopology Def' {
    satisfy requirement 'r SVC-COMFPRIME-004' : 'SVC-COMFPRIME-004' by 'Subtopology';
  }
  part def 'FramingSubtopology Def';
  part 'FramingSubtopology' : 'FramingSubtopology Def' {
    satisfy requirement 'r SVC-COMFPRIME-005' : 'SVC-COMFPRIME-005' by 'FramingSubtopology';
  }
  part def 'ComCcsdsConfig Def';
  part 'ComCcsdsConfig' : 'ComCcsdsConfig Def' {
    satisfy requirement 'r SVC-COMCCSDS-006' : 'SVC-COMCCSDS-006' by 'ComCcsdsConfig';
  }
  part def 'SpacePacketFraming Def';
  part 'SpacePacketFraming' : 'SpacePacketFraming Def' {
    satisfy requirement 'r SVC-COMCCSDS-007' : 'SVC-COMCCSDS-007' by 'SpacePacketFraming';
  }
  part def 'SpacePacket Def';
  part 'SpacePacket' : 'SpacePacket Def' {
    satisfy requirement 'r SVC-COMCCSDS-007' : 'SVC-COMCCSDS-007' by 'SpacePacket';
  }
  part def 'TmTcFraming Def';
  part 'TmTcFraming' : 'TmTcFraming Def' {
    satisfy requirement 'r SVC-COMCCSDS-007' : 'SVC-COMCCSDS-007' by 'TmTcFraming';
  }
  part def 'framer — Svc.FprimeFramer Def';
  part 'framer — Svc.FprimeFramer' : 'framer — Svc.FprimeFramer Def' {
    satisfy requirement 'r SVC-COMFPRIME-001' : 'SVC-COMFPRIME-001' by 'framer — Svc.FprimeFramer';
  }
  part def 'deframer — Svc.FprimeDeframer Def';
  part 'deframer — Svc.FprimeDeframer' : 'deframer — Svc.FprimeDeframer Def' {
    satisfy requirement 'r SVC-COMFPRIME-002' : 'SVC-COMFPRIME-002' by 'deframer — Svc.FprimeDeframer';
  }
  part def 'router — Svc.FprimeRouter Def';
  part 'router — Svc.FprimeRouter' : 'router — Svc.FprimeRouter Def' {
    satisfy requirement 'r SVC-COMFPRIME-003' : 'SVC-COMFPRIME-003' by 'router — Svc.FprimeRouter';
  }
  part def 'ComFprimeConfig Def';
  part 'ComFprimeConfig' : 'ComFprimeConfig Def' {
    satisfy requirement 'r SVC-COMFPRIME-006' : 'SVC-COMFPRIME-006' by 'ComFprimeConfig';
  }
  part def 'dpMgr Def';
  part 'dpMgr' : 'dpMgr Def' {
    satisfy requirement 'r SVC-DATAPRODUCTS-001' : 'SVC-DATAPRODUCTS-001' by 'dpMgr';
  }
  part def 'dpBufferManager Def';
  part 'dpBufferManager' : 'dpBufferManager Def' {
    satisfy requirement 'r SVC-DATAPRODUCTS-001' : 'SVC-DATAPRODUCTS-001' by 'dpBufferManager';
  }
  part def 'dpWriter Def';
  part 'dpWriter' : 'dpWriter Def' {
    satisfy requirement 'r SVC-DATAPRODUCTS-002' : 'SVC-DATAPRODUCTS-002' by 'dpWriter';
  }
  part def 'dpCat Def';
  part 'dpCat' : 'dpCat Def' {
    satisfy requirement 'r SVC-DATAPRODUCTS-003' : 'SVC-DATAPRODUCTS-003' by 'dpCat';
  }
  part def 'dpBufferAccumulator Def';
  part 'dpBufferAccumulator' : 'dpBufferAccumulator Def' {
    satisfy requirement 'r SVC-DATAPRODUCTS-004' : 'SVC-DATAPRODUCTS-004' by 'dpBufferAccumulator';
  }
  part def 'DataProductsConfig Def';
  part 'DataProductsConfig' : 'DataProductsConfig Def' {
    satisfy requirement 'r SVC-DATAPRODUCTS-005' : 'SVC-DATAPRODUCTS-005' by 'DataProductsConfig';
  }
  part def 'Exposed *SchedIn topology ports Def';
  part 'Exposed *SchedIn topology ports' : 'Exposed *SchedIn topology ports Def' {
    satisfy requirement 'r SVC-DATAPRODUCTS-006' : 'SVC-DATAPRODUCTS-006' by 'Exposed *SchedIn topology ports';
  }
  part def 'dpCompressProc Def';
  part 'dpCompressProc' : 'dpCompressProc Def' {
    satisfy requirement 'r SVC-DPCOMPRESSION-001' : 'SVC-DPCOMPRESSION-001' by 'dpCompressProc';
  }
  part def 'dpZLibCompressor Def';
  part 'dpZLibCompressor' : 'dpZLibCompressor Def' {
    satisfy requirement 'r SVC-DPCOMPRESSION-002' : 'SVC-DPCOMPRESSION-002' by 'dpZLibCompressor';
  }
  part def 'dpZLibCompressorBufferManager Def';
  part 'dpZLibCompressorBufferManager' : 'dpZLibCompressorBufferManager Def' {
    satisfy requirement 'r SVC-DPCOMPRESSION-003' : 'SVC-DPCOMPRESSION-003' by 'dpZLibCompressorBufferManager';
  }
  part def 'DpCompressionConfig::ZLibBuffMgr Def';
  part 'DpCompressionConfig::ZLibBuffMgr' : 'DpCompressionConfig::ZLibBuffMgr Def' {
    satisfy requirement 'r SVC-DPCOMPRESSION-004' : 'SVC-DPCOMPRESSION-004' by 'DpCompressionConfig::ZLibBuffMgr';
  }
  part def 'dpZLibBufferManagerSchedIn Def';
  part 'dpZLibBufferManagerSchedIn' : 'dpZLibBufferManagerSchedIn Def' {
    satisfy requirement 'r SVC-DPCOMPRESSION-005' : 'SVC-DPCOMPRESSION-005' by 'dpZLibBufferManagerSchedIn';
  }
  part def 'cfdpManager — Svc.Ccsds.Cfdp.CfdpManager Def';
  part 'cfdpManager — Svc.Ccsds.Cfdp.CfdpManager' : 'cfdpManager — Svc.Ccsds.Cfdp.CfdpManager Def' {
    satisfy requirement 'r SVC-FILEHANDLINGCFDP-001' : 'SVC-FILEHANDLINGCFDP-001' by 'cfdpManager — Svc.Ccsds.Cfdp.CfdpManager';
  }
  part def 'fileManager — Svc.FileManager Def';
  part 'fileManager — Svc.FileManager' : 'fileManager — Svc.FileManager Def' {
    satisfy requirement 'r SVC-FILEHANDLINGCFDP-002' : 'SVC-FILEHANDLINGCFDP-002' by 'fileManager — Svc.FileManager';
  }
  part def 'prmDb — Svc.PrmDb Def';
  part 'prmDb — Svc.PrmDb' : 'prmDb — Svc.PrmDb Def' {
    satisfy requirement 'r SVC-FILEHANDLINGCFDP-003' : 'SVC-FILEHANDLINGCFDP-003' by 'prmDb — Svc.PrmDb';
  }
  part def 'FileHandlingCfdpConfig (instance properties) Def';
  part 'FileHandlingCfdpConfig (instance properties)' : 'FileHandlingCfdpConfig (instance properties) Def' {
    satisfy requirement 'r SVC-FILEHANDLINGCFDP-004' : 'SVC-FILEHANDLINGCFDP-004' by 'FileHandlingCfdpConfig (instance properties)';
  }
  part def 'run1Hz connection specifier for cfdpManager Def';
  part 'run1Hz connection specifier for cfdpManager' : 'run1Hz connection specifier for cfdpManager Def' {
    satisfy requirement 'r SVC-FILEHANDLINGCFDP-005' : 'SVC-FILEHANDLINGCFDP-005' by 'run1Hz connection specifier for cfdpManager';
    satisfy requirement 'r SVC-FILEHANDLING-001' : 'SVC-FILEHANDLING-001' by 'run1Hz connection specifier for cfdpManager';
    satisfy requirement 'r SVC-FILEHANDLING-002' : 'SVC-FILEHANDLING-002' by 'run1Hz connection specifier for cfdpManager';
    satisfy requirement 'r SVC-FILEHANDLING-003' : 'SVC-FILEHANDLING-003' by 'run1Hz connection specifier for cfdpManager';
    satisfy requirement 'r SVC-FILEHANDLING-004' : 'SVC-FILEHANDLING-004' by 'run1Hz connection specifier for cfdpManager';
    satisfy requirement 'r SVC-FILEHANDLING-005' : 'SVC-FILEHANDLING-005' by 'run1Hz connection specifier for cfdpManager';
    satisfy requirement 'r SVC-FILEHANDLING-006' : 'SVC-FILEHANDLING-006' by 'run1Hz connection specifier for cfdpManager';
  }
}