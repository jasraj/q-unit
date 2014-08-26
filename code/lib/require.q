// q-unit
// Simple Code Loader Library (require)

// Copyright (c) 2014, Jaskirat M.S. Rajasansir
// License BSD, see LICENSE for details

// DOCUMENTATION:

.require.cfg.root:`;

.require.fileSuffixes:(".q";".k";".q_";".*.q";".*.q_");

.require.paths.config:();
.require.paths.code:();


/ Validates the required root folder location variable is set. If not, an error
/ is thrown and the library will not initialise.
/  @param qunitRoot (Symbol) The path of the qunit root folder
/  @throws QunitRootFolderNotSetException If the root folder is not set
/  @see .require.cfg.root
/  @see .require.paths.config
/  @see .require.paths.code
.require.init:{[qunitRoot]
	
	if[null qunitRoot;
		.require.logError "The qunit root folder must be defined before attempting to run it!";
		.require.logError " Set '.require.cfg.root' or environment variable 'QUNIT_HOME'";
		'"QunitRootFolderNotSetException";
	];

	.require.cfg.root:qunitRoot;
	.require.paths.config:` sv .require.cfg.root,`config;
	.require.paths.code:` sv/:,\[.require.cfg.root;`code`lib];

	.require.logInfo "Code loader library successfully initialised";
	.require.logInfo " Root path:\t",string .require.cfg.root;
	.require.logInfo " Code paths:\t"," | " sv string .require.paths.code;
	.require.logInfo " Config path:\t",string .require.paths.config;


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

	initF:` sv `,lib,`init;
	.require.logInfo "Initialising library '",string[lib],"' (",string[initF],")";

	@[get initF;::;{ .require.logError "Failed to initalise library '",string[y],"' (",string[z],"). Error - ",x; '"LibraryFailedToInitException (",string[y],")"; }[;lib;initF] ];
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
