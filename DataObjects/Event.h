//
//  Event.h
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-08-22.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@interface Event : SQLitePersistentObject {
	NSNumber *eventId;
    NSString *title;
	NSString *description;
	NSString *eventType;
    NSNumber *camp;
    NSNumber *art;
	NSString *otherLocation;
	NSString *website;
	NSString *emailAddress;
	NSNumber *latitude;
	NSNumber *longitude;
	NSNumber *allDay;
	NSString *startTime;
	NSString *endTime;
}

@property (nonatomic,readwrite,retain) NSNumber *eventId;
@property (nonatomic,readwrite,retain) NSString *title;
@property (nonatomic,readwrite,retain) NSString *description;
@property (nonatomic,readwrite,retain) NSString *eventType;
@property (nonatomic,readwrite, retain) NSNumber *camp;
@property (nonatomic,readwrite, retain) NSNumber *art;
@property (nonatomic,readwrite,retain) NSString *otherLocation;
@property (nonatomic,readwrite,retain) NSString *website;
@property (nonatomic,readwrite,retain) NSString *emailAddress;
@property (nonatomic,readwrite, retain) NSNumber *latitude;
@property (nonatomic,readwrite, retain) NSNumber *longitude;
@property (nonatomic,readwrite, retain) NSNumber *allDay;
@property (nonatomic,readwrite, retain) NSString *startTime;
@property (nonatomic,readwrite, retain) NSString *endTime;
@end