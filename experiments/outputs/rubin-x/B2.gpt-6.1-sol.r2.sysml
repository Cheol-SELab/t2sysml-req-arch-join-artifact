package 'System' {
  requirement def 'DMSR-6957' { doc /* The DMS shall construct on an as-needed basis an image that corrects for any temporally stable bias structure that remains after overscan correction. The Bias Residual shall be constructed from multiple, zero-second exposures where the overscan correction has been applied. */ }
  requirement def 'DMSR-7349' { doc /* The DMS shall, on an as-needed basis, determine from appropriate calibration data what fraction of the signal detected in any given amplifier on each sensor in the focal plane appears in any other amplifier, and shall record that fraction in a correction matrix. The applicability of the correction matrix shall be verified in production processing on science data. */ }
  requirement def 'DMSR-7118' { doc /* The DMS shall produce on an as-needed basis an image that corrects for the non-uniform illumination of the flat-field calibration apparatus on the focal plane. The effectiveness of the Illumination Correction shall be verified in production processing on science data. */ }
  requirement def 'DMSR-7466' { doc /* The DMS shall produce on an as-needed basis an image that corrects for the color-dependent, pixel-to-pixel non-uniformity in the detector response. The images in the cube shall be constructed from exposures at multiple wavelengths of a uniformly illuminated source. The effectiveness of the flat-field shall be verified in production processing on science data. */ }
  requirement def 'DMSR-1633' { doc /* The DMS shall produce on an as-needed basis a dark current correction image, which is constructed from multiple, closed-shutter exposures of appropriate duration. The effectiveness of the Dark Correction shall be verified in production processing on science data. */ }
  requirement def 'DMSR-4608' { doc /* The DMS shall produce on an as-needed basis an image that corrects for detector fringing. The effectiveness of the Fringe Correction shall be verified in production processing on science data. */ }
  requirement def 'DMSR-3610' { doc /* The DMS shall provide for the use of a variety of shape models on multiple kinds of input data to measure sources: measurement on coadds; measurement on coadds using information (e.g., PSFs) extracted from the individual exposures; measurement based on all the information from the individual Exposures simultaneously. */ }
  requirement def 'DMSR-4919' { doc /* The DMS shall provide for the ability to process data from other electronic, pixel-oriented astronomical imaging cameras. */ }
  requirement def 'DMSR-4749' { doc /* The DMS shall provide software to perform image differencing, generating Difference Exposures from the comparison of single exposures and/or coadded images. */ }
  requirement def 'DMSR-8783' { doc /* The DMS shall provide software for the detection of sources in a calibrated image, which may be a Difference Image or a Co-Add image. */ }
  requirement def 'DMSR-4926' { doc /* An astrometric model shall be provided for every Object and DIAObject which specifies at least the proper motion and parallax, and the estimated uncertainties on these quantities. */ }
  requirement def 'DMSR-2737' { doc /* The DMS shall provide calibrated photometry in each observed passband for all measured entities (e.g., DIASources, Sources, Objects), measuring the AB magnitude of the equivalent flat-SED source, above the atmosphere. Fluxes, possibly in jansky, shall be calculated for all measured entities. */ }
  requirement def 'DMSR-5837' { doc /* The DMS shall provide software to represent the coordinate transformations relating the collimated beam projector position and telescope pupil position to the illumination position on the telescope optical elements and focal plane. */ }
  requirement def 'DMSR-7886' { doc /* The DMS shall, in the course of creating the master Source Catalog, create a catalog from the coadds of all sources detected in each passband with a SNR > coaddDetectThresh. */ }
  requirement def 'DMSR-6165' { doc /* Coadd Images shall be created by combining spatially overlapping Processed Visit Images (on which bad pixels and transient sources have been masked), where the contributing Processed Visit Images have been re-projected to a common reference geometry, and matched to a common background level which best approximates the astrophysical background. */ }
  requirement def 'DMSR-4909' { doc /* Best seeing coadds shall be made for each band (including multi-color). */ }
  requirement def 'DMSR-2803' { doc /* One (ugrizy plus multi-band) set of PSF-matched coadds shall be made but shall not be archived. */ }
  requirement def 'DMSR-5774' { doc /* The DMS shall be able to detect faint objects showing long-term variability, or nearby object with high proper motions. */ }
  requirement def 'DMSR-7937' { doc /* The DMS shall determine a characterization of the PSF for any specified location in coadded images. */ }
  requirement def 'DMSR-6393' { doc /* For each Coadded Image, DMS shall store: the list of input images and the pipeline parameters, including software versions, used to derive it, and a sufficient set of metadata attributes for users to re-create them in whole or in part. */ }
  requirement def 'DMSR-8352' { doc /* It shall be possible to detect extended low surface brightness objects in coadds. */ }
  requirement def 'DMSR-9950' { doc /* The Base to Archive communications shall be highly reliable, with MTTR < baseToArchNetMTTR. */ }
  requirement def 'DMSR-9081' { doc /* The Base to Archive communications shall provide secondary link or transport mechanism (e.g. protected circuit) for operations support and ”catch up” in the event of extended outage. This secondary link shall be capable of ”bursting” to at least twice the capacity of the primary link. */ }
  requirement def 'DMSR-4835' { doc /* The DMS shall provide communications infrastructure between the Archive Center and Data Access Centers sufficient to carry scientific data and associated metadata in support of community and EPO access. Aggregate bandwidth for data transfers from the Archive Center to Data Centers shall be at least archToDacBandwidth. */ }
  requirement def 'DMSR-5865' { doc /* The Archive to Data Access Center communications shall be highly available, with MTBF > archToDacNetMTBF. */ }
  requirement def 'DMSR-2330' { doc /* The Archive to Data Access Center communications shall be highly reliable, with MTTR < archToDacNetMTTR. */ }
  requirement def 'DMSR-5282' { doc /* The Archive to Data Access Center communications shall provide secondary link or transport mechanism (e.g. protected circuit) for operations support and ”catch up” in the event of extended outage. */ }
  requirement def 'DMSR-7661' { doc /* The Data Access Centers shall provide computing, storage, and network infrastructure to support open access to LSST data products (with provenance) by end users. */ }
  requirement def 'DMSR-6213' { doc /* A service shall be provided to publish to the community the next visit location and the predicted visit schedule provided by the OCS. This service shall consist of both a web page for human inspection and a web API to allow automated tools to respond promptly. */ }
  part def 'Prompt Processing Ingest Def';
  part 'Prompt Processing Ingest' : 'Prompt Processing Ingest Def';
  part def 'Prompt Processing Def';
  part 'Prompt Processing' : 'Prompt Processing Def';
  part def 'Telemetry Gateway Def';
  part 'Telemetry Gateway' : 'Telemetry Gateway Def';
  part def 'Prompt Base Enclave Def';
  part 'Prompt Base Enclave' : 'Prompt Base Enclave Def';
  part def 'Archiving Def';
  part 'Archiving' : 'Archiving Def';
  part def 'Image Ingest and Processing Def';
  part 'Image Ingest and Processing' : 'Image Ingest and Processing Def';
  part def 'Archive Base Enclave Def';
  part 'Archive Base Enclave' : 'Archive Base Enclave Def';
  part def 'Archive NCSA Enclave Def';
  part 'Archive NCSA Enclave' : 'Archive NCSA Enclave Def';
  part def 'Prompt NCSA Enclave Def';
  part 'Prompt NCSA Enclave' : 'Prompt NCSA Enclave Def';
  part def 'Observatory Operations Data Def';
  part 'Observatory Operations Data' : 'Observatory Operations Data Def';
  part def 'Observatory Operations Data Service SW Def';
  part 'Observatory Operations Data Service SW' : 'Observatory Operations Data Service SW Def';
  part def 'Science Pipelines Distribution Def';
  part 'Science Pipelines Distribution' : 'Science Pipelines Distribution Def';
  satisfy 'DMSR-6957' by 'Science Pipelines Distribution';
  satisfy 'DMSR-7349' by 'Science Pipelines Distribution';
  satisfy 'DMSR-7118' by 'Science Pipelines Distribution';
  satisfy 'DMSR-7466' by 'Science Pipelines Distribution';
  satisfy 'DMSR-1633' by 'Science Pipelines Distribution';
  satisfy 'DMSR-4608' by 'Science Pipelines Distribution';
  part def 'Base Facility Def';
  part 'Base Facility' : 'Base Facility Def';
  part def 'NCSA Facility Def';
  part 'NCSA Facility' : 'NCSA Facility Def';
  part def 'Offline Production Enclave Def';
  part 'Offline Production Enclave' : 'Offline Production Enclave Def';
  part def 'Science Pipelines Libraries Def';
  part 'Science Pipelines Libraries' : 'Science Pipelines Libraries Def';
  satisfy 'DMSR-3610' by 'Science Pipelines Libraries';
  satisfy 'DMSR-4919' by 'Science Pipelines Libraries';
  satisfy 'DMSR-4749' by 'Science Pipelines Libraries';
  satisfy 'DMSR-8783' by 'Science Pipelines Libraries';
  satisfy 'DMSR-4926' by 'Science Pipelines Libraries';
  satisfy 'DMSR-2737' by 'Science Pipelines Libraries';
  satisfy 'DMSR-5837' by 'Science Pipelines Libraries';
  part def 'Alert Distribution Def';
  part 'Alert Distribution' : 'Alert Distribution Def';
  part def 'Alert Distribution SW Def';
  part 'Alert Distribution SW' : 'Alert Distribution SW Def';
  part def 'Alert Production Def';
  part 'Alert Production' : 'Alert Production Def';
  part def 'Data Release Production Def';
  part 'Data Release Production' : 'Data Release Production Def';
  satisfy 'DMSR-7886' by 'Data Release Production';
  satisfy 'DMSR-6165' by 'Data Release Production';
  satisfy 'DMSR-4909' by 'Data Release Production';
  satisfy 'DMSR-2803' by 'Data Release Production';
  satisfy 'DMSR-5774' by 'Data Release Production';
  part def 'Science Plugins Def';
  part 'Science Plugins' : 'Science Plugins Def';
  satisfy 'DMSR-6957' by 'Science Plugins';
  satisfy 'DMSR-7349' by 'Science Plugins';
  satisfy 'DMSR-7118' by 'Science Plugins';
  satisfy 'DMSR-7466' by 'Science Plugins';
  satisfy 'DMSR-1633' by 'Science Plugins';
  satisfy 'DMSR-4608' by 'Science Plugins';
  part def 'LSP Web API Def';
  part 'LSP Web API' : 'LSP Web API Def';
  part def 'LSP Web API SW Def';
  part 'LSP Web API SW' : 'LSP Web API SW Def';
  part def 'Image/Cutout Server Def';
  part 'Image/Cutout Server' : 'Image/Cutout Server Def';
  part def 'DBB Ingest/Metadata Management Def';
  part 'DBB Ingest/Metadata Management' : 'DBB Ingest/Metadata Management Def';
  part def 'DBB Ingest/Metadata Management SW Def';
  part 'DBB Ingest/Metadata Management SW' : 'DBB Ingest/Metadata Management SW Def';
  part def 'Distributed Database Def';
  part 'Distributed Database' : 'Distributed Database Def';
  part def 'ADQL Translator Def';
  part 'ADQL Translator' : 'ADQL Translator Def';
  part def 'DAC Chile Enclave Def';
  part 'DAC Chile Enclave' : 'DAC Chile Enclave Def';
  part def 'DAC US Enclave Def';
  part 'DAC US Enclave' : 'DAC US Enclave Def';
  part def 'DBB Storage Def';
  part 'DBB Storage' : 'DBB Storage Def';
  part def 'DBB Transport/Replication/Backup Def';
  part 'DBB Transport/Replication/Backup' : 'DBB Transport/Replication/Backup Def';
  part def 'DBB Transport/Replication/Backup SW Def';
  part 'DBB Transport/Replication/Backup SW' : 'DBB Transport/Replication/Backup SW Def';
  part def 'MOPS and Forced Photometry Def';
  part 'MOPS and Forced Photometry' : 'MOPS and Forced Photometry Def';
  part def 'Bulk Distribution Def';
  part 'Bulk Distribution' : 'Bulk Distribution Def';
  part def 'LSP Portal Def';
  part 'LSP Portal' : 'LSP Portal Def';
  part def 'LSP JupyterLab Def';
  part 'LSP JupyterLab' : 'LSP JupyterLab Def';
  part def 'SUIT Def';
  part 'SUIT' : 'SUIT Def';
  part def 'LSP JupyterLab SW Def';
  part 'LSP JupyterLab SW' : 'LSP JupyterLab SW Def';
  part def 'Data Butler Def';
  part 'Data Butler' : 'Data Butler Def';
  part def 'Task Framework Def';
  part 'Task Framework' : 'Task Framework Def';
  part def 'OCS-Driven Batch Def';
  part 'OCS-Driven Batch' : 'OCS-Driven Batch Def';
  part def 'OCS Batch SW Def';
  part 'OCS Batch SW' : 'OCS Batch SW Def';
  part def 'Calibration SW Def';
  part 'Calibration SW' : 'Calibration SW Def';
  satisfy 'DMSR-7937' by 'Calibration SW';
  satisfy 'DMSR-6393' by 'Calibration SW';
  satisfy 'DMSR-7886' by 'Calibration SW';
  satisfy 'DMSR-6165' by 'Calibration SW';
  satisfy 'DMSR-4909' by 'Calibration SW';
  satisfy 'DMSR-2803' by 'Calibration SW';
  satisfy 'DMSR-5774' by 'Calibration SW';
  satisfy 'DMSR-8352' by 'Calibration SW';
  part def 'Batch Production Def';
  part 'Batch Production' : 'Batch Production Def';
  part def 'Campaign Management Def';
  part 'Campaign Management' : 'Campaign Management Def';
  part def 'Workload/Workflow Management Def';
  part 'Workload/Workflow Management' : 'Workload/Workflow Management Def';
  part def 'Commissioning Cluster Enclave Def';
  part 'Commissioning Cluster Enclave' : 'Commissioning Cluster Enclave Def';
  part def 'EFD Transformation Def';
  part 'EFD Transformation' : 'EFD Transformation Def';
  part def 'Summit to Base Network Def';
  part 'Summit to Base Network' : 'Summit to Base Network Def';
  part def 'Base to Archive Network Def';
  part 'Base to Archive Network' : 'Base to Archive Network Def';
  satisfy 'DMSR-9950' by 'Base to Archive Network';
  satisfy 'DMSR-9081' by 'Base to Archive Network';
  satisfy 'DMSR-4835' by 'Base to Archive Network';
  satisfy 'DMSR-5865' by 'Base to Archive Network';
  satisfy 'DMSR-2330' by 'Base to Archive Network';
  satisfy 'DMSR-5282' by 'Base to Archive Network';
  part def 'Base LAN Network Def';
  part 'Base LAN Network' : 'Base LAN Network Def';
  part def 'NCSA LAN Network Def';
  part 'NCSA LAN Network' : 'NCSA LAN Network Def';
  satisfy 'DMSR-4835' by 'NCSA LAN Network';
  satisfy 'DMSR-5865' by 'NCSA LAN Network';
  satisfy 'DMSR-2330' by 'NCSA LAN Network';
  satisfy 'DMSR-5282' by 'NCSA LAN Network';
  satisfy 'DMSR-7661' by 'NCSA LAN Network';
  part def 'Network Management Def';
  part 'Network Management' : 'Network Management Def';
  part def 'Template Generation Def';
  part 'Template Generation' : 'Template Generation Def';
  part def 'DBB Lifetime Management Def';
  part 'DBB Lifetime Management' : 'DBB Lifetime Management Def';
  part def 'DBB Lifetime Management SW Def';
  part 'DBB Lifetime Management SW' : 'DBB Lifetime Management SW Def';
  part def 'Prompt Quality Control Def';
  part 'Prompt Quality Control' : 'Prompt Quality Control Def';
  part def 'Quality Control SW Def';
  part 'Quality Control SW' : 'Quality Control SW Def';
  part def 'Header Service SW Def';
  part 'Header Service SW' : 'Header Service SW Def';
  part def 'Planned Observation Publication Def';
  part 'Planned Observation Publication' : 'Planned Observation Publication Def';
  satisfy 'DMSR-6213' by 'Planned Observation Publication';
  part def 'Planned Observation Publication SW Def';
  part 'Planned Observation Publication SW' : 'Planned Observation Publication SW Def';
  satisfy 'DMSR-6213' by 'Planned Observation Publication SW';
  part def 'Special Programs Productions Def';
  part 'Special Programs Productions' : 'Special Programs Productions Def';
}