//
//  Favorite.h
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-08-32.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@interface Favorite : SQLitePersistentObject {
    NSString *type;
	NSNumber *objectId;
	NSDate *dateSaved;
}

@property (nonatomic,readwrite,retain) NSString *type;
@property (nonatomic,readwrite, retain) NSNumber *objectId;
@property (nonatomic,readwrite, retain) NSDate *dateSaved;

@end
