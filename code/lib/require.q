// q-unit
// Simple Code Loader Library (require)

// Copyright (c) 2014, Jaskirat M.S. Rajasansir
// Licensed under the BSD (3-Clause) License (see LICENSE)

// DOCUMENTATION:

.require.cfg.rootEnvVar:`QUNIT_HOME;

.require.cfg.root:`;

.require.fileSuffixes:(".q";".k";".q_";".*.q";".*.q_");

.require.paths.config:();
.require.paths.code:();


/ Validates the required root folder location variable is set. If not, an error
/ is thrown and the library will not initialise.
/  @throws QunitRootFolderNotSetException If the root folder is not set
/  @see .require.cfg.root
/  @see .require.paths.config
/  @see .require.paths.code
.require.init:{
	if[null .require.cfg.root;
		if[""~getenv .require.cfg.rootEnvVar;
			.require.logError "The qunit root folder must be defined before attempting to run it!";
			.require.logError " Set '.require.cfg.root' or environment variable 'QUNIT_HOME'";
			'"QunitRootFolderNotSetException";
		];

		.require.cfg.root:`$getenv .require.cfg.rootEnvVar;
	];

	.require.logInfo "Initialising code loader library";
	.require.loginfo " Framework root: ",string .require.cfg.root;

	.require.paths.config:` sv .require.cfg.root,`config;
	.require.paths.code:` sv/:,\[.require.cfg.root;`code`lib];
 };

/ Loads all files matching the specified library name
/  @param lib (Symbol) The library to load. Generally the file name without the file suffix
/  @see .require.fileSuffixes
/  @see .require.load
.require.lib:{[lib]
	files:raze {
		files:key x;
		files@:where any files like/: string[y],/:.require.fileSuffixes;

		:` sv/:x,/:files;
	}[;lib] each .require.paths.code; 

	.require.load each distinct files;
 };

/ Loads all files mataching the specified configuration name. NOTE: Expects the configuration
/ for a library to begin with "config". Example `log -> config.log.q
/  @param lib (Symbol) The configuration to load.
.require.config:{[cfg]
	configs:key .require.paths.config;
	configs@:where any files like/: ("config.",string cfg),/:.require.fileSuffixes;

	.require.load each ` sv/:.require.paths.config,/:files;
 };

/ Performs the load of the specified file path
/  @param file (Symbol) The file to load from disk
/  @throws FileLoadFailedException If the file fails to load for any reason
.require.load:{[file]
	.require.logInfo "Loading ",string file;
	@[system;"l ",string file;{ .require.logError "Failed to load file (",string[y],"). Error - ",x; '"FileLoadFailedException"; }[;file] ];
 };

.require.logInfo:-1;
.require.logError:-2;
