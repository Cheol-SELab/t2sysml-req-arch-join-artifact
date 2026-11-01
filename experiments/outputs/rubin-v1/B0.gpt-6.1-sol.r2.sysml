package 'System' {
  requirement def 'DMSR-4419' { doc /* Except in cases of major disaster, the DMS shall have no unscheduled outages of the DMS pipelines extending over a period greater than productionMaxDowntime. A major disaster is defined as a natural disaster or act of war (e.g. flood, fire, hostile acts) that compromises or threatens to compromise the health and integrity of the DMS physical facility, computing equipment, or operational personnel. */ }
  requirement def 'DMSR-3597' { doc /* The DMS shall acquire raw Exposure data from the Camera science sensors during normal operations, calibration data collection, and in any other required engineering modes. */ }
  requirement def 'DMSR-2767' { doc /* The DMS shall acquire raw exposure data from the Camera wavefront sensors, during normal survey operations and in any other required operating modes. */ }
  requirement def 'DMSR-5432' { doc /* The DMS shall assemble the combination of raw exposure data from all the readout channels from a single Sensor to form a single image for that sensor. The image data and relevant exposure metadata shall be integrated into a standard format suitable for down-stream processing, archiving, and distribution to the user community. */ }
  requirement def 'DMSR-5124' { doc /* For each raw science image, the DMS shall store image metadata including at least: • Time of exposure start and end, referenced to TAI, and DUT1 • Site metadata (site seeing, transparency, weather, observatory location) • Telescope metadata (telescope pointing, active optics state, environmental state) • Camera metadata (shutter trajectory, wavefront sensors, environmental state) • Program metadata (identifier for main survey, deep drilling, etc.) • Scheduler metadata (visitID, intended number of exposures in the visit) */ }
  requirement def 'DMSR-5074' { doc /* The DMS shall produce a Level 1 Performance Report that provides indicators of how the DMS has performed in processing the night’s observations, including at least: number of observations successfully processed through each pipeline; number of observations for each pipeline that had recoverable failures (with a record of the failure type and recovery mechanism); number of observations for each pipeline that had unrecoverable failures; number of observations archived at each DMS Facility; number of observations satisfying the science criteria for each active science program. */ }
  requirement def 'DMSR-9661' { doc /* Engineering and Facility data from the Observatory Control System and associated metadata shall be permanently archived by the DMS and available for public access within L1PublicT hours of their generation by the OCS. */ }
  requirement def 'DMSR-7084' { doc /* The infrastructure will be sized such that the net throughput of the data processing pipelines will permit a complete processing of a night’s observing data prior to the start of the next observing night, assuming no system outages. */ }
  requirement def 'DMSR-6886' { doc /* The infrastructure will be sized such that after outages, ”catch up” processing of the temporarily stored raw image data may occur at the rate of one night’s observing data processed per day, without interrupting the current day’s observatory operations. */ }
  requirement def 'DMSR-4278' { doc /* The infrastructure will incorporate sufficient capability for self-diagnostics and recovery to provide for continuation of processing in the event of partial hardware or software failures. */ }
  requirement def 'DMSR-2104' { doc /* The DMS shall acquire raw, full-frame exposures from the camera guider sensors during calibration. The DMS shall produce calibration data products for the guide sensors. */ }
  requirement def 'DMSR-1680' { doc /* The DMS shall contain a component to control all Level-1 Data Product production. */ }
  requirement def 'DMSR-4996' { doc /* The DMS system shall archive all data, including science, wavefront, and guider images and associated metadata, that are presented for archiving by up-stream systems, with a rate of permanent data loss or corruption not to exceed dataLossMax. */ }
  requirement def 'DMSR-6707' { doc /* At any given LSST computational facility the DMS shall be capable of operations on a heterogeneous cluster of machines. The hardware, operating system, and other machine parameters shall be limited to a project-approved set. */ }
  requirement def 'DMSR-5737' { doc /* The DMS at the Base Site shall contain a component to accept control commands from and communicate with the OCS. */ }
  requirement def 'DMSR-4837' { doc /* The Data Management subsystem shall be designed to facilitate unplanned repair activities expected not to exceed DMDowntime days per year. */ }
  requirement def 'DMSR-9242' { doc /* All raw data used to generate any public data product (raw exposures, calibration frames, telemetry, configuration metadata, etc.) shall be kept and made available for download. */ }
  requirement def 'DMSR-6213' { doc /* A service shall be provided to publish to the community the next visit location and the predicted visit schedule provided by the OCS. This service shall consist of both a web page for human inspection and a web API to allow automated tools to respond promptly. */ }
  requirement def 'DMSR-7154' { doc /* With the exception of alerts and Solar System Objects, all Level 1 Data Products shall be made public within time L1PublicT of the acquisition of the raw image data. LSST shall not release image or catalog data resulting from a visit, except for the content of the public alert stream, sooner than time L1PublicTMin following the acquisition of the raw image data from that visit. For visits resulting in fewer than nAlertVisitPeak, LSST shall be capable of supporting the distribution of at least OTR1 per cent of alerts via the LSST alert distribution system within time OTT1 from the conclusion of the camera’s readout of the raw exposures used to generate each alert. Solar System Object orbits will, on average, be calculated before the following night’s observing finishes and the results shall be made available within time L1PublicT of those calculations being completed. */ }
  requirement def 'DMSR-1534' { doc /* The DMS shall acquire crosstalk corrected exposure data from the Camera science sensors, during normal survey operations and in any other required operating modes. */ }
  requirement def 'DMSR-1575' { doc /* Calibration products from a group of up to nCalExpProc related exposures that should be processed together, shall be available from the DMS image archive within calProcTime of the end of the acquisition of images/data for that group. */ }
  requirement def 'DMSR-9969' { doc /* The DMS shall ensure that all images taken by the camera and marked for Level-1 processing are eventually retrieved, archived, and processed even in the event of connectivity failure between downstream Facilities. */ }
  requirement def 'DMSR-9393' { doc /* The DMS shall process all requested datasets until either a successful result is recorded or a permanent failure is recognized. If any dataset is processed, in part or in whole, more than once, only one of the wholly processed results will be recorded for further processing. */ }
  requirement def 'DMSR-6009' { doc /* Identified transient events shall be made available to end-users in the form of alerts, which shall be published to community alert distribution networks using communitystandard protocols, to be determined during the LSST construction phase as community standards evolve. */ }
  requirement def 'DMSR-9273' { doc /* The DMS shall maintain a ”live” Level 1 Database for query by science users, updated as a result of Alert Production processing. */ }
  requirement def 'DMSR-5225' { doc /* All Level 1 processing from special programs shall be completed before data arrives from the following night’s observations. */ }
  requirement def 'DMSR-6637' { doc /* The publishing of Level 1 data products from Special Programs shall be subject to the same performance requirements of the standard Level 1 system. In particular L1PublicT and OTT1. */ }
  requirement def 'DMSR-7584' { doc /* The DMS shall produce a Level 1 Calibration Report that provides a summary of significant differences in Calibration Images that may indicate evolving problems with the telescope or camera, including a nightly broad-band flat in each filter. */ }
  requirement def 'DMSR-2704' { doc /* The DMS shall be capable of producing calibration data products on an as-needed basis, consistent with monitoring the health and performance of the instrument, the availability of raw calibration exposures, the temporal stability of the calibrations, and of the SRD requirements for calibration accuracy. */ }
  requirement def 'DMSR-4245' { doc /* Within a fixed cost envelope for the Data Management subsystem, the allocation of processing and storage facilities will optimize reliability over availability to end users. */ }
  requirement def 'DMSR-3618' { doc /* A basic, limited capacity, alert filtering service shall be provided that can be given user defined filters to reduce the alert stream to manageable levels. */ }
  requirement def 'DMSR-3546' { doc /* The LSST alert filtering service shall support numBrokerUsers simultaneous users with each user allocated a bandwidth capable of receiving the equivalent of numBrokerAlerts alerts per visit. */ }
  requirement def 'DMSR-3391' { doc /* Users of the LSST Alert Filtering Service shall be able to use a predefined set of simple filters. */ }
  requirement def 'DMSR-5029' { doc /* The DMS shall generate a nightly Data Quality Report within time dqReportComplTime in both human-readable and machine-readable forms. */ }
  requirement def 'DMSR-2465' { doc /* The DMS shall produce a Level 1 Data Quality Report that contains indicators of data quality that result from running the DMS pipelines, including at least: Photometric zero point vs. time for each utilized filter; Sky brightness vs. time for each utilized filter; seeing vs. time for each utilized filter; PSF parameters vs. time for each utilized filter; detection efficiency for point sources vs. mag for each utilized filter. */ }
  requirement def 'DMSR-1305' { doc /* The DMS shall generate a nightly DMS Performance Report within time perfReportComplTime in both human-readable and machine-readable forms. */ }
  requirement def 'DMSR-7078' { doc /* The DMS shall generate a nightly Calibration Report within time calibReportComplTime in both human-readable and machine-readable forms. */ }
  requirement def 'DMSR-1031' { doc /*  */ }
  requirement def 'DMSR-4915' { doc /* The DMS shall provide Processing, Storage, and Network resources capable of executing the DMS Data Release Production over all pre-existing survey data in a time no greater than drProcessingPeriod, without impacting observatory operations. */ }
  requirement def 'DMSR-5060' { doc /* The DMS shall provide software to orchestrate execution of productions, including deploying pipelines on a computing platform. */ }
  requirement def 'DMSR-4277' { doc /* The DMS shall provide software to monitor execution of pipelines in real time. */ }
  requirement def 'DMSR-1395' { doc /* The DMS shall provide software to detect faults in pipeline execution and recover when possible. */ }
  requirement def 'DMSR-5224' { doc /* The DMS shall enable applications to process every record in a table meeting user-specified criteria exactly once. */ }
  requirement def 'DMSR-5732' { doc /* The DMS software architecture shall be designed to enable high throughput on high-performance compute platforms, while also enabling the use of science-specific algorithms by science users on commodity desktop compute platforms. */ }
  requirement def 'DMSR-3130' { doc /* The Data Management System shall provide tools to re-run a data processing operation under the same conditions as a previous run of that operation, based on provenance data recorded by the system. */ }
  requirement def 'DMSR-6271' { doc /* A re-run based on provenance, if run on the same system or a system with identically configured hardware and system software, shall produce the same results (with the exception of provenance data or other execution records that depend on the wall-clock time or on variable system loads). */ }
  requirement def 'DMSR-9691' { doc /* A re-run based on provenance, if run on a different system (but whose configuration still meets established LSST requirements), shall produce results which are the same to the extent computationally feasible (with the exception of provenance data or other execution records that depend on the wall-clock time or on variable system loads). */ }
  requirement def 'DMSR-8204' { doc /* The DMS shall facilitate Level 3 catalog processing that may take place at external facilities outside the DACs. This will principally be by facilitating the export of catalogs and the provision of tools for maintaining and validating exported data. */ }
  requirement def 'DMSR-3171' { doc /* The DMS shall provide access to all Level 1 and Level 2 catalog products through the LSST project’s Data Access Centers, and any others that have been established and funded, for Level 3 processing that takes place at the DACs. */ }
  requirement def 'DMSR-7887' { doc /* The DMS shall facilitate Level 3 image processing that may take place at external facilities outside the DACs. This will principally be by facilitating the export of image datasets and the provision of tools for maintaining and validating exported data. */ }
  requirement def 'DMSR-3481' { doc /* The DMS shall provide access to all Level 1 and Level 2 image products through the LSST project’s Data Access Centers, and any others that have been established and funded, for Level 3 processing that takes place at the DACs. */ }
  requirement def 'DMSR-5495' { doc /* The Archive Center shall provide computing, storage, and network infrastructure to support, simultaneously: nightly processing including image processing, detection, association, and moving object pipelines, and the generation of all time-critical data products, i.e. alerts; the data release production, including Level-2 data product creation, permanent storage for all data products (with provenance), including federated Level-3 products; and serve data for replication to data centers and end user sites. */ }
  requirement def 'DMSR-2087' { doc /* The Archive Center shall provide disaster recovery support preventing loss of LSST data in the case of infrastructure or facility-threatening events. This support shall enable recovery of all LSST archived data from backed up sources, including Data Access Centers. */ }
  requirement def 'DMSR-7661' { doc /* The Data Access Centers shall provide computing, storage, and network infrastructure to support open access to LSST data products (with provenance) by end users. */ }
  requirement def 'DMSR-3342' { doc /* The DMS shall provide software to enable bulk download of data products and raw data, subject to network bandwidth. */ }
  requirement def 'DMSR-2232' { doc /* For each Difference Exposure, the DMS shall store: the identify of the input exposures and related provenance information, and a set of metadata attributes including at least a representation of the PSF matching kernel used in the differencing. */ }
  requirement def 'DMSR-2896' { doc /* All releases of the DMS catalog archive shall be maintained and preserved in a publicly accessible state for the entire operational life of the LSST observatory. */ }
  requirement def 'DMSR-4282' { doc /* Detected moving objects and associated metadata shall be available for public access in the DMS science data archive within time L1PublicT of their generation by the DMS. */ }
  requirement def 'DMSR-9405' { doc /* The DMS shall preserve and keep in an accessible state an alert archive with all issued alerts for a historical record and for false alert analysis. */ }
  requirement def 'DMSR-4575' { doc /* The DMS shall provide a means for ensuring that users’ Level 3 processing tasks can be carried out on self-consistent inputs - i.e., catalogs, images, metadata, calibrations, camera configuration data, etc., that match each other and all arise from consistent Level 1 and Level 2 processings. */ }
  requirement def 'DMSR-5126' { doc /* The DMS shall produce and archive Calibration Data Products that capture the signature of the telescope, camera and detector, including at least: Crosstalk correction matrix, Bias and Dark correction frames, a set of monochromatic dome flats spanning the wavelength range, a synthetic broad-band flat per filter, and an illumination correction frame per filter. */ }
  requirement def 'DMSR-1929' { doc /* For each Calibration Production data product, DMS shall record: the list of input exposures and the range of dates over which they were obtained; the processing parameters; the calibration products used to derive it; and a set of metadata attributes including at least: the date of creation; the calibration image type (e.g. dome flat, superflat, bias, etc); the provenance of the processing software; and the instrument configuration including the filter in use, if applicable. */ }
  requirement def 'DMSR-9649' { doc /* The infrastructure will provide for temporary storage for a minimum of tempStorageRelMTTR of the mean time to repair of any communications network link at or before the source end of that link. */ }
  requirement def 'DMSR-5747' { doc /* The infrastructure will incorporate as fault-tolerance features to prevent loss of data in the event of hardware or software failure. */ }
  requirement def 'DMSR-9590' { doc /* The Base Facility shall provide sufficient computing, storage, and network infrastructure to support buffering and forwarding of all raw and crosstalk-corrected image data to the Archive Facility, a complete copy of the Archive Facility data holdings, and compute facilities to support Commissioning activities. */ }
  requirement def 'DMSR-4495' { doc /* The number of Data Access Centers shall be limited only by available internal or external funding. No architectural constraints will be placed on the DMS that prohibit the addition of Data Access Centers at any time, subject to funding. */ }
  requirement def 'DMSR-5128' { doc /* The DMS shall create an Exposure Catalog containing information for each exposure that includes the exposure date/time and duration, properties of the filter used, dome and telescope pointing and orientation, status of calibration apparatus, airmass and zenith distance, telescope and dome status, environmental information, and information regarding each sensor including an ID, its location in the focal plane, electronic configuration, and WCS. */ }
  requirement def 'DMSR-3677' { doc /* The DMS shall construct a catalog of all Sources detected on Difference Exposures with SNR > transSNR. For each Difference Source (DIASource), the DMS shall be able to provide the identity of the Difference Exposure from which it was derived; the identity of the associated SSObject, if any; the identity of the parent Source from which this DIASource has been deblended, if any. The DMS shall also measure and record a set of attributes for each DIASource including at least: epoch of the observation, focal plane position centroid and error (pixel), sky position and associated error (radec), SNR of the detection; calibrated PS flux and associated error; likelihood of the observed data given the PS model; calibrated aperture flux and associated error; calibrated flux and associated error for a trailed source model, and length and angle of the trail; flux and associated parameters for a dipole model; parameters of an adaptive shape measurement and associated error; a measure of source extendedness; the estimated background at the position of the object in the template image with associated uncertainty; a measure of spuriousness; and flags indicating problems encountered while computing the aforementioned attributes. The DMS shall also determine and record measurements on the Calibrated exposure the following: calibrated flux and associated error for the source as measured on the Visit image. */ }
  requirement def 'DMSR-6306' { doc /* The DMS shall construct a catalog of all astrophysical objects identified through difference image analysis (DIAObjects). The DIAObject entries shall include metadata attributes including at least: a unique identifier; the identifiers of the diaNearbyObjMaxStar nearest stars and diaNearbyObjMaxGalaxy nearest galaxies in the Object catalog lying within diaNearbyObjRadius, the probability that the DIAObject is the same as the nearby Object; and a set of DIAObject properties. */ }
  requirement def 'DMSR-9267' { doc /* The DMS shall produce a catalog of all Solar System Objects (SSObjects) that have been identified via Moving Object Processing. The SSObject catalog shall include for each entry attributes including at least the following: Osculating orbital elements and associated uncertainties, minimum orbit intersection distance (MOID), mean absolute magnitude and slope parameter per band and associated errors, and flags that describe conditions of the description. */ }
  requirement def 'DMSR-6426' { doc /* For all DIASources not associated with either DIAObjects or SSObjects, the DMS shall perform forced photometry at the location of the new source (precovery) on all Difference Exposures obtained in the prior precoveryWindow, and make the results publicly available within L1PublicT. */ }
  requirement def 'DMSR-6832' { doc /* The DMS shall ensure that any query executed at a particular point in time against any DMS delivered database shall be repeatable at a later date, and produce results that are either identical or include additional results (owing to updates from Level-1 processing). */ }
  requirement def 'DMSR-1188' { doc /* To reduce the likelihood for confusion, all IDs shall be unique across databases and database versions, other than those corresponding to uniquely identifiable entities (i.e., IDs of exposures). */ }
  requirement def 'DMSR-7045' { doc /* A Dataset may consist of one or more pixel images, a set of records in a file or database, or any other grouping of data that are processed or produced as a logical unit. The DMS shall be able to identify and retrieve complete, consistent datasets for processing. */ }
  requirement def 'DMSR-3500' { doc /* The DMS shall provide software to ingest data products into the Science Data Archive. */ }
  requirement def 'DMSR-9728' { doc /* The DMS shall provide low-latency storage for un-archived data products of at least l1CacheLifetime to enable efficient precovery and other Level-1 production measurements. */ }
  requirement def 'DMSR-5103' { doc /* The DMS shall maintain both the Level-2 catalog and the reprocessed Level-1 catalog from the most recent two Data Releases for query by science users, as well as versions of the most recent catalogs generated from Special Programs data. */ }
  requirement def 'DMSR-7738' { doc /* The DMS shall create a DIAForcedSource Catalog, consisting of measured fluxes for entries in the DIAObject Catalog on Difference Exposures. Measurements for each forcedsource shall include the DIAObject and visit IDs, the modeled flux and error (given fixed position, shape, and deblending parameters), and measurement quality flags. */ }
  requirement def 'DMSR-4733' { doc /* Data products for special programs shall be stored in databases that are distinct from those used to store standard Level 1 and Level 2 data products. It shall be possible for these databases to be federated with the Level 1 and Level 2 databases to allow crossqueries and joins. */ }
  requirement def 'DMSR-5359' { doc /* All per-band deep coadds and best seeing coadds shall be kept indefinitely and made available to users. */ }
  requirement def 'DMSR-4892' { doc /* It shall be possible to retain small sections of all generated coadds. */ }
  requirement def 'DMSR-8123' { doc /* Small, overlapping, samples of data from older releases shall be kept loaded in the database. */ }
  requirement def 'DMSR-5792' { doc /* The LSST Project shall provide data access services for the current Level 1 data, the most recent nDRMin Data Releases, and multiple older Data Releases. */ }
  requirement def 'DMSR-8828' { doc /* The data access services shall be designed to permit, and their software implementation shall support, the service of at least nDRTot Data Releases accumulated over the (find the actual survey-length parameter) surveyYears-year planned survey. */ }
  requirement def 'DMSR-1159' { doc /* The data access services shall be designed to permit the service of operationsdesignated subsets of the full content of the “older Data Releases” referred to in DMS-REQ0363. */ }
  requirement def 'DMSR-1931' { doc /* The data access services shall be designed to support the service of operationsdesignated subsets of the content of the “older Data Releases” referred to in requirement DMSR-5792 from high-latency media. */ }
  requirement def 'DMSR-1368' { doc /* The data access services shall be designed to accommodate evolution of the LSST data model from Data Release to Data Release. */ }
  requirement def 'DMSR-5053' { doc /* Apart from the flexibility provided by requirements DMSR-1159, DMS-REQ0366, DMSR-1519, and DMSR-1368, the qualitative behavior of the data access services on the “older Data Releases” defined in DMSR-5792 shall match that for the most recent nDRMin Data Releases. */ }
  requirement def 'DMSR-7380' { doc /* The DMS shall be able to archive a designated subset of Camera test data and make it available in an environment matching the data backbone interfaces. */ }
  requirement def 'DMSR-9522' { doc /* The Data Management System shall archive all processing provenance associated with archived data products, including relevant data from other subsystems. */ }
  requirement def 'DMSR-4707' { doc /* The Data Management System shall make the archived provenance data available to science users together with the associated science data products. */ }
  requirement def 'DMSR-8228' { doc /* The DMS shall be able to regenerate data products from previous data releases to within scientifically reasonable tolerances. */ }
  part def 'Archiving Def';
  part 'Archiving' : 'Archiving Def';
  satisfy 'DMSR-4419' by 'Archiving';
  satisfy 'DMSR-3597' by 'Archiving';
  satisfy 'DMSR-2767' by 'Archiving';
  satisfy 'DMSR-5432' by 'Archiving';
  satisfy 'DMSR-5124' by 'Archiving';
  satisfy 'DMSR-5074' by 'Archiving';
  satisfy 'DMSR-9661' by 'Archiving';
  satisfy 'DMSR-7084' by 'Archiving';
  satisfy 'DMSR-6886' by 'Archiving';
  satisfy 'DMSR-4278' by 'Archiving';
  satisfy 'DMSR-2104' by 'Archiving';
  satisfy 'DMSR-1680' by 'Archiving';
  satisfy 'DMSR-4996' by 'Archiving';
  satisfy 'DMSR-6707' by 'Archiving';
  satisfy 'DMSR-5737' by 'Archiving';
  satisfy 'DMSR-4837' by 'Archiving';
  satisfy 'DMSR-9242' by 'Archiving';
  part def 'Planned Observation Publication Def';
  part 'Planned Observation Publication' : 'Planned Observation Publication Def';
  satisfy 'DMSR-6213' by 'Planned Observation Publication';
  part def 'Prompt Processing Ingest Def';
  part 'Prompt Processing Ingest' : 'Prompt Processing Ingest Def';
  satisfy 'DMSR-7154' by 'Prompt Processing Ingest';
  satisfy 'DMSR-4419' by 'Prompt Processing Ingest';
  satisfy 'DMSR-1534' by 'Prompt Processing Ingest';
  satisfy 'DMSR-5074' by 'Prompt Processing Ingest';
  satisfy 'DMSR-1575' by 'Prompt Processing Ingest';
  satisfy 'DMSR-7084' by 'Prompt Processing Ingest';
  satisfy 'DMSR-4278' by 'Prompt Processing Ingest';
  satisfy 'DMSR-9969' by 'Prompt Processing Ingest';
  satisfy 'DMSR-9393' by 'Prompt Processing Ingest';
  satisfy 'DMSR-1680' by 'Prompt Processing Ingest';
  satisfy 'DMSR-6707' by 'Prompt Processing Ingest';
  satisfy 'DMSR-5737' by 'Prompt Processing Ingest';
  satisfy 'DMSR-4837' by 'Prompt Processing Ingest';
  part def 'Prompt Processing Def';
  part 'Prompt Processing' : 'Prompt Processing Def';
  satisfy 'DMSR-6009' by 'Prompt Processing';
  satisfy 'DMSR-7154' by 'Prompt Processing';
  satisfy 'DMSR-4419' by 'Prompt Processing';
  satisfy 'DMSR-5074' by 'Prompt Processing';
  satisfy 'DMSR-1575' by 'Prompt Processing';
  satisfy 'DMSR-7084' by 'Prompt Processing';
  satisfy 'DMSR-4278' by 'Prompt Processing';
  satisfy 'DMSR-9969' by 'Prompt Processing';
  satisfy 'DMSR-9393' by 'Prompt Processing';
  satisfy 'DMSR-1680' by 'Prompt Processing';
  satisfy 'DMSR-9273' by 'Prompt Processing';
  satisfy 'DMSR-6707' by 'Prompt Processing';
  satisfy 'DMSR-4837' by 'Prompt Processing';
  satisfy 'DMSR-5225' by 'Prompt Processing';
  satisfy 'DMSR-6637' by 'Prompt Processing';
  satisfy 'DMSR-9242' by 'Prompt Processing';
  part def 'Observatory Operations Data Def';
  part 'Observatory Operations Data' : 'Observatory Operations Data Def';
  satisfy 'DMSR-4278' by 'Observatory Operations Data';
  satisfy 'DMSR-6707' by 'Observatory Operations Data';
  satisfy 'DMSR-4837' by 'Observatory Operations Data';
  satisfy 'DMSR-9242' by 'Observatory Operations Data';
  part def 'OCS-Driven Batch Def';
  part 'OCS-Driven Batch' : 'OCS-Driven Batch Def';
  satisfy 'DMSR-4419' by 'OCS-Driven Batch';
  satisfy 'DMSR-7584' by 'OCS-Driven Batch';
  satisfy 'DMSR-1575' by 'OCS-Driven Batch';
  satisfy 'DMSR-7084' by 'OCS-Driven Batch';
  satisfy 'DMSR-2104' by 'OCS-Driven Batch';
  satisfy 'DMSR-2704' by 'OCS-Driven Batch';
  satisfy 'DMSR-9393' by 'OCS-Driven Batch';
  satisfy 'DMSR-1680' by 'OCS-Driven Batch';
  satisfy 'DMSR-6707' by 'OCS-Driven Batch';
  satisfy 'DMSR-5737' by 'OCS-Driven Batch';
  satisfy 'DMSR-4837' by 'OCS-Driven Batch';
  part def 'Telemetry Gateway Def';
  part 'Telemetry Gateway' : 'Telemetry Gateway Def';
  satisfy 'DMSR-4419' by 'Telemetry Gateway';
  satisfy 'DMSR-6707' by 'Telemetry Gateway';
  satisfy 'DMSR-5737' by 'Telemetry Gateway';
  satisfy 'DMSR-4837' by 'Telemetry Gateway';
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
  part def 'Bulk Distribution Def';
  part 'Bulk Distribution' : 'Bulk Distribution Def';
  satisfy 'DMSR-8204' by 'Bulk Distribution';
  satisfy 'DMSR-3171' by 'Bulk Distribution';
  satisfy 'DMSR-7887' by 'Bulk Distribution';
  satisfy 'DMSR-3481' by 'Bulk Distribution';
  satisfy 'DMSR-5495' by 'Bulk Distribution';
  satisfy 'DMSR-2087' by 'Bulk Distribution';
  satisfy 'DMSR-7661' by 'Bulk Distribution';
  satisfy 'DMSR-3342' by 'Bulk Distribution';
  satisfy 'DMSR-6707' by 'Bulk Distribution';
  satisfy 'DMSR-4837' by 'Bulk Distribution';
  satisfy 'DMSR-9242' by 'Bulk Distribution';
  part def 'DBB Ingest/Metadata Management Def';
  part 'DBB Ingest/Metadata Management' : 'DBB Ingest/Metadata Management Def';
  satisfy 'DMSR-4419' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-5124' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-2232' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-2896' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-4282' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-9405' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-9661' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-4575' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-8204' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-3171' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-7887' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-3481' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-5126' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-1575' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-1929' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-4245' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-7084' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-4915' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-9649' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-6886' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-5747' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-4278' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-9590' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-5495' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-2087' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-4495' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-5128' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-3677' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-6306' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-9267' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-6426' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-6832' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-1188' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-7045' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-3500' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-4996' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-9728' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-5103' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-6707' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-7738' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-4837' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-4733' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-5359' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-4892' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-8123' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-9242' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-5792' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-8828' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-1159' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-1931' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-1368' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-5053' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-7380' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-9522' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-4707' by 'DBB Ingest/Metadata Management';
  satisfy 'DMSR-3130' by 'DBB Ingest/Metadata Management';
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
  part def 'Workload/Workflow Management Def';
  part 'Workload/Workflow Management' : 'Workload/Workflow Management Def';
  satisfy 'DMSR-9522' by 'Workload/Workflow Management';
  part def 'LSP Web API Def';
  part 'LSP Web API' : 'LSP Web API Def';
  satisfy 'DMSR-8228' by 'LSP Web API';
  satisfy 'DMSR-4707' by 'LSP Web API';
  part def 'LSP Web API SW Def';
  part 'LSP Web API SW' : 'LSP Web API SW Def';
  satisfy 'DMSR-8228' by 'LSP Web API SW';
  part def 'Image/Cutout Server Def';
  part 'Image/Cutout Server' : 'Image/Cutout Server Def';
  satisfy 'DMSR-8228' by 'Image/Cutout Server';
  part def 'DAC Chile Enclave Def';
  part 'DAC Chile Enclave' : 'DAC Chile Enclave Def';
  satisfy 'DMSR-8228' by 'DAC Chile Enclave';
  part def 'DAC US Enclave Def';
  part 'DAC US Enclave' : 'DAC US Enclave Def';
  satisfy 'DMSR-8228' by 'DAC US Enclave';
}