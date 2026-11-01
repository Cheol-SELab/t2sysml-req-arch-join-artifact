package 'System' {
  requirement def 'SVC-CDHCORE-001' { doc /* The subtopology shall provide **command dispatching functionality** to route incoming commands to components. */ }
  requirement def 'SVC-CDHCORE-002' { doc /* The subtopology shall provide **event management functionality** to collect events. */ }
  requirement def 'SVC-CDHCORE-003' { doc /* The subtopology shall provide **health monitoring functionality** including for active components. */ }
  requirement def 'SVC-CDHCORE-004' { doc /* The subtopology shall provide **version and configuration reporting functionality** at system startup. */ }
  requirement def 'SVC-CDHCORE-005' { doc /* The subtopology shall provide **text logging functionality** for console logged event messages. */ }
  requirement def 'SVC-CDHCORE-006' { doc /* The subtopology shall provide **assert to fatal handling functionality** to convert `FW_ASSERT`s into `FATAL` events. */ }
  requirement def 'SVC-CDHCORE-007' { doc /* The subtopology shall provide **fatal-event routing functionality** to forward fatal announcements to a configurable handler. */ }
  requirement def 'SVC-CDHCORE-008' { doc /* The subtopology shall provide **telemetry sending functionality** through a configurable telemetry interface. */ }
  requirement def 'SVC-CDHCORE-009' { doc /* The subtopology shall support **configurable instance properties** for IDs, queue sizes, stack sizes, priorities, and CPU affinities. */ }
  requirement def 'SVC-CDHCORE-010' { doc /* The subtopology shall expose rate-group connection points for any rate-drive components it contains. */ }
  requirement def 'SVC-COMCCSDS-006' { doc /* Support **configurable instance properties** (IDs, queue sizes, stack sizes, priorities, CPU affinities, aggregation size, packet spanning) via `ComCcsdsConfig`. */ }
  requirement def 'SVC-COMCCSDS-007' { doc /* Provide **composable layer topologies**: a Space Packet packet layer (`SpacePacketFraming`, `SpacePacket`) and a TM/TC transfer frame layer (`TmTcFraming`), from which the full stack is composed. */ }
  requirement def 'SVC-COMFPRIME-001' { doc /* Provide an F´ **framer** to convert COM buffers into framed packets for downlink using the F Prime format. */ }
  requirement def 'SVC-COMFPRIME-002' { doc /* Provide an F´ **deframer** to parse incoming packets into com buffers for uplink. */ }
  requirement def 'SVC-COMFPRIME-003' { doc /* Provide an F´ **router** to route deframed packets (e.g., commands/files) into the flight software. */ }
  requirement def 'SVC-COMFPRIME-004' { doc /* Provide a **subtopology variant that supplies `Svc::ComStub`** designed to connect to a ByteStream driver. */ }
  requirement def 'SVC-COMFPRIME-005' { doc /* Provide a **subtopology variant that expects an external `Svc::ComInterface`** supplied by the deployment. */ }
  requirement def 'SVC-COMFPRIME-006' { doc /* Support **configurable instance properties** (IDs, queue sizes, stack sizes, priorities, CPU affinities) via `ComFprimeConfig`. */ }
  requirement def 'SVC-DATAPRODUCTS-001' { doc /* The subtopology shall provide data product buffer management for client components requesting product buffers. */ }
  requirement def 'SVC-DATAPRODUCTS-002' { doc /* The subtopology shall provide **data product writing functionality** to store filled products on the filesystem. */ }
  requirement def 'SVC-DATAPRODUCTS-003' { doc /* The subtopology shall provide **data product cataloging functionality** for prioritized downlink of stored products. */ }
  requirement def 'SVC-DATAPRODUCTS-004' { doc /* The subtopology shall provide **buffer accumulation** between product management and product writing. */ }
  requirement def 'SVC-DATAPRODUCTS-005' { doc /* The subtopology shall support **configurable instance properties** (IDs, queue sizes, stack sizes, priorities). */ }
  requirement def 'SVC-DATAPRODUCTS-006' { doc /* The subtopology shall expose **rate-group connection points** for components requiring scheduling. */ }
  requirement def 'SVC-DPCOMPRESSION-001' { doc /* The subtopology shall provide **data product compression processing** for product buffers. */ }
  requirement def 'SVC-DPCOMPRESSION-002' { doc /* The subtopology shall provide **ZLib-based compression** of product data. */ }
  requirement def 'SVC-DPCOMPRESSION-003' { doc /* The subtopology shall provide **buffer management** for compression working and output buffers. */ }
  requirement def 'SVC-DPCOMPRESSION-004' { doc /* The subtopology shall support **configurable buffer store properties** (sizes, counts, allocator ID). */ }
  requirement def 'SVC-DPCOMPRESSION-005' { doc /* The subtopology shall expose a **rate-group connection point** for buffer manager telemetry. */ }
  requirement def 'SVC-FILEHANDLINGCFDP-001' { doc /* The subtopology shall provide **CFDP file transfer functionality** for reliable bidirectional file delivery. */ }
  requirement def 'SVC-FILEHANDLINGCFDP-002' { doc /* The subtopology shall provide **on-board file management functionality** (e.g., list, remove, hash, mkdir). */ }
  requirement def 'SVC-FILEHANDLINGCFDP-003' { doc /* The subtopology shall provide **parameter management** via the filesystem. */ }
  requirement def 'SVC-FILEHANDLINGCFDP-004' { doc /* The subtopology shall support **configurable instance properties** (IDs, queue sizes, stack sizes, priorities, CPU affinities). */ }
  requirement def 'SVC-FILEHANDLINGCFDP-005' { doc /* The subtopology shall expose **rate-group connection points** for the CFDP manager component. */ }
  requirement def 'SVC-FILEHANDLING-001' { doc /* The subtopology shall provide **file uplink functionality** to receive and reconstruct files from ground. */ }
  requirement def 'SVC-FILEHANDLING-002' { doc /* The subtopology shall provide **file downlink functionality** to segment and transmit files to ground. */ }
  requirement def 'SVC-FILEHANDLING-003' { doc /* The subtopology shall provide on-board file management functionality (e.g., list, remove, hash, mkdir). */ }
  requirement def 'SVC-FILEHANDLING-004' { doc /* The subtopology shall provide **parameter management** via the filesystem. */ }
  requirement def 'SVC-FILEHANDLING-005' { doc /* The subtopology shall support **configurable instance properties** (IDs, queue sizes, stack sizes, priorities, CPU affinities). */ }
  requirement def 'SVC-FILEHANDLING-006' { doc /* The subtopology shall expose **rate-group connection points** for any rate-drive components it contains. */ }
  part def 'cmdDisp — Svc.CommandDispatcher Def';
  part 'cmdDisp — Svc.CommandDispatcher' : 'cmdDisp — Svc.CommandDispatcher Def';
  satisfy 'SVC-CDHCORE-001' by 'cmdDisp — Svc.CommandDispatcher';
  part def 'events — Svc.EventManager Def';
  part 'events — Svc.EventManager' : 'events — Svc.EventManager Def';
  satisfy 'SVC-CDHCORE-002' by 'events — Svc.EventManager';
  part def '$health — Svc.Health Def';
  part '$health — Svc.Health' : '$health — Svc.Health Def';
  satisfy 'SVC-CDHCORE-003' by '$health — Svc.Health';
  part def 'version — Svc.Version Def';
  part 'version — Svc.Version' : 'version — Svc.Version Def';
  satisfy 'SVC-CDHCORE-004' by 'version — Svc.Version';
  part def 'textLogger — Svc.PassiveTextLogger Def';
  part 'textLogger — Svc.PassiveTextLogger' : 'textLogger — Svc.PassiveTextLogger Def';
  satisfy 'SVC-CDHCORE-005' by 'textLogger — Svc.PassiveTextLogger';
  part def 'fatalAdapter — Svc.AssertFatalAdapter Def';
  part 'fatalAdapter — Svc.AssertFatalAdapter' : 'fatalAdapter — Svc.AssertFatalAdapter Def';
  satisfy 'SVC-CDHCORE-006' by 'fatalAdapter — Svc.AssertFatalAdapter';
  part def 'fatalHandler — configurable instance Def';
  part 'fatalHandler — configurable instance' : 'fatalHandler — configurable instance Def';
  satisfy 'SVC-CDHCORE-007' by 'fatalHandler — configurable instance';
  part def 'tlmSend — configurable instance Def';
  part 'tlmSend — configurable instance' : 'tlmSend — configurable instance Def';
  satisfy 'SVC-CDHCORE-008' by 'tlmSend — configurable instance';
  part def 'CdhCoreConfig / CdhCoreFatalHandlerConfig / CdhCoreTlmConfig Def';
  part 'CdhCoreConfig / CdhCoreFatalHandlerConfig / CdhCoreTlmConfig' : 'CdhCoreConfig / CdhCoreFatalHandlerConfig / CdhCoreTlmConfig Def';
  satisfy 'SVC-CDHCORE-009' by 'CdhCoreConfig / CdhCoreFatalHandlerConfig / CdhCoreTlmConfig';
  part def '$health.Run Def';
  part '$health.Run' : '$health.Run Def';
  satisfy 'SVC-CDHCORE-010' by '$health.Run';
  part def 'spacePacketFramer (Svc.Ccsds.SpacePacketFramer) Def';
  part 'spacePacketFramer (Svc.Ccsds.SpacePacketFramer)' : 'spacePacketFramer (Svc.Ccsds.SpacePacketFramer) Def';
  part def 'tmFramer (Svc.Ccsds.TmFramer) Def';
  part 'tmFramer (Svc.Ccsds.TmFramer)' : 'tmFramer (Svc.Ccsds.TmFramer) Def';
  part def 'frameAccumulator (Svc.FrameAccumulator) Def';
  part 'frameAccumulator (Svc.FrameAccumulator)' : 'frameAccumulator (Svc.FrameAccumulator) Def';
  part def 'fprimeRouter (Svc.FprimeRouter) Def';
  part 'fprimeRouter (Svc.FprimeRouter)' : 'fprimeRouter (Svc.FprimeRouter) Def';
  part def 'Subtopology (variant including Svc.ComStub) Def';
  part 'Subtopology (variant including Svc.ComStub)' : 'Subtopology (variant including Svc.ComStub) Def';
  part def 'FramingSubtopology (variant expecting external Svc.ComInterface) Def';
  part 'FramingSubtopology (variant expecting external Svc.ComInterface)' : 'FramingSubtopology (variant expecting external Svc.ComInterface) Def';
  part def 'ComCcsdsConfig module Def';
  part 'ComCcsdsConfig module' : 'ComCcsdsConfig module Def';
  satisfy 'SVC-COMCCSDS-006' by 'ComCcsdsConfig module';
  part def 'SpacePacketFraming topology Def';
  part 'SpacePacketFraming topology' : 'SpacePacketFraming topology Def';
  satisfy 'SVC-COMCCSDS-007' by 'SpacePacketFraming topology';
  part def 'SpacePacket topology Def';
  part 'SpacePacket topology' : 'SpacePacket topology Def';
  satisfy 'SVC-COMCCSDS-007' by 'SpacePacket topology';
  part def 'TmTcFraming topology Def';
  part 'TmTcFraming topology' : 'TmTcFraming topology Def';
  satisfy 'SVC-COMCCSDS-007' by 'TmTcFraming topology';
  part def 'framer — Svc.FprimeFramer Def';
  part 'framer — Svc.FprimeFramer' : 'framer — Svc.FprimeFramer Def';
  satisfy 'SVC-COMFPRIME-001' by 'framer — Svc.FprimeFramer';
  part def 'deframer — Svc.FprimeDeframer Def';
  part 'deframer — Svc.FprimeDeframer' : 'deframer — Svc.FprimeDeframer Def';
  satisfy 'SVC-COMFPRIME-002' by 'deframer — Svc.FprimeDeframer';
  part def 'router — Svc.FprimeRouter Def';
  part 'router — Svc.FprimeRouter' : 'router — Svc.FprimeRouter Def';
  satisfy 'SVC-COMFPRIME-003' by 'router — Svc.FprimeRouter';
  part def 'Subtopology Def';
  part 'Subtopology' : 'Subtopology Def';
  satisfy 'SVC-COMFPRIME-004' by 'Subtopology';
  part def 'FramingSubtopology Def';
  part 'FramingSubtopology' : 'FramingSubtopology Def';
  satisfy 'SVC-COMFPRIME-005' by 'FramingSubtopology';
  part def 'ComFprimeConfig Def';
  part 'ComFprimeConfig' : 'ComFprimeConfig Def';
  satisfy 'SVC-COMFPRIME-006' by 'ComFprimeConfig';
  part def 'dpMgr — Svc.DpManager, dpBufferManager Def';
  part 'dpMgr — Svc.DpManager, dpBufferManager' : 'dpMgr — Svc.DpManager, dpBufferManager Def';
  satisfy 'SVC-DATAPRODUCTS-001' by 'dpMgr — Svc.DpManager, dpBufferManager';
  part def 'dpWriter — Svc.DpWriter Def';
  part 'dpWriter — Svc.DpWriter' : 'dpWriter — Svc.DpWriter Def';
  satisfy 'SVC-DATAPRODUCTS-002' by 'dpWriter — Svc.DpWriter';
  part def 'dpCat — Svc.DpCatalog Def';
  part 'dpCat — Svc.DpCatalog' : 'dpCat — Svc.DpCatalog Def';
  satisfy 'SVC-DATAPRODUCTS-003' by 'dpCat — Svc.DpCatalog';
  part def 'dpBufferAccumulator — Svc.BufferAccumulator Def';
  part 'dpBufferAccumulator — Svc.BufferAccumulator' : 'dpBufferAccumulator — Svc.BufferAccumulator Def';
  satisfy 'SVC-DATAPRODUCTS-004' by 'dpBufferAccumulator — Svc.BufferAccumulator';
  part def 'DataProductsConfig (instance properties) Def';
  part 'DataProductsConfig (instance properties)' : 'DataProductsConfig (instance properties) Def';
  satisfy 'SVC-DATAPRODUCTS-005' by 'DataProductsConfig (instance properties)';
  part def 'Exposed *SchedIn topology ports Def';
  part 'Exposed *SchedIn topology ports' : 'Exposed *SchedIn topology ports Def';
  satisfy 'SVC-DATAPRODUCTS-006' by 'Exposed *SchedIn topology ports';
  part def 'dpCompressProc — Svc.DpCompressProc Def';
  part 'dpCompressProc — Svc.DpCompressProc' : 'dpCompressProc — Svc.DpCompressProc Def';
  satisfy 'SVC-DPCOMPRESSION-001' by 'dpCompressProc — Svc.DpCompressProc';
  part def 'dpZLibCompressor — Svc.DpZLibCompressor Def';
  part 'dpZLibCompressor — Svc.DpZLibCompressor' : 'dpZLibCompressor — Svc.DpZLibCompressor Def';
  satisfy 'SVC-DPCOMPRESSION-002' by 'dpZLibCompressor — Svc.DpZLibCompressor';
  part def 'dpZLibCompressorBufferManager — Svc.BufferManager Def';
  part 'dpZLibCompressorBufferManager — Svc.BufferManager' : 'dpZLibCompressorBufferManager — Svc.BufferManager Def';
  satisfy 'SVC-DPCOMPRESSION-003' by 'dpZLibCompressorBufferManager — Svc.BufferManager';
  part def 'DpCompressionConfig::ZLibBuffMgr constants Def';
  part 'DpCompressionConfig::ZLibBuffMgr constants' : 'DpCompressionConfig::ZLibBuffMgr constants Def';
  satisfy 'SVC-DPCOMPRESSION-004' by 'DpCompressionConfig::ZLibBuffMgr constants';
  part def 'dpZLibBufferManagerSchedIn topology port Def';
  part 'dpZLibBufferManagerSchedIn topology port' : 'dpZLibBufferManagerSchedIn topology port Def';
  satisfy 'SVC-DPCOMPRESSION-005' by 'dpZLibBufferManagerSchedIn topology port';
  part def 'cfdpManager (Svc.Ccsds.Cfdp.CfdpManager) Def';
  part 'cfdpManager (Svc.Ccsds.Cfdp.CfdpManager)' : 'cfdpManager (Svc.Ccsds.Cfdp.CfdpManager) Def';
  satisfy 'SVC-FILEHANDLINGCFDP-001' by 'cfdpManager (Svc.Ccsds.Cfdp.CfdpManager)';
  part def 'fileManager (Svc.FileManager) Def';
  part 'fileManager (Svc.FileManager)' : 'fileManager (Svc.FileManager) Def';
  satisfy 'SVC-FILEHANDLINGCFDP-002' by 'fileManager (Svc.FileManager)';
  part def 'prmDb (Svc.PrmDb) Def';
  part 'prmDb (Svc.PrmDb)' : 'prmDb (Svc.PrmDb) Def';
  satisfy 'SVC-FILEHANDLINGCFDP-003' by 'prmDb (Svc.PrmDb)';
  part def 'FileHandlingCfdpConfig (instance properties) Def';
  part 'FileHandlingCfdpConfig (instance properties)' : 'FileHandlingCfdpConfig (instance properties) Def';
  satisfy 'SVC-FILEHANDLINGCFDP-004' by 'FileHandlingCfdpConfig (instance properties)';
  part def 'run1Hz connection specifier for cfdpManager Def';
  part 'run1Hz connection specifier for cfdpManager' : 'run1Hz connection specifier for cfdpManager Def';
  satisfy 'SVC-FILEHANDLINGCFDP-005' by 'run1Hz connection specifier for cfdpManager';
  part def 'fileUplink — Svc.FileUplink Def';
  part 'fileUplink — Svc.FileUplink' : 'fileUplink — Svc.FileUplink Def';
  satisfy 'SVC-FILEHANDLING-001' by 'fileUplink — Svc.FileUplink';
  part def 'fileDownlink — Svc.FileDownlink Def';
  part 'fileDownlink — Svc.FileDownlink' : 'fileDownlink — Svc.FileDownlink Def';
  satisfy 'SVC-FILEHANDLING-002' by 'fileDownlink — Svc.FileDownlink';
  part def 'fileManager — Svc.FileManager Def';
  part 'fileManager — Svc.FileManager' : 'fileManager — Svc.FileManager Def';
  satisfy 'SVC-FILEHANDLING-003' by 'fileManager — Svc.FileManager';
  part def 'prmDb — Svc.PrmDb Def';
  part 'prmDb — Svc.PrmDb' : 'prmDb — Svc.PrmDb Def';
  satisfy 'SVC-FILEHANDLING-004' by 'prmDb — Svc.PrmDb';
  part def 'FileHandlingConfig (instance properties) Def';
  part 'FileHandlingConfig (instance properties)' : 'FileHandlingConfig (instance properties) Def';
  satisfy 'SVC-FILEHANDLING-005' by 'FileHandlingConfig (instance properties)';
  part def 'Run/scheduling connection specifiers Def';
  part 'Run/scheduling connection specifiers' : 'Run/scheduling connection specifiers Def';
  satisfy 'SVC-FILEHANDLING-006' by 'Run/scheduling connection specifiers';
}