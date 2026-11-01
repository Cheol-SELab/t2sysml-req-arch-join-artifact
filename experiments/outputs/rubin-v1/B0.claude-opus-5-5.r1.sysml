package 'System' {
  requirement def 'DMSR-6213' { doc /* A service shall be provided to publish to the community the next visit location and the predicted visit schedule provided by the OCS. This service shall consist of both a web page for human inspection and a web API to allow automated tools to respond promptly. */ }
  requirement def 'DMSR-6009' { doc /* Identified transient events shall be made available to end-users in the form of alerts, which shall be published to community alert distribution networks using community-standard protocols, to be determined during the LSST construction phase as community standards evolve. */ }
  requirement def 'DMSR-7154' { doc /* With the exception of alerts and Solar System Objects, all Level 1 Data Products shall be made public within time L1PublicT of the acquisition of the raw image data. LSST shall not release image or catalog data resulting from a visit, except for the content of the public alert stream, sooner than time L1PublicTMin following the acquisition of the raw image data from that visit. For visits resulting in fewer than nAlertVisitPeak, LSST shall be capable of supporting the distribution of at least OTR1 per cent of alerts via the LSST alert distribution system within time OTT1 from the conclusion of the camera's readout of the raw exposures used to generate each alert. Solar System Object orbits will, on average, be calculated before the following night's observing finishes and the results shall be made available within time L1PublicT of those calculations being completed. */ }
  requirement def 'DMSR-4419' { doc /* Except in cases of major disaster, the DMS shall have no unscheduled outages of the DMS pipelines extending over a period greater than productionMaxDowntime. A major disaster is defined as a natural disaster or act of war (e.g. flood, fire, hostile acts) that compromises or threatens to compromise the health and integrity of the DMS physical facility, computing equipment, or operational personnel. */ }
  requirement def 'DMSR-4245' { doc /* Within a fixed cost envelope for the Data Management subsystem, the allocation of processing and storage facilities will optimize reliability over availability to end users. */ }
  requirement def 'DMSR-7084' { doc /* The infrastructure will be sized such that the net throughput of the data processing pipelines will permit a complete processing of a night's observing data prior to the start of the next observing night, assuming no system outages. */ }
  requirement def 'DMSR-4278' { doc /* The infrastructure will incorporate sufficient capability for self-diagnostics and recovery to provide for continuation of processing in the event of partial hardware or software failures. */ }
  requirement def 'DMSR-6707' { doc /* At any given LSST computational facility the DMS shall be capable of operations on a heterogeneous cluster of machines. The hardware, operating system, and other machine parameters shall be limited to a project-approved set. */ }
  requirement def 'DMSR-4837' { doc /* The Data Management subsystem shall be designed to facilitate unplanned repair activities expected not to exceed DMDowntime days per year. */ }
  requirement def 'DMSR-3618' { doc /* A basic, limited capacity, alert filtering service shall be provided that can be given user defined filters to reduce the alert stream to manageable levels. */ }
  requirement def 'DMSR-3546' { doc /* The LSST alert filtering service shall support numBrokerUsers simultaneous users with each user allocated a bandwidth capable of receiving the equivalent of numBrokerAlerts alerts per visit. */ }
  requirement def 'DMSR-3391' { doc /* Users of the LSST Alert Filtering Service shall be able to use a predefined set of simple filters. */ }
  requirement def 'DMSR-5029' { doc /* The DMS shall generate a nightly Data Quality Report within time dqReportComplTime in both human-readable and machine-readable forms. */ }
  requirement def 'DMSR-2465' { doc /* The DMS shall produce a Level 1 Data Quality Report that contains indicators of data quality that result from running the DMS pipelines, including at least: Photometric zero point vs. time for each utilized filter; Sky brightness vs. time for each utilized filter; seeing vs. time for each utilized filter; PSF parameters vs. time for each utilized filter; detection efficiency for point sources vs. mag for each utilized filter. */ }
  requirement def 'DMSR-1305' { doc /* The DMS shall generate a nightly DMS Performance Report within time perfReportComplTime in both human-readable and machine-readable forms. */ }
  requirement def 'DMSR-5074' { doc /* The DMS shall produce a Level 1 Performance Report that provides indicators of how the DMS has performed in processing the night's observations, including at least: number of observations successfully processed through each pipeline; number of observations for each pipeline that had recoverable failures (with a record of the failure type and recovery mechanism); number of observations for each pipeline that had unrecoverable failures; number of observations archived at each DMS Facility; number of observations satisfying the science criteria for each active science program. */ }
  requirement def 'DMSR-7078' { doc /* The DMS shall generate a nightly Calibration Report within time calibReportComplTime in both human-readable and machine-readable forms. */ }
  requirement def 'DMSR-7584' { doc /* The DMS shall produce a Level 1 Calibration Report that provides a summary of significant differences in Calibration Images that may indicate evolving problems with the telescope or camera, including a nightly broad-band flat in each filter. */ }
  requirement def 'DMSR-1031' { doc /*  */ }
  requirement def 'DMSR-4915' { doc /* The DMS shall provide Processing, Storage, and Network resources capable of executing the DMS Data Release Production over all pre-existing survey data in a time no greater than drProcessingPeriod, without impacting observatory operations. */ }
  requirement def 'DMSR-9393' { doc /* The DMS shall process all requested datasets until either a successful result is recorded or a permanent failure is recognized. If any dataset is processed, in part or in whole, more than once, only one of the wholly processed results will be recorded for further processing. */ }
  requirement def 'DMSR-5060' { doc /* The DMS shall provide software to orchestrate execution of productions, including deploying pipelines on a computing platform. */ }
  requirement def 'DMSR-4277' { doc /* The DMS shall provide software to monitor execution of pipelines in real time. */ }
  requirement def 'DMSR-1395' { doc /* The DMS shall provide software to detect faults in pipeline execution and recover when possible. */ }
  requirement def 'DMSR-5224' { doc /* The DMS shall enable applications to process every record in a table meeting user-specified criteria exactly once. */ }
  requirement def 'DMSR-5732' { doc /* The DMS software architecture shall be designed to enable high throughput on high-performance compute platforms, while also enabling the use of science-specific algorithms by science users on commodity desktop compute platforms. */ }
  requirement def 'DMSR-3130' { doc /* The Data Management System shall provide tools to re-run a data processing operation under the same conditions as a previous run of that operation, based on provenance data recorded by the system. */ }
  requirement def 'DMSR-6271' { doc /* A re-run based on provenance, if run on the same system or a system with identically configured hardware and system software, shall produce the same results (with the exception of provenance data or other execution records that depend on the wall-clock time or on variable system loads). */ }
  requirement def 'DMSR-9691' { doc /* A re-run based on provenance, if run on a different system (but whose configuration still meets established LSST requirements), shall produce results which are the same to the extent computationally feasible (with the exception of provenance data or other execution records that depend on the wall-clock time or on variable system loads). */ }
  requirement def 'DMSR-9522' { doc /* The Data Management System shall archive all processing provenance associated with archived data products, including relevant data from other subsystems. */ }
  requirement def 'DMSR-6641' { doc /* The DMS shall periodically create Template Images in each of the u,g,r,i,z,y passbands that are constructed identically to Deep Detection Coadds, but where the contributing Calibrated Exposures are limited to a range of observing epochs templateMaxTimespan, the images are partitioned by airmass into multiple bins, and where the quality criteria may be different. */ }
  requirement def 'DMSR-8515' { doc /* It shall be possible for special programs to trigger their own data processing recipes. It shall also be possible for special programs data to be processed with the prompt- and/or annual-release pipelines alongside data from the main survey. */ }
  requirement def 'DMSR-4733' { doc /* Data products for special programs shall be stored in databases that are distinct from those used to store standard Level 1 and Level 2 data products. It shall be possible for these databases to be federated with the Level 1 and Level 2 databases to allow cross-queries and joins. */ }
  requirement def 'DMSR-8454' { doc /* The DMS shall produce on an as-needed basis a map of detector pixels that are affected by one or more pathologies, such as non-responsive pixels, charge traps, and hot pixels. The particular pathologies shall be bit-encoded in, at least, 32-bit pixel values, so that additional pathologies may also be recorded in down-stream processing software. */ }
  requirement def 'DMSR-6957' { doc /* The DMS shall construct on an as-needed basis an image that corrects for any temporally stable bias structure that remains after overscan correction. The Bias Residual shall be constructed from multiple, zero-second exposures where the overscan correction has been applied. */ }
  requirement def 'DMSR-7349' { doc /* The DMS shall, on an as-needed basis, determine from appropriate calibration data what fraction of the signal detected in any given amplifier on each sensor in the focal plane appears in any other amplifier, and shall record that fraction in a correction matrix. The applicability of the correction matrix shall be verified in production processing on science data. */ }
  requirement def 'DMSR-7118' { doc /* The DMS shall produce on an as-needed basis an image that corrects for the non-uniform illumination of the flat-field calibration apparatus on the focal plane. The effectiveness of the Illumination Correction shall be verified in production processing on science data. */ }
  requirement def 'DMSR-7466' { doc /* The DMS shall produce on an as-needed basis an image that corrects for the color-dependent, pixel-to-pixel non-uniformity in the detector response. The images in the cube shall be constructed from exposures at multiple wavelengths of a uniformly illuminated source. The effectiveness of the flat-field shall be verified in production processing on science data. */ }
  requirement def 'DMSR-5126' { doc /* The DMS shall produce and archive Calibration Data Products that capture the signature of the telescope, camera and detector, including at least: Crosstalk correction matrix, Bias and Dark correction frames, a set of monochromatic dome flats spanning the wavelength range, a synthetic broad-band flat per filter, and an illumination correction frame per filter. */ }
  requirement def 'DMSR-1575' { doc /* Calibration products from a group of up to nCalExpProc related exposures that should be processed together, shall be available from the DMS image archive within calProcTime of the end of the acquisition of images/data for that group. */ }
  requirement def 'DMSR-1929' { doc /* For each Calibration Production data product, DMS shall record: the list of input exposures and the range of dates over which they were obtained; the processing parameters; the calibration products used to derive it; and a set of metadata attributes including at least: the date of creation; the calibration image type (e.g. dome flat, superflat, bias, etc); the provenance of the processing software; and the instrument configuration including the filter in use, if applicable. */ }
  requirement def 'DMSR-2104' { doc /* The DMS shall acquire raw, full-frame exposures from the camera guider sensors during calibration. The DMS shall produce calibration data products for the guide sensors. */ }
  requirement def 'DMSR-1633' { doc /* The DMS shall produce on an as-needed basis a dark current correction image, which is constructed from multiple, closed-shutter exposures of appropriate duration. The effectiveness of the Dark Correction shall be verified in production processing on science data. */ }
  requirement def 'DMSR-4608' { doc /* The DMS shall produce on an as-needed basis an image that corrects for detector fringing. The effectiveness of the Fringe Correction shall be verified in production processing on science data. */ }
  requirement def 'DMSR-2704' { doc /* The DMS shall be capable of producing calibration data products on an as-needed basis, consistent with monitoring the health and performance of the instrument, the availability of raw calibration exposures, the temporal stability of the calibrations, and of the SRD requirements for calibration accuracy. */ }
  requirement def 'DMSR-4282' { doc /* Detected moving objects and associated metadata shall be available for public access in the DMS science data archive within time L1PublicT of their generation by the DMS. */ }
  requirement def 'DMSR-9267' { doc /* The DMS shall produce a catalog of all Solar System Objects (SSObjects) that have been identified via Moving Object Processing. The SSObject catalog shall include for each entry attributes including at least the following: Osculating orbital elements and associated uncertainties, minimum orbit intersection distance (MOID), mean absolute magnitude and slope parameter per band and associated errors, and flags that describe conditions of the description. */ }
  requirement def 'DMSR-5020' { doc /* Upon identifying a new SSObject, the DMS shall associate additional DIAObjects that are consistent with the orbital parameters (precovery), and update DIAObject entries so associated. */ }
  requirement def 'DMSR-6426' { doc /* For all DIASources not associated with either DIAObjects or SSObjects, the DMS shall perform forced photometry at the location of the new source (precovery) on all Difference Exposures obtained in the prior precoveryWindow, and make the results publicly available within L1PublicT. */ }
  requirement def 'DMSR-4925' { doc /* It shall be possible for DMS to make use of approved external catalogs and observations to improve the identification of SSObjects, and therefore increase the purity of the transient Alert stream in nightly processing. */ }
  requirement def 'DMSR-7738' { doc /* The DMS shall create a DIAForcedSource Catalog, consisting of measured fluxes for entries in the DIAObject Catalog on Difference Exposures. Measurements for each forced-source shall include the DIAObject and visit IDs, the modeled flux and error (given fixed position, shape, and deblending parameters), and measurement quality flags. */ }
  requirement def 'DMSR-5583' { doc /* For alert production, DIAObject variability characterization shall include data collected during the time period from the present to at least diaCharacterizationCutoff in the past. */ }
  requirement def 'DMSR-5225' { doc /* All Level 1 processing from special programs shall be completed before data arrives from the following night's observations. */ }
  requirement def 'DMSR-1346' { doc /* A "precovery service" shall be available to end-users to request precovery for a provided sky location across all previous visits, making the results available within precoveryServiceElapsed hours of the request and supporting at least precoveryServicePeakUsers submissions per hour. */ }
  requirement def 'DMSR-6637' { doc /* The publishing of Level 1 data products from Special Programs shall be subject to the same performance requirements of the standard Level 1 system. In particular L1PublicT and OTT1. */ }
  requirement def 'DMSR-6886' { doc /* The infrastructure will be sized such that after outages, "catch up" processing of the temporarily stored raw image data may occur at the rate of one night's observing data processed per day, without interrupting the current day's observatory operations. */ }
  requirement def 'DMSR-5747' { doc /* The infrastructure will incorporate as fault-tolerance features to prevent loss of data in the event of hardware or software failure. */ }
  requirement def 'DMSR-5883' { doc /* The DMS shall provide data communications infrastructure to accept science data and associated metadata read-outs, and the collection of ancillary and engineering data, for transfer to the base facility. */ }
  requirement def 'DMSR-6601' { doc /* The DMS shall provide communications infrastructure between the Summit Facility and the Base Facility sufficient to carry scientific data and associated metadata for each image in no more than time summToBaseMaxTransferTime. */ }
  requirement def 'DMSR-6358' { doc /* The Summit to Base communications shall be highly available, with Mean Time Between Failures (MTBF) > summToBaseNetMTBF. */ }
  requirement def 'DMSR-3877' { doc /* The Summit to Base communications shall be highly reliable, with Mean Time to Repair (MTTR) < summToBaseNetMTTR. */ }
  requirement def 'DMSR-8923' { doc /* The Summit to Base communications shall provide at least one secondary link or transport mechanism for minimal operations support in the event of extended outage. This link may include redundant fiber optics, microwaves, or transportable media. It shall be capable of transferring one night's worth of raw data in summToBaseNet2TransMax or less. */ }
  requirement def 'DMSR-8544' { doc /* The Summit to Base communications link shall be owned and operated by LSST and/or the operations entity to ensure responsiveness of support. */ }
  requirement def 'DMSR-1253' { doc /* The DMS shall provide communications infrastructure between the Base Facility and the Archive Center sufficient to carry scientific data and associated metadata for each image in no more than time baseToArchiveMaxTransferTime. */ }
  requirement def 'DMSR-5740' { doc /* The Base to Archive communications shall be highly available, with MTBF > baseToArchNetMTBF. */ }
  requirement def 'DMSR-9950' { doc /* The Base to Archive communications shall be highly reliable, with MTTR < baseToArchNetMTTR. */ }
  requirement def 'DMSR-9081' { doc /* The Base to Archive communications shall provide secondary link or transport mechanism (e.g. protected circuit) for operations support and "catch up" in the event of extended outage. This secondary link shall be capable of "bursting" to at least twice the capacity of the primary link. */ }
  requirement def 'DMSR-4835' { doc /* The DMS shall provide communications infrastructure between the Archive Center and Data Access Centers sufficient to carry scientific data and associated metadata in support of community and EPO access. Aggregate bandwidth for data transfers from the Archive Center to Data Centers shall be at least archToDacBandwidth. */ }
  requirement def 'DMSR-5865' { doc /* The Archive to Data Access Center communications shall be highly available, with MTBF > archToDacNetMTBF. */ }
  requirement def 'DMSR-2330' { doc /* The Archive to Data Access Center communications shall be highly reliable, with MTTR < archToDacNetMTTR. */ }
  requirement def 'DMSR-5282' { doc /* The Archive to Data Access Center communications shall provide secondary link or transport mechanism (e.g. protected circuit) for operations support and "catch up" in the event of extended outage. */ }
  requirement def 'DMSR-7661' { doc /* The Data Access Centers shall provide computing, storage, and network infrastructure to support open access to LSST data products (with provenance) by end users. */ }
  requirement def 'DMSR-5606' { doc /* At least dacMinConnections simultaneous connections shall be supported at each Data Access Center. */ }
  requirement def 'DMSR-6362' { doc /* The Base LAN shall provide minBaseWiFi Wireless LAN (WiFi) and Wireless Access Points in the Base Facility to support connectivity of individual user's computers to the network backbones. */ }
  requirement def 'DMSR-8498' { doc /* The DMS shall provide a means for recording provenance information for Level 3 processing that is performed at DACs, covering at least all the DMS-provided inputs to the processing (e.g., catalog data used as inputs, dataset metadata, calibrations and camera data from the EFD). */ }
  requirement def 'DMSR-1890' { doc /* The DMS shall provide a software framework that facilitates Level 3 processing of catalogs. This framework shall provide a means for applying user-provided processing to catalog data, including measuring and ensuring the completeness of the application - i.e., that the specified processing was applied to all of, and only, the entire contents of the desired catalog(s). */ }
  requirement def 'DMSR-2006' { doc /* The DMS shall provide a software framework that facilitates Level 3 processing of image data. This framework shall provide a means for applying user-provided processing to image data, including measuring and ensuring the completeness of the application - i.e., that the specified processing was applied to all of, and only, the entire contents of the desired dataset. */ }
  requirement def 'DMSR-7045' { doc /* A Dataset may consist of one or more pixel images, a set of records in a file or database, or any other grouping of data that are processed or produced as a logical unit. The DMS shall be able to identify and retrieve complete, consistent datasets for processing. */ }
  requirement def 'DMSR-6199' { doc /* The DMS shall provide an interface that allows retrieval by productions or science users of datasets from any Facility where they may reside without requiring reconfiguration. */ }
  requirement def 'DMSR-4919' { doc /* The DMS shall provide for the ability to process data from other electronic, pixel-oriented astronomical imaging cameras. */ }
  requirement def 'DMSR-2078' { doc /*  */ }
  requirement def 'DMSR-7893' { doc /* The DMS shall provide software to define (and redefine without recompilation) a pipeline task containing a science algorithm, which may in turn consist of the execution of other subtasks. */ }
  requirement def 'DMSR-1156' { doc /* The DMS shall provide software to define, override components of, and verify the suitability of the configuration for a task. */ }
  requirement def 'DMSR-9728' { doc /* The DMS shall provide low-latency storage for un-archived data products of at least l1CacheLifetime to enable efficient precovery and other Level-1 production measurements. */ }
  requirement def 'DMSR-5359' { doc /* All per-band deep coadds and best seeing coadds shall be kept indefinitely and made available to users. */ }
  requirement def 'DMSR-4892' { doc /* It shall be possible to retain small sections of all generated coadds. */ }
  requirement def 'DMSR-8123' { doc /* Small, overlapping, samples of data from older releases shall be kept loaded in the database. */ }
  requirement def 'DMSR-9242' { doc /* All raw data used to generate any public data product (raw exposures, calibration frames, telemetry, configuration metadata, etc.) shall be kept and made available for download. */ }
  requirement def 'DMSR-7380' { doc /* The DMS shall be able to archive a designated subset of Camera test data and make it available in an environment matching the data backbone interfaces. */ }
  requirement def 'DMSR-4707' { doc /* The Data Management System shall make the archived provenance data available to science users together with the associated science data products. */ }
  requirement def 'DMSR-7026' { doc /* The DMS shall provide a service for Image Access through community data access protocols, to support programmatic search and retrieval of images or image cut-outs. The service shall support one or more community standard formats, including the LSST pipeline input format. */ }
  requirement def 'DMSR-3481' { doc /* The DMS shall provide access to all Level 1 and Level 2 image products through the LSST project's Data Access Centers, and any others that have been established and funded, for Level 3 processing that takes place at the DACs. */ }
  requirement def 'DMSR-2624' { doc /*  */ }
  requirement def 'DMSR-2318' { doc /* The DMS shall provide software for Data Access Services to list and retrieve image, file, and catalog data products (including raw telescope images and calibration data), their associated metadata, their provenance, or any combination thereof, independent of their actual storage location. */ }
  requirement def 'DMSR-4370' { doc /* The DMS shall be able to regenerate unarchived data products to within scientifically reasonable tolerances. */ }
  requirement def 'DMSR-8228' { doc /* The DMS shall be able to regenerate data products from previous data releases to within scientifically reasonable tolerances. */ }
  requirement def 'DMSR-1519' { doc /* Nothing in the design and software implementation of the data access services shall prevent the performance requirements set forth in OSS-REQ-0180 and OSS-REQ-0181 from being met for the "older Data Releases" referred to in DMSR-5792, subject to the provision of sufficient computing and storage resources in the operations era. */ }
  part def 'Planned Observation Publication Def';
  part 'Planned Observation Publication' : 'Planned Observation Publication Def';
  satisfy 'DMSR-6213' by 'Planned Observation Publication';
  part def 'Alert Distribution Def';
  part 'Alert Distribution' : 'Alert Distribution Def';
  satisfy 'DMSR-6009' by 'Alert Distribution';
  satisfy 'DMSR-7154' by 'Alert Distribution';
  satisfy 'DMSR-4419' by 'Alert Distribution';
  satisfy 'DMSR-4245' by 'Alert Distribution';
  satisfy 'DMSR-7084' by 'Alert Distribution';
  satisfy 'DMSR-4278' by 'Alert Distribution';
  satisfy 'DMSR-6707' by 'Alert Distribution';
  satisfy 'DMSR-4837' by 'Alert Distribution';
  satisfy 'DMSR-3618' by 'Alert Distribution';
  satisfy 'DMSR-3546' by 'Alert Distribution';
  satisfy 'DMSR-3391' by 'Alert Distribution';
  part def 'Prompt Quality Control Def';
  part 'Prompt Quality Control' : 'Prompt Quality Control Def';
  satisfy 'DMSR-5029' by 'Prompt Quality Control';
  satisfy 'DMSR-2465' by 'Prompt Quality Control';
  satisfy 'DMSR-1305' by 'Prompt Quality Control';
  satisfy 'DMSR-5074' by 'Prompt Quality Control';
  satisfy 'DMSR-7078' by 'Prompt Quality Control';
  satisfy 'DMSR-7584' by 'Prompt Quality Control';
  satisfy 'DMSR-6707' by 'Prompt Quality Control';
  satisfy 'DMSR-4837' by 'Prompt Quality Control';
  part def 'Batch Production Def';
  part 'Batch Production' : 'Batch Production Def';
  satisfy 'DMSR-4419' by 'Batch Production';
  satisfy 'DMSR-1031' by 'Batch Production';
  satisfy 'DMSR-4915' by 'Batch Production';
  satisfy 'DMSR-4278' by 'Batch Production';
  satisfy 'DMSR-9393' by 'Batch Production';
  satisfy 'DMSR-5060' by 'Batch Production';
  satisfy 'DMSR-4277' by 'Batch Production';
  satisfy 'DMSR-1395' by 'Batch Production';
  satisfy 'DMSR-5224' by 'Batch Production';
  satisfy 'DMSR-5732' by 'Batch Production';
  satisfy 'DMSR-6707' by 'Batch Production';
  satisfy 'DMSR-4837' by 'Batch Production';
  satisfy 'DMSR-3130' by 'Batch Production';
  satisfy 'DMSR-6271' by 'Batch Production';
  satisfy 'DMSR-9691' by 'Batch Production';
  part def 'Workload/Workflow Management Def';
  part 'Workload/Workflow Management' : 'Workload/Workflow Management Def';
  satisfy 'DMSR-4419' by 'Workload/Workflow Management';
  satisfy 'DMSR-1031' by 'Workload/Workflow Management';
  satisfy 'DMSR-4915' by 'Workload/Workflow Management';
  satisfy 'DMSR-4278' by 'Workload/Workflow Management';
  satisfy 'DMSR-9393' by 'Workload/Workflow Management';
  satisfy 'DMSR-5060' by 'Workload/Workflow Management';
  satisfy 'DMSR-4277' by 'Workload/Workflow Management';
  satisfy 'DMSR-1395' by 'Workload/Workflow Management';
  satisfy 'DMSR-5732' by 'Workload/Workflow Management';
  satisfy 'DMSR-6707' by 'Workload/Workflow Management';
  satisfy 'DMSR-4837' by 'Workload/Workflow Management';
  satisfy 'DMSR-9522' by 'Workload/Workflow Management';
  satisfy 'DMSR-3130' by 'Workload/Workflow Management';
  satisfy 'DMSR-6271' by 'Workload/Workflow Management';
  satisfy 'DMSR-9691' by 'Workload/Workflow Management';
  part def 'Template Generation Def';
  part 'Template Generation' : 'Template Generation Def';
  satisfy 'DMSR-6641' by 'Template Generation';
  satisfy 'DMSR-5732' by 'Template Generation';
  part def 'Special Programs Productions Def';
  part 'Special Programs Productions' : 'Special Programs Productions Def';
  satisfy 'DMSR-8515' by 'Special Programs Productions';
  satisfy 'DMSR-4733' by 'Special Programs Productions';
  part def 'Science Plugins Def';
  part 'Science Plugins' : 'Science Plugins Def';
  satisfy 'DMSR-8454' by 'Science Plugins';
  satisfy 'DMSR-6957' by 'Science Plugins';
  satisfy 'DMSR-7349' by 'Science Plugins';
  satisfy 'DMSR-7118' by 'Science Plugins';
  satisfy 'DMSR-7466' by 'Science Plugins';
  satisfy 'DMSR-7078' by 'Science Plugins';
  satisfy 'DMSR-7584' by 'Science Plugins';
  satisfy 'DMSR-5126' by 'Science Plugins';
  satisfy 'DMSR-1575' by 'Science Plugins';
  satisfy 'DMSR-1929' by 'Science Plugins';
  satisfy 'DMSR-2104' by 'Science Plugins';
  satisfy 'DMSR-1633' by 'Science Plugins';
  satisfy 'DMSR-4608' by 'Science Plugins';
  satisfy 'DMSR-2704' by 'Science Plugins';
  satisfy 'DMSR-5732' by 'Science Plugins';
  part def 'Calibration SW Def';
  part 'Calibration SW' : 'Calibration SW Def';
  satisfy 'DMSR-7584' by 'Calibration SW';
  satisfy 'DMSR-1575' by 'Calibration SW';
  satisfy 'DMSR-2104' by 'Calibration SW';
  satisfy 'DMSR-5732' by 'Calibration SW';
  part def 'MOPS and Forced Photometry Def';
  part 'MOPS and Forced Photometry' : 'MOPS and Forced Photometry Def';
  satisfy 'DMSR-7154' by 'MOPS and Forced Photometry';
  satisfy 'DMSR-4282' by 'MOPS and Forced Photometry';
  satisfy 'DMSR-9267' by 'MOPS and Forced Photometry';
  satisfy 'DMSR-5020' by 'MOPS and Forced Photometry';
  satisfy 'DMSR-6426' by 'MOPS and Forced Photometry';
  satisfy 'DMSR-4925' by 'MOPS and Forced Photometry';
  satisfy 'DMSR-5732' by 'MOPS and Forced Photometry';
  satisfy 'DMSR-7738' by 'MOPS and Forced Photometry';
  satisfy 'DMSR-5583' by 'MOPS and Forced Photometry';
  satisfy 'DMSR-5225' by 'MOPS and Forced Photometry';
  satisfy 'DMSR-1346' by 'MOPS and Forced Photometry';
  satisfy 'DMSR-6637' by 'MOPS and Forced Photometry';
  part def 'Summit to Base Network Def';
  part 'Summit to Base Network' : 'Summit to Base Network Def';
  satisfy 'DMSR-6886' by 'Summit to Base Network';
  satisfy 'DMSR-5747' by 'Summit to Base Network';
  satisfy 'DMSR-4278' by 'Summit to Base Network';
  satisfy 'DMSR-5883' by 'Summit to Base Network';
  satisfy 'DMSR-6601' by 'Summit to Base Network';
  satisfy 'DMSR-6358' by 'Summit to Base Network';
  satisfy 'DMSR-3877' by 'Summit to Base Network';
  satisfy 'DMSR-8923' by 'Summit to Base Network';
  satisfy 'DMSR-8544' by 'Summit to Base Network';
  part def 'Base to Archive Network Def';
  part 'Base to Archive Network' : 'Base to Archive Network Def';
  satisfy 'DMSR-6886' by 'Base to Archive Network';
  satisfy 'DMSR-5747' by 'Base to Archive Network';
  satisfy 'DMSR-4278' by 'Base to Archive Network';
  satisfy 'DMSR-1253' by 'Base to Archive Network';
  satisfy 'DMSR-5740' by 'Base to Archive Network';
  satisfy 'DMSR-9950' by 'Base to Archive Network';
  satisfy 'DMSR-9081' by 'Base to Archive Network';
  satisfy 'DMSR-4835' by 'Base to Archive Network';
  satisfy 'DMSR-5865' by 'Base to Archive Network';
  satisfy 'DMSR-2330' by 'Base to Archive Network';
  satisfy 'DMSR-5282' by 'Base to Archive Network';
  part def 'Base LAN Network Def';
  part 'Base LAN Network' : 'Base LAN Network Def';
  satisfy 'DMSR-6886' by 'Base LAN Network';
  satisfy 'DMSR-5747' by 'Base LAN Network';
  satisfy 'DMSR-4278' by 'Base LAN Network';
  satisfy 'DMSR-7661' by 'Base LAN Network';
  satisfy 'DMSR-5606' by 'Base LAN Network';
  satisfy 'DMSR-6362' by 'Base LAN Network';
  part def 'Network Management Def';
  part 'Network Management' : 'Network Management Def';
  satisfy 'DMSR-4419' by 'Network Management';
  satisfy 'DMSR-5747' by 'Network Management';
  satisfy 'DMSR-4278' by 'Network Management';
  satisfy 'DMSR-8544' by 'Network Management';
  part def 'Data Butler Def';
  part 'Data Butler' : 'Data Butler Def';
  satisfy 'DMSR-8498' by 'Data Butler';
  satisfy 'DMSR-1890' by 'Data Butler';
  satisfy 'DMSR-2006' by 'Data Butler';
  satisfy 'DMSR-7045' by 'Data Butler';
  satisfy 'DMSR-6199' by 'Data Butler';
  satisfy 'DMSR-4919' by 'Data Butler';
  satisfy 'DMSR-5732' by 'Data Butler';
  satisfy 'DMSR-6707' by 'Data Butler';
  part def 'Task Framework Def';
  part 'Task Framework' : 'Task Framework Def';
  satisfy 'DMSR-8498' by 'Task Framework';
  satisfy 'DMSR-1890' by 'Task Framework';
  satisfy 'DMSR-2006' by 'Task Framework';
  satisfy 'DMSR-2078' by 'Task Framework';
  satisfy 'DMSR-9393' by 'Task Framework';
  satisfy 'DMSR-1395' by 'Task Framework';
  satisfy 'DMSR-7893' by 'Task Framework';
  satisfy 'DMSR-1156' by 'Task Framework';
  satisfy 'DMSR-5732' by 'Task Framework';
  satisfy 'DMSR-6707' by 'Task Framework';
  satisfy 'DMSR-8515' by 'Task Framework';
  part def 'DBB Lifetime Management Def';
  part 'DBB Lifetime Management' : 'DBB Lifetime Management Def';
  satisfy 'DMSR-9728' by 'DBB Lifetime Management';
  satisfy 'DMSR-5359' by 'DBB Lifetime Management';
  satisfy 'DMSR-4892' by 'DBB Lifetime Management';
  satisfy 'DMSR-8123' by 'DBB Lifetime Management';
  satisfy 'DMSR-9242' by 'DBB Lifetime Management';
  part def 'DBB Storage Def';
  part 'DBB Storage' : 'DBB Storage Def';
  satisfy 'DMSR-7380' by 'DBB Storage';
  satisfy 'DMSR-9522' by 'DBB Storage';
  satisfy 'DMSR-4707' by 'DBB Storage';
  part def 'Image/Cutout Server Def';
  part 'Image/Cutout Server' : 'Image/Cutout Server Def';
  satisfy 'DMSR-7026' by 'Image/Cutout Server';
  satisfy 'DMSR-3481' by 'Image/Cutout Server';
  satisfy 'DMSR-2624' by 'Image/Cutout Server';
  satisfy 'DMSR-7045' by 'Image/Cutout Server';
  satisfy 'DMSR-2318' by 'Image/Cutout Server';
  satisfy 'DMSR-4370' by 'Image/Cutout Server';
  satisfy 'DMSR-5359' by 'Image/Cutout Server';
  satisfy 'DMSR-8228' by 'Image/Cutout Server';
  satisfy 'DMSR-4892' by 'Image/Cutout Server';
  satisfy 'DMSR-8123' by 'Image/Cutout Server';
  satisfy 'DMSR-9242' by 'Image/Cutout Server';
  satisfy 'DMSR-1519' by 'Image/Cutout Server';
  part def 'Observatory Operations Data Def';
  part 'Observatory Operations Data' : 'Observatory Operations Data Def';
  satisfy 'DMSR-4278' by 'Observatory Operations Data';
  satisfy 'DMSR-6707' by 'Observatory Operations Data';
  satisfy 'DMSR-4837' by 'Observatory Operations Data';
  satisfy 'DMSR-9242' by 'Observatory Operations Data';
}