// q-unit
// Simple Logging Library (log)

// Copyright (c) 2014, Jaskirat M.S. Rajasansir
// License BSD, see LICENSE for details

// DOCUMENTATION:

/ The specified log levels and the output device each level should print to
.log.cfg.levels:`DEBUG`INFO`WARN`ERROR`FATAL!(-1;-1;-1;-2;-2);

/ The standard log detail that should be printed on each log line
.log.cfg.detail:(.z.D;.z.T;.z.u;.z.h;.z.w);


/ Initialisation function that should be run to set up the Simple Logging Library
.log.init:{
	.log.i.build[];

	.log.info "Simple Logging Library initialised";
 };


/ Printing function that is used for each log level
/  @param lvl (Symbol) The log level the message is for
/  @param msg (String) The message to print
/  @see .log.cfg.levels
/  @see .log.cfg.detail
.log.i.msg:{[lvl;msg]
	.log.cfg.levels[lvl] ,[;msg] " " sv string .log.cfg.detail,lvl,`;
 };

/ Generates the logging functions
/  @see .log.i.msg
/  @see .log.cfg.levels
/  @example .log.info
.log.i.build:{
	(set) ./: ({` sv `.log,lower x};.log.i.msg)@\:/:key .log.cfg.levels;	
 };

