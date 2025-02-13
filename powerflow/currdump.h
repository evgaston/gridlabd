// $Id: currdump.h 4738 2014-07-03 00:55:39Z dchassin $
//	Copyright (C) 2008 Battelle Memorial Institute

#ifndef _currdump_H
#define _currdump_H

#ifndef _POWERFLOW_H
#error "this header must be included by powerflow.h"
#endif

typedef enum {
	CDM_RECT,
	CDM_POLAR
} CDMODE;

class currdump : public gld_object
{
public:
	TIMESTAMP runtime;
	char32 group;
	char256 filename;
	int32 runcount;
	enumeration mode;
	double interval;
	int32 maxcount;
	char8 filemode;
public:
	static CLASS *oclass;
public:
	currdump(MODULE *mod);
	int create(void);
	int init(OBJECT *parent);
	TIMESTAMP commit(TIMESTAMP t);
	int isa(char *classname);

	void dump(TIMESTAMP t);
};

#endif // _currdump_H

