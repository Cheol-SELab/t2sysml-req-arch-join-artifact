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
  requirement def 'DMSR-5048' { doc /* The DMS shall provide the ability to inject artificial or simulated data into data products to assess the functional and temporal performance of the production processing software. */ }
  requirement def 'DMSR-8796' { doc /* The DMS shall create a Difference Exposure from each Processed Visit Image by subtracting a re-projected, scaled, PSF-matched Template Image in the same passband. */ }
  requirement def 'DMSR-4744' { doc /* The DMS shall derive and persist a photometric zeropoint for each visit image, per CCD. */ }
  requirement def 'DMSR-2295' { doc /* The DMS shall generate and persist a WCS for each visit image. The absolute accuracy of the WCS shall be at least astrometricAccuracy in all areas of the image, provided that there are at least astrometricMinStandards astrometric standards available in each CCD. */ }
  requirement def 'DMSR-4749' { doc /* The DMS shall provide software to perform image differencing, generating Difference Exposures from the comparison of single exposures and/or coadded images. */ }
  requirement def 'DMSR-8783' { doc /* The DMS shall provide software for the detection of sources in a calibrated image, which may be a Difference Image or a Co-Add image. */ }
  requirement def 'DMSR-4926' { doc /* An astrometric model shall be provided for every Object and DIAObject which specifies at least the proper motion and parallax, and the estimated uncertainties on these quantities. */ }
  requirement def 'DMSR-2737' { doc /* The DMS shall provide calibrated photometry in each observed passband for all measured entities (e.g., DIASources, Sources, Objects), measuring the AB magnitude of the equivalent flat-SED source, above the atmosphere. Fluxes, possibly in jansky, shall be calculated for all measured entities. */ }
  requirement def 'DMSR-3610' { doc /* The DMS shall provide for the use of a variety of shape models on multiple kinds of input data to measure sources: measurement on coadds; measurement on coadds using information (e.g., PSFs) extracted from the individual exposures; measurement based on all the information from the individual Exposures simultaneously. */ }
  requirement def 'DMSR-4041' { doc /* The DMS shall produce Processed Visit Images, in which the corresponding raw sensor array data has been trimmed of overscan and corrected for instrumental signature. Images obtained in pairs during a standard visit are combined. */ }
  requirement def 'DMSR-1714' { doc /* The DMS shall determine a characterization of the PSF for any specified location in Processed Visit Images. */ }
  requirement def 'DMSR-8107' { doc /* Processed visit images shall include the corrected science pixel array, an integer mask array where each bit-plane represents a logical statement about whether a particular detector pathology affects the pixel, a variance array which represents the expected variance in the corresponding science pixel, and a representation of the spatially varying PSF that applies over the extent of the science array. These images shall also contain metadata that map pixel to world (sky) coordinates (the WCS) as well as metadata from which photometric measurements can be derived. */ }
  requirement def 'DMSR-2232' { doc /* For each Difference Exposure, the DMS shall store: the identify of the input exposures and related provenance information, and a set of metadata attributes including at least a representation of the PSF matching kernel used in the differencing. */ }
  requirement def 'DMSR-5128' { doc /* The DMS shall create an Exposure Catalog containing information for each exposure that includes the exposure date/time and duration, properties of the filter used, dome and telescope pointing and orientation, status of calibration apparatus, airmass and zenith distance, telescope and dome status, environmental information, and information regarding each sensor including an ID, its location in the focal plane, electronic configuration, and WCS. */ }
  requirement def 'DMSR-3677' { doc /* The DMS shall construct a catalog of all Sources detected on Difference Exposures with SNR > transSNR. For each Difference Source (DIASource), the DMS shall be able to provide the identity of the Difference Exposure from which it was derived; the identity of the associated SSObject, if any; the identity of the parent Source from which this DIASource has been deblended, if any. The DMS shall also measure and record a set of attributes for each DIASource including at least: epoch of the observation, focal plane position centroid and error (pixel), sky position and associated error (radec), SNR of the detection; calibrated PS flux and associated error; likelihood of the observed data given the PS model; calibrated aperture flux and associated error; calibrated flux and associated error for a trailed source model, and length and angle of the trail; flux and associated parameters for a dipole model; parameters of an adaptive shape measurement and associated error; a measure of source extendedness; the estimated background at the position of the object in the template image with associated uncertainty; a measure of spuriousness; and flags indicating problems encountered while computing the aforementioned attributes. The DMS shall also determine and record measurements on the Calibrated exposure the following: calibrated flux and associated error for the source as measured on the Visit image. */ }
  requirement def 'DMSR-2187' { doc /* The DMS shall be able to measure and store DIASources fainter than transSNR that satisfy additional criteria. A limited number of such sources shall be made to enable monitoring of DIA quality. */ }
  requirement def 'DMSR-6306' { doc /* The DMS shall construct a catalog of all astrophysical objects identified through difference image analysis (DIAObjects). The DIAObject entries shall include metadata attributes including at least: a unique identifier; the identifiers of the diaNearbyObjMaxStar nearest stars and diaNearbyObjMaxGalaxy nearest galaxies in the Object catalog lying within diaNearbyObjRadius, the probability that the DIAObject is the same as the nearby Object; and a set of DIAObject properties. */ }
  requirement def 'DMSR-9168' { doc /* For each DIAObject the DMS shall store summary attributes including at least: sky position at the time of the observation; astrometric attributes including proper motion, parallax and related errors; point-source magnitude in each passband and related error; weighted mean forced-photometry flux and related error; periodic and non-periodic variability measures; and flags that encode special conditions encountered in measuring the above quantities. */ }
  requirement def 'DMSR-5354' { doc /* The DMS shall create an Alert for each detected DIASource, to be broadcast using community protocols, with content that includes: a unique Alert ID, the Level-1 database ID, the DIASource record that triggered the alert, the DIAObject (or SSObject) record, 12 months of previous DIASource records corresponding to the object (if available), and cut-outs of images (from both the template image and the difference image) of sufficient areal coverage to identify the DIASource and its immediate surroundings. These cutouts should include WCS, PSF, variance and mask information. The Alert should also include program and/or scheduler metadata. */ }
  requirement def 'DMSR-3034' { doc /* The DMS shall associate clusters of DIASources detected on multiple visits taken at different times with either a DIAObject or an SSObject. */ }
  requirement def 'DMSR-4925' { doc /* It shall be possible for DMS to make use of approved external catalogs and observations to improve the identification of SSObjects, and therefore increase the purity of the transient Alert stream in nightly processing. */ }
  requirement def 'DMSR-7738' { doc /* The DMS shall create a DIAForcedSource Catalog, consisting of measured fluxes for entries in the DIAObject Catalog on Difference Exposures. Measurements for each forcedsource shall include the DIAObject and visit IDs, the modeled flux and error (given fixed position, shape, and deblending parameters), and measurement quality flags. */ }
  requirement def 'DMSR-5583' { doc /* For alert production, DIAObject variability characterization shall include data collected during the time period from the present to at least diaCharacterizationCutoff in the past. */ }
  requirement def 'DMSR-7896' { doc /* A L1 DIASource to L2 Object positional cross-match table or database view shall be made available. */ }
  requirement def 'DMSR-5758' { doc /* The DMS shall derive and persist a background model (both due to night sky and astrophysical) for each visit image, per CCD. */ }
  requirement def 'DMSR-8680' { doc /* The persisted format for Processed Visit Images shall be fully documented, and shall include a description of all image characterization data products. */ }
  requirement def 'DMSR-8509' { doc /* Quantities delivered by all measurement algorithms shall include maximum likelihood values and covariances. */ }
  requirement def 'DMSR-1753' { doc /* All catalogs shall record source measurements in flux units. */ }
  requirement def 'DMSR-3992' { doc /* The DMS shall associate Sources measured at different times and in different passbands with entries in the Object catalog. */ }
  requirement def 'DMSR-1687' { doc /* The DMS shall compute a photometric redshift for all detected Objects. */ }
  requirement def 'DMSR-7937' { doc /* The DMS shall determine a characterization of the PSF for any specified location in coadded images. */ }
  requirement def 'DMSR-4655' { doc /* The DMS shall produce images for EPO purposes, according to the requirements in the DM-EPO ICD. */ }
  requirement def 'DMSR-6393' { doc /* For each Coadded Image, DMS shall store: the list of input images and the pipeline parameters, including software versions, used to derive it, and a sufficient set of metadata attributes for users to re-create them in whole or in part. */ }
  requirement def 'DMSR-4559' { doc /* The DMS shall create a Catalog containing all Sources detected in single (standard) visits and on Co-Adds, and will contain an identifier of the Exposure on which the Source was detected, as well as measurements of Source Attributes. The measured attributes (and associated errors) include location on the focal plane; a static point-source model fit to world coordinates and flux; a centroid and adaptive moments; and surface brightnesses through elliptical multiple apertures that are concentric, PSF-homogenized, and logarithmically spaced in intensity. */ }
  requirement def 'DMSR-7543' { doc /* The DMS shall create a Forced-Source Catalog, consisting of measured fluxes for all entries in the Object Catalog on all Processed Visit Images and Difference Images. Measurements for each forced-source shall include the object and visit IDs, the modelled flux and error (given fixed position, shape, and deblending parameters), and measurement quality flags. */ }
  requirement def 'DMSR-2332' { doc /* The DMS shall create an Object Catalog, based on sources deblended based on knowledge of CoaddSource, DIASource, DIAObject, and SSObject Catalogs, after multi-epoch spatial association and characterization. */ }
  requirement def 'DMSR-5844' { doc /* Each entry in the Object Catalog shall include the following characterization measures: a point-source model fit, a bulge-disk model fit, standard colors, a centroid, adaptive moments, Petrosian and Kron fluxes, surface brightness at multiple apertures, proper motion and parallax, and a variability characterization. */ }
  requirement def 'DMSR-7886' { doc /* The DMS shall, in the course of creating the master Source Catalog, create a catalog from the coadds of all sources detected in each passband with a SNR > coaddDetectThresh. */ }
  requirement def 'DMSR-6165' { doc /* Coadd Images shall be created by combining spatially overlapping Processed Visit Images (on which bad pixels and transient sources have been masked), where the contributing Processed Visit Images have been re-projected to a common reference geometry, and matched to a common background level which best approximates the astrophysical background. */ }
  requirement def 'DMSR-4797' { doc /* The DMS shall periodicaly create Co-added Images in each of the u,g,r,i,z,y passbands by combining all archived exposures taken of the same region of sky and in the same passband that meet specified quality conditions. */ }
  requirement def 'DMSR-6641' { doc /* The DMS shall periodically create Template Images in each of the u,g,r,i,z,y passbands that are constructed identically to Deep Detection Coadds, but where the contributing Calibrated Exposures are limited to a range of observing epochs templateMaxTimespan, the images are partitioned by airmass into multiple bins, and where the quality criteria may be different. */ }
  requirement def 'DMSR-7558' { doc /* The DMS shall periodically create Multi-band Coadd images which are constructed similarly to Deep Detection Coadds, but where all passbands are combined. */ }
  requirement def 'DMSR-8515' { doc /* It shall be possible for special programs to trigger their own data processing recipes. It shall also be possible for special programs data to be processed with the promptand/or annual-release pipelines alongside data from the main survey. */ }
  requirement def 'DMSR-5745' { doc /* During Data Release Processing, all the Level 1 data products shall be regenerated using the current best algorithms. */ }
  requirement def 'DMSR-3254' { doc /* Image depth and mask information shall be available in a parametrized approximate form in addition to a full per-pixel form. */ }
  requirement def 'DMSR-4180' { doc /* Data Release Processing shall generate co-adds suitable for use in all-sky visualization tools, allowing panning and zooming of the entire data release. */ }
  requirement def 'DMSR-4909' { doc /* Best seeing coadds shall be made for each band (including multi-color). */ }
  requirement def 'DMSR-6573' { doc /* Common derived quantities shall be made available to end-users by either providing pre-computed columns or providing functions that can be used dynamically in queries. These should at least include the ability to calculate the reduced chi-squared of fitted models and make it as easy as possible to calculate color-color diagrams. */ }
  requirement def 'DMSR-2803' { doc /* One (ugrizy plus multi-band) set of PSF-matched coadds shall be made but shall not be archived. */ }
  requirement def 'DMSR-5774' { doc /* The DMS shall be able to detect faint objects showing long-term variability, or nearby object with high proper motions. */ }
  requirement def 'DMSR-8352' { doc /* It shall be possible to detect extended low surface brightness objects in coadds. */ }
  requirement def 'DMSR-7444' { doc /* It shall be possible to associate an Object in one data release to the most likely match in the Object table from another data release. This shall be possible without the previous data releases being online. */ }
  requirement def 'DMSR-1178' { doc /* Data Release Production shall include the production of an all-sky image map for the existing coadded image area in each filter band, and at least one pre-defined all-sky color image map, following the IVOA HiPS Recommendation. */ }
  requirement def 'DMSR-5840' { doc /* The HiPS maps produced by the Data Management system shall provide for straightforward linkage from the HiPS data to the underlying LSST coadded images. This SHOULD be implemented using a mechanism supported by both the LSST Science Platform and by community tools. */ }
  requirement def 'DMSR-2015' { doc /* Data Release Production shall include the production of Multi-Order Coverage maps for the survey data, conformant with the IVOA MOC recommendation. A separate MOC shall be produced for each filter band for the main survey. Additional MOCs SHOULD be produced to represent special-programs datasets and other collections of on-sky data. */ }
  requirement def 'DMSR-4282' { doc /* Detected moving objects and associated metadata shall be available for public access in the DMS science data archive within time L1PublicT of their generation by the DMS. */ }
  requirement def 'DMSR-9267' { doc /* The DMS shall produce a catalog of all Solar System Objects (SSObjects) that have been identified via Moving Object Processing. The SSObject catalog shall include for each entry attributes including at least the following: Osculating orbital elements and associated uncertainties, minimum orbit intersection distance (MOID), mean absolute magnitude and slope parameter per band and associated errors, and flags that describe conditions of the description. */ }
  requirement def 'DMSR-5020' { doc /* Upon identifying a new SSObject, the DMS shall associate additional DIAObjects that are consistent with the orbital parameters (precovery), and update DIAObject entries so associated. */ }
  requirement def 'DMSR-6426' { doc /* For all DIASources not associated with either DIAObjects or SSObjects, the DMS shall perform forced photometry at the location of the new source (precovery) on all Difference Exposures obtained in the prior precoveryWindow, and make the results publicly available within L1PublicT. */ }
  requirement def 'DMSR-1346' { doc /* A ”precovery service” shall be available to end-users to request precovery for a provided sky location across all previous visits, making the results available within precoveryServiceElapsed hours of the request and supporting at least precoveryServicePeakUsers submissions per hour. */ }
  requirement def 'DMSR-4733' { doc /* Data products for special programs shall be stored in databases that are distinct from those used to store standard Level 1 and Level 2 data products. It shall be possible for these databases to be federated with the Level 1 and Level 2 databases to allow crossqueries and joins. */ }
  requirement def 'DMSR-8454' { doc /* The DMS shall produce on an as-needed basis a map of detector pixels that are affected by one or more pathologies, such as non-responsive pixels, charge traps, and hot pixels. The particular pathologies shall be bit-encoded in, at least, 32-bit pixel values, so that additional pathologies may also be recorded in down-stream processing software. */ }
  requirement def 'DMSR-6957' { doc /* The DMS shall construct on an as-needed basis an image that corrects for any temporally stable bias structure that remains after overscan correction. The Bias Residual shall be constructed from multiple, zero-second exposures where the overscan correction has been applied. */ }
  requirement def 'DMSR-7349' { doc /* The DMS shall, on an as-needed basis, determine from appropriate calibration data what fraction of the signal detected in any given amplifier on each sensor in the focal plane appears in any other amplifier, and shall record that fraction in a correction matrix. The applicability of the correction matrix shall be verified in production processing on science data. */ }
  requirement def 'DMSR-7118' { doc /* The DMS shall produce on an as-needed basis an image that corrects for the non-uniform illumination of the flat-field calibration apparatus on the focal plane. The effectiveness of the Illumination Correction shall be verified in production processing on science data. */ }
  requirement def 'DMSR-7466' { doc /* The DMS shall produce on an as-needed basis an image that corrects for the color-dependent, pixel-to-pixel non-uniformity in the detector response. The images in the cube shall be constructed from exposures at multiple wavelengths of a uniformly illuminated source. The effectiveness of the flat-field shall be verified in production processing on science data. */ }
  requirement def 'DMSR-5126' { doc /* The DMS shall produce and archive Calibration Data Products that capture the signature of the telescope, camera and detector, including at least: Crosstalk correction matrix, Bias and Dark correction frames, a set of monochromatic dome flats spanning the wavelength range, a synthetic broad-band flat per filter, and an illumination correction frame per filter. */ }
  requirement def 'DMSR-1929' { doc /* For each Calibration Production data product, DMS shall record: the list of input exposures and the range of dates over which they were obtained; the processing parameters; the calibration products used to derive it; and a set of metadata attributes including at least: the date of creation; the calibration image type (e.g. dome flat, superflat, bias, etc); the provenance of the processing software; and the instrument configuration including the filter in use, if applicable. */ }
  requirement def 'DMSR-1633' { doc /* The DMS shall produce on an as-needed basis a dark current correction image, which is constructed from multiple, closed-shutter exposures of appropriate duration. The effectiveness of the Dark Correction shall be verified in production processing on science data. */ }
  requirement def 'DMSR-4608' { doc /* The DMS shall produce on an as-needed basis an image that corrects for detector fringing. The effectiveness of the Fringe Correction shall be verified in production processing on science data. */ }
  requirement def 'DMSR-4919' { doc /* The DMS shall provide for the ability to process data from other electronic, pixel-oriented astronomical imaging cameras. */ }
  requirement def 'DMSR-5837' { doc /* The DMS shall provide software to represent the coordinate transformations relating the collimated beam projector position and telescope pupil position to the illumination position on the telescope optical elements and focal plane. */ }
  requirement def 'DMSR-8498' { doc /* The DMS shall provide a means for recording provenance information for Level 3 processing that is performed at DACs, covering at least all the DMS-provided inputs to the processing (e.g., catalog data used as inputs, dataset metadata, calibrations and camera data from the EFD). */ }
  requirement def 'DMSR-1890' { doc /* The DMS shall provide a software framework that facilitates Level 3 processing of catalogs. This framework shall provide a means for applying user-provided processing to catalog data, including measuring and ensuring the completeness of the application - i.e., that the specified processing was applied to all of, and only, the entire contents of the desired catalog(s). */ }
  requirement def 'DMSR-2006' { doc /* The DMS shall provide a software framework that facilitates Level 3 processing of image data. This framework shall provide a means for applying user-provided processing to image data, including measuring and ensuring the completeness of the application - i.e., that the specified processing was applied to all of, and only, the entire contents of the desired dataset. */ }
  requirement def 'DMSR-7045' { doc /* A Dataset may consist of one or more pixel images, a set of records in a file or database, or any other grouping of data that are processed or produced as a logical unit. The DMS shall be able to identify and retrieve complete, consistent datasets for processing. */ }
  requirement def 'DMSR-6199' { doc /* The DMS shall provide an interface that allows retrieval by productions or science users of datasets from any Facility where they may reside without requiring reconfiguration. */ }
  requirement def 'DMSR-2078' { doc /*  */ }
  requirement def 'DMSR-7893' { doc /* The DMS shall provide software to define (and redefine without recompilation) a pipeline task containing a science algorithm, which may in turn consist of the execution of other subtasks. */ }
  requirement def 'DMSR-1156' { doc /* The DMS shall provide software to define, override components of, and verify the suitability of the configuration for a task. */ }
  requirement def 'DMSR-5747' { doc /* The infrastructure will incorporate as fault-tolerance features to prevent loss of data in the event of hardware or software failure. */ }
  requirement def 'DMSR-5883' { doc /* The DMS shall provide data communications infrastructure to accept science data and associated metadata read-outs, and the collection of ancillary and engineering data, for transfer to the base facility. */ }
  requirement def 'DMSR-6601' { doc /* The DMS shall provide communications infrastructure between the Summit Facility and the Base Facility sufficient to carry scientific data and associated metadata for each image in no more than time summToBaseMaxTransferTime. */ }
  requirement def 'DMSR-6358' { doc /* The Summit to Base communications shall be highly available, with Mean Time Between Failures (MTBF) > summToBaseNetMTBF. */ }
  requirement def 'DMSR-3877' { doc /* The Summit to Base communications shall be highly reliable, with Mean Time to Repair (MTTR) < summToBaseNetMTTR. */ }
  requirement def 'DMSR-8923' { doc /* The Summit to Base communications shall provide at least one secondary link or transport mechanism for minimal operations support in the event of extended outage. This link may include redundant fiber optics, microwaves, or transportable media. It shall be capable of transferring one night’s worth of raw data in summToBaseNet2TransMax or less. */ }
  requirement def 'DMSR-8544' { doc /* The Summit to Base communications link shall be owned and operated by LSST and/or the operations entity to ensure responsiveness of support. */ }
  requirement def 'DMSR-1253' { doc /* The DMS shall provide communications infrastructure between the Base Facility and the Archive Center sufficient to carry scientific data and associated metadata for each image in no more than time baseToArchiveMaxTransferTime. */ }
  requirement def 'DMSR-5740' { doc /* The Base to Archive communications shall be highly available, with MTBF > baseToArchNetMTBF. */ }
  requirement def 'DMSR-9950' { doc /* The Base to Archive communications shall be highly reliable, with MTTR < baseToArchNetMTTR. */ }
  requirement def 'DMSR-9081' { doc /* The Base to Archive communications shall provide secondary link or transport mechanism (e.g. protected circuit) for operations support and ”catch up” in the event of extended outage. This secondary link shall be capable of ”bursting” to at least twice the capacity of the primary link. */ }
  requirement def 'DMSR-4835' { doc /* The DMS shall provide communications infrastructure between the Archive Center and Data Access Centers sufficient to carry scientific data and associated metadata in support of community and EPO access. Aggregate bandwidth for data transfers from the Archive Center to Data Centers shall be at least archToDacBandwidth. */ }
  requirement def 'DMSR-5865' { doc /* The Archive to Data Access Center communications shall be highly available, with MTBF > archToDacNetMTBF. */ }
  requirement def 'DMSR-2330' { doc /* The Archive to Data Access Center communications shall be highly reliable, with MTTR < archToDacNetMTTR. */ }
  requirement def 'DMSR-5282' { doc /* The Archive to Data Access Center communications shall provide secondary link or transport mechanism (e.g. protected circuit) for operations support and ”catch up” in the event of extended outage. */ }
  requirement def 'DMSR-5606' { doc /* At least dacMinConnections simultaneous connections shall be supported at each Data Access Center. */ }
  requirement def 'DMSR-6362' { doc /* The Base LAN shall provide minBaseWiFi Wireless LAN (WiFi) and Wireless Access Points in the Base Facility to support connectivity of individual user’s computers to the network backbones. */ }
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
  part def 'Alert Production Def';
  part 'Alert Production' : 'Alert Production Def';
  satisfy 'DMSR-6009' by 'Alert Production';
  satisfy 'DMSR-7154' by 'Alert Production';
  satisfy 'DMSR-5048' by 'Alert Production';
  satisfy 'DMSR-8796' by 'Alert Production';
  satisfy 'DMSR-4744' by 'Alert Production';
  satisfy 'DMSR-2295' by 'Alert Production';
  satisfy 'DMSR-4749' by 'Alert Production';
  satisfy 'DMSR-8783' by 'Alert Production';
  satisfy 'DMSR-4926' by 'Alert Production';
  satisfy 'DMSR-2737' by 'Alert Production';
  satisfy 'DMSR-3610' by 'Alert Production';
  satisfy 'DMSR-4041' by 'Alert Production';
  satisfy 'DMSR-1714' by 'Alert Production';
  satisfy 'DMSR-8107' by 'Alert Production';
  satisfy 'DMSR-2232' by 'Alert Production';
  satisfy 'DMSR-2465' by 'Alert Production';
  satisfy 'DMSR-5128' by 'Alert Production';
  satisfy 'DMSR-3677' by 'Alert Production';
  satisfy 'DMSR-2187' by 'Alert Production';
  satisfy 'DMSR-6306' by 'Alert Production';
  satisfy 'DMSR-9168' by 'Alert Production';
  satisfy 'DMSR-5354' by 'Alert Production';
  satisfy 'DMSR-3034' by 'Alert Production';
  satisfy 'DMSR-4925' by 'Alert Production';
  satisfy 'DMSR-5732' by 'Alert Production';
  satisfy 'DMSR-9273' by 'Alert Production';
  satisfy 'DMSR-7738' by 'Alert Production';
  satisfy 'DMSR-5583' by 'Alert Production';
  satisfy 'DMSR-5225' by 'Alert Production';
  satisfy 'DMSR-7896' by 'Alert Production';
  satisfy 'DMSR-5758' by 'Alert Production';
  satisfy 'DMSR-8680' by 'Alert Production';
  satisfy 'DMSR-8509' by 'Alert Production';
  satisfy 'DMSR-6637' by 'Alert Production';
  satisfy 'DMSR-1753' by 'Alert Production';
  part def 'Calibration SW Def';
  part 'Calibration SW' : 'Calibration SW Def';
  satisfy 'DMSR-7584' by 'Calibration SW';
  satisfy 'DMSR-1575' by 'Calibration SW';
  satisfy 'DMSR-2104' by 'Calibration SW';
  satisfy 'DMSR-5732' by 'Calibration SW';
  part def 'Data Release Production Def';
  part 'Data Release Production' : 'Data Release Production Def';
  satisfy 'DMSR-5048' by 'Data Release Production';
  satisfy 'DMSR-4749' by 'Data Release Production';
  satisfy 'DMSR-8783' by 'Data Release Production';
  satisfy 'DMSR-3992' by 'Data Release Production';
  satisfy 'DMSR-4926' by 'Data Release Production';
  satisfy 'DMSR-2737' by 'Data Release Production';
  satisfy 'DMSR-1687' by 'Data Release Production';
  satisfy 'DMSR-7937' by 'Data Release Production';
  satisfy 'DMSR-3610' by 'Data Release Production';
  satisfy 'DMSR-4655' by 'Data Release Production';
  satisfy 'DMSR-6393' by 'Data Release Production';
  satisfy 'DMSR-4559' by 'Data Release Production';
  satisfy 'DMSR-7543' by 'Data Release Production';
  satisfy 'DMSR-2332' by 'Data Release Production';
  satisfy 'DMSR-5844' by 'Data Release Production';
  satisfy 'DMSR-7886' by 'Data Release Production';
  satisfy 'DMSR-6165' by 'Data Release Production';
  satisfy 'DMSR-4797' by 'Data Release Production';
  satisfy 'DMSR-6641' by 'Data Release Production';
  satisfy 'DMSR-7558' by 'Data Release Production';
  satisfy 'DMSR-5732' by 'Data Release Production';
  satisfy 'DMSR-8515' by 'Data Release Production';
  satisfy 'DMSR-5745' by 'Data Release Production';
  satisfy 'DMSR-3254' by 'Data Release Production';
  satisfy 'DMSR-4180' by 'Data Release Production';
  satisfy 'DMSR-4909' by 'Data Release Production';
  satisfy 'DMSR-6573' by 'Data Release Production';
  satisfy 'DMSR-8509' by 'Data Release Production';
  satisfy 'DMSR-2803' by 'Data Release Production';
  satisfy 'DMSR-5774' by 'Data Release Production';
  satisfy 'DMSR-1753' by 'Data Release Production';
  satisfy 'DMSR-8352' by 'Data Release Production';
  satisfy 'DMSR-7444' by 'Data Release Production';
  satisfy 'DMSR-1178' by 'Data Release Production';
  satisfy 'DMSR-5840' by 'Data Release Production';
  satisfy 'DMSR-2015' by 'Data Release Production';
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
  part def 'Special Programs Productions Def';
  part 'Special Programs Productions' : 'Special Programs Productions Def';
  satisfy 'DMSR-8515' by 'Special Programs Productions';
  satisfy 'DMSR-4733' by 'Special Programs Productions';
  part def 'Template Generation Def';
  part 'Template Generation' : 'Template Generation Def';
  satisfy 'DMSR-6641' by 'Template Generation';
  satisfy 'DMSR-5732' by 'Template Generation';
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
  part def 'Science Pipelines Distribution Def';
  part 'Science Pipelines Distribution' : 'Science Pipelines Distribution Def';
  satisfy 'DMSR-8454' by 'Science Pipelines Distribution';
  satisfy 'DMSR-6957' by 'Science Pipelines Distribution';
  satisfy 'DMSR-7349' by 'Science Pipelines Distribution';
  satisfy 'DMSR-7118' by 'Science Pipelines Distribution';
  satisfy 'DMSR-7466' by 'Science Pipelines Distribution';
  satisfy 'DMSR-5126' by 'Science Pipelines Distribution';
  satisfy 'DMSR-1929' by 'Science Pipelines Distribution';
  satisfy 'DMSR-2104' by 'Science Pipelines Distribution';
  satisfy 'DMSR-1633' by 'Science Pipelines Distribution';
  satisfy 'DMSR-4608' by 'Science Pipelines Distribution';
  satisfy 'DMSR-2704' by 'Science Pipelines Distribution';
  satisfy 'DMSR-5732' by 'Science Pipelines Distribution';
  part def 'Science Pipelines Libraries Def';
  part 'Science Pipelines Libraries' : 'Science Pipelines Libraries Def';
  satisfy 'DMSR-4749' by 'Science Pipelines Libraries';
  satisfy 'DMSR-8783' by 'Science Pipelines Libraries';
  satisfy 'DMSR-4926' by 'Science Pipelines Libraries';
  satisfy 'DMSR-2737' by 'Science Pipelines Libraries';
  satisfy 'DMSR-3610' by 'Science Pipelines Libraries';
  satisfy 'DMSR-4919' by 'Science Pipelines Libraries';
  satisfy 'DMSR-5732' by 'Science Pipelines Libraries';
  satisfy 'DMSR-5837' by 'Science Pipelines Libraries';
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
  part def 'NCSA LAN Network Def';
  part 'NCSA LAN Network' : 'NCSA LAN Network Def';
  satisfy 'DMSR-4915' by 'NCSA LAN Network';
  satisfy 'DMSR-6886' by 'NCSA LAN Network';
  satisfy 'DMSR-5747' by 'NCSA LAN Network';
  satisfy 'DMSR-4278' by 'NCSA LAN Network';
  satisfy 'DMSR-4835' by 'NCSA LAN Network';
  satisfy 'DMSR-5865' by 'NCSA LAN Network';
  satisfy 'DMSR-2330' by 'NCSA LAN Network';
  satisfy 'DMSR-5282' by 'NCSA LAN Network';
  satisfy 'DMSR-7661' by 'NCSA LAN Network';
  satisfy 'DMSR-5606' by 'NCSA LAN Network';
  part def 'Network Management Def';
  part 'Network Management' : 'Network Management Def';
  satisfy 'DMSR-4419' by 'Network Management';
  satisfy 'DMSR-5747' by 'Network Management';
  satisfy 'DMSR-4278' by 'Network Management';
  satisfy 'DMSR-8544' by 'Network Management';
}