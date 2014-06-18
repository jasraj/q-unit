// q-unit
// Stage 2 Boot Loader

// Copyright (c) 2014, Jaskirat M.S. Rajasansir
// Licensed under the BSD (3-Clause) License (see LICENSE)

// DOCUMENTATION:

.boot.cfg.coreLibs:`log`util;

.boot.start:{[rootPath]
	.boot.i.loadRequire rootPath;
	.boot.i.loadCoreLibs[];
	
 };

.boot.i.loadRequire:{[rootPath]
	requirePath:` sv rootPath,`code`lib`require.q;
	-1 "Loading code loading library: ",string requirePath;

	@[system;"l ",string requirePath;{ -2 "Failed to load code loading library! Error - ",x; '"CodeLoaderFailedToLoadException"; }];
	@[.require.init;rootPath;{ -2 "Failed to initialise code loading library! Error - ",x; '"CodeLoaderFailedToInitException"; }];
 };

.boot.i.loadCoreLibs:{
	.require.lib each .boot.cfg.coreLibs;
 };