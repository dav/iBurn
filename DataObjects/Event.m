//
//  Event.m
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-08-22.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#include "Event.h"

@implementation Event

@synthesize eventId, title, description, eventType, camp, art, otherLocation, website, emailAddress, allDay, startTime, endTime;

DECLARE_PROPERTIES(
    DECLARE_PROPERTY(@"eventId", @"@\"NSNumber\""),
	DECLARE_PROPERTY(@"title", @"@\"NSString\""),
	DECLARE_PROPERTY(@"description", @"@\"NSString\""),
	DECLARE_PROPERTY(@"eventType", @"@\"NSString\""),
    DECLARE_PROPERTY(@"camp", @"@\"NSNumber\""),
    DECLARE_PROPERTY(@"art", @"@\"NSNumber\""),
    DECLARE_PROPERTY(@"otherLocation", @"@\"NSString\""),
	DECLARE_PROPERTY(@"website", @"@\"NSString\""),
	DECLARE_PROPERTY(@"emailAddress", @"@\"NSString\""),
	DECLARE_PROPERTY(@"latitude", @"@\"NSNumber\""),
	DECLARE_PROPERTY(@"longitude", @"@\"NSNumber\""),
	DECLARE_PROPERTY(@"allDay", @"@\"NSNumber\""),
	DECLARE_PROPERTY(@"startTime", @"@\"NSString\""),
    DECLARE_PROPERTY(@"endTime", @"@\"NSString\"")
)

- (void)dealloc
{	
	[eventId release];
	[title release];
	[description release];
	[eventType release];
	[camp release];
	[art release];
	[otherLocation release];	
	[website release];
	[emailAddress release];
	[allDay release];
	[startTime release];
	[endTime release];
	[super dealloc];
}
@end
