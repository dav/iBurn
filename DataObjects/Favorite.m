//
//  Favorite.m
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-09-23.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#include "Favorite.h"

@implementation Favorite

@synthesize type, objectId, dateSaved;

DECLARE_PROPERTIES(
	DECLARE_PROPERTY(@"type", @"@\"NSString\""),
	DECLARE_PROPERTY(@"objectId", @"@\"NSNumber\""),
	DECLARE_PROPERTY(@"dateSaved", @"@\"NSDate\"")
)

- (void)dealloc
{	
	[type release];
	[objectId release];	
	[dateSaved release];
}

@end
