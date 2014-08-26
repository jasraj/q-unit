// q-unit
// Stage 2 Boot Loader

// Copyright (c) 2014, Jaskirat M.S. Rajasansir
// License BSD, see LICENSE for details

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

.boot.i.parseInputArgs:{
	inArgs:first each .Q.opt .z.x;
 };
