// q-unit
// Stage 1 Boot Loader

// Copyright (c) 2014, Jaskirat M.S. Rajasansir
// Licensed under the BSD (3-Clause) License (see LICENSE)

// DOCUMENTATION:

{
	-1 "";
	root:getenv`QUNIT_HOME;

	if[""~root;
		-2 "";
		-2 "The q-unit bootstrapper expects the root folder to be defined in the environment variable 'QUNIT_HOME'";
		-2 " This is not currently set. Please set and try again.\n";
		
		exit 1;
	];
	
	root:`$":",root;
	stage2:` sv root,`code`bootStage2.q;

	@[system;"l ",string stage2;{ -2 "Failed to load stage 2 bootloader! Error - ",x; '"Stage2BootLoaderFailedException" }];

	.boot.start root;
 }[]
