//
//  iBurnAppDelegate.h
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-01-11.
//  Copyright Burning Man Earth 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "OAuthConsumer.h"

@interface iBurnAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, UIAlertViewDelegate> {
	BOOL launchDefault;
    UIWindow *window;
	NSMutableArray *themeCamps;
	sqlite3 *database;
	NSString *databaseName;
	NSString *databasePath;
	NSString *oauthUrlString;
	
	OAToken *requestToken;
	OAToken *accessToken;
}

@property BOOL launchDefault;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) NSMutableArray *themeCamps;

- (void)checkOrCreateDatabase;
- (void)initializeDatabase;
- (void)initializeOAuthConsumer;
- (void)testOAuthAccessProtected;

@end

