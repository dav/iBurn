//
//  iBurnAppDelegate.m
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-01-11.
//  Copyright Burning Man Earth 2009. All rights reserved.
//

#import "iBurnAppDelegate.h"
#import "TestViewController.h"
#import "MapViewController.h"
#import "CampTableViewController.h"
#import "ArtTableViewController.h"
#import "TweetTableViewController.h"
#import "MessageTableViewController.h"
#import "EventCalendarViewController.h"
#import "NewsViewController.h"
#import "SyncViewController.h"
#import "SettingsTableViewController.h"
#import "PeopleTableViewController.h"
#import "CarsTableViewController.h"
#import "FavoritesTableViewController.h"
#import "ThemeCamp.h"
#import "SQLiteInstanceManager.h"
#import "OAuthConsumer.h"
//#import <JSON/JSON.h>
//#import <JSON/SBJSON.h>

@implementation iBurnAppDelegate

@synthesize window, themeCamps, launchDefault;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	launchDefault = YES;
	[self performSelector:@selector(postLaunch) withObject:nil afterDelay:0.0];
}

- (void)postLaunch{
	if(launchDefault) {
		databaseName = @"iBurnDB.sqlite";
	
		NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDir = [documentPaths objectAtIndex:0];
		databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	
		[self checkOrCreateDatabase];
		[self initializeDatabase];
	
		//[self initializeOAuthConsumer];
	
		NSMutableArray *controllers = [[NSMutableArray alloc] init];
		
		MapViewController *mapViewController = [[MapViewController alloc] initWithTitle:@"Map"];
		UINavigationController *mapNav = [[UINavigationController alloc] initWithRootViewController:mapViewController];
		mapNav.navigationBar.barStyle = UIBarStyleBlackTranslucent;
		[controllers addObject:mapNav];

		ArtTableViewController *artViewController = [[ArtTableViewController alloc] init];
		artViewController.mapDelegate = mapViewController;		
		UINavigationController *artNav = [[UINavigationController alloc] initWithRootViewController:artViewController];
		artNav.navigationBar.barStyle = UIBarStyleBlackTranslucent;
		[controllers addObject:artNav];			
	
		CampTableViewController *campsViewController = [[CampTableViewController alloc] init];
		campsViewController.mapDelegate = mapViewController;
		UINavigationController *campsNav = [[UINavigationController alloc] initWithRootViewController:campsViewController];
		campsNav.navigationBar.barStyle = UIBarStyleBlackTranslucent;
		[controllers addObject:campsNav];
	
		EventCalendarViewController *eventsViewController = [[EventCalendarViewController alloc] initWithTitle:@"Events"];
		UINavigationController *eventsNav = [[UINavigationController alloc] initWithRootViewController:eventsViewController];
		eventsNav.navigationBar.barStyle = UIBarStyleBlackTranslucent;
		[controllers addObject:eventsNav];	
	
		CarsTableViewController *carsViewController = [[CarsTableViewController alloc] init];
		UINavigationController *carsNav = [[UINavigationController alloc] initWithRootViewController:carsViewController];
		carsNav.navigationBar.barStyle = UIBarStyleBlackTranslucent;
		[controllers addObject:carsNav];
	
		FavoritesTableViewController *favoritesViewController = [[FavoritesTableViewController alloc] init];
		UINavigationController *favoritesNav = [[UINavigationController alloc] initWithRootViewController:favoritesViewController];
		favoritesNav.navigationBar.barStyle = UIBarStyleBlackTranslucent;
		[controllers addObject:favoritesNav];					
		
		/*
		PeopleTableViewController *peopleViewController = [[PeopleTableViewController alloc] init];
		UINavigationController *peopleNav = [[UINavigationController alloc] initWithRootViewController:peopleViewController];
		peopleNav.navigationBar.barStyle = UIBarStyleBlackTranslucent;
		[controllers addObject:peopleNav];		

		TweetTableViewController *tweetTableViewController = [[TweetTableViewController alloc] init];
		UINavigationController *tweetsNav = [[UINavigationController alloc] initWithRootViewController:tweetTableViewController];
		tweetsNav.navigationBar.barStyle = UIBarStyleBlackTranslucent;
		[controllers addObject:tweetsNav];

		MessageTableViewController *messageTableViewController = [[MessageTableViewController alloc] init];
		UINavigationController *messagesNav = [[UINavigationController alloc] initWithRootViewController:messageTableViewController];
		messagesNav.navigationBar.barStyle = UIBarStyleBlackTranslucent;
		[controllers addObject:messagesNav];
				
		SettingsTableViewController *settingsViewController = [[SettingsTableViewController alloc] init];
		UINavigationController *settingsNav = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
		settingsNav.navigationBar.barStyle = UIBarStyleBlackTranslucent;
		[controllers addObject:settingsNav];			
		
		NewsViewController *newsViewController = [[NewsViewController alloc] init];
		UINavigationController *newsNav = [[UINavigationController alloc] initWithRootViewController:newsViewController];
		newsNav.navigationBar.barStyle = UIBarStyleBlackTranslucent;
		[controllers addObject:newsNav];
		
		SyncViewController *syncViewController = [[SyncViewController alloc] init];
		UINavigationController *syncNav = [[UINavigationController alloc] initWithRootViewController:syncViewController];
		syncNav.navigationBar.barStyle = UIBarStyleBlackTranslucent;
		[controllers addObject:syncNav];		
		 */
		UITabBarController *tbarController = [[UITabBarController alloc] init];
		tbarController.viewControllers = controllers;
		tbarController.delegate = self;
	
		//[self testOAuthAccessProtected];
		
		[window addSubview:tbarController.view];
		[window makeKeyAndVisible];
		[controllers release];
	}
}

-(void) checkOrCreateDatabase{
	BOOL exists;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	exists = [fileManager fileExistsAtPath:databasePath];
	if(exists) return;
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
	[fileManager release];
}


- (void)initializeDatabase {
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		[[SQLiteInstanceManager sharedManager] setDatabase:database];
    } else {
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
    }
}

- (void)initializeOAuthConsumer {
	OAConsumer *consumer = [[OAConsumer alloc] initWithKey:@"key" secret:@"secret"];	
	
	accessToken = [[OAToken alloc] initWithUserDefaultsUsingServiceProviderName:@"mobitag.pictearth.com" prefix:@"MobitagAccess"];
	
	NSLog(@"accessToken initializeOAuthConsumer = %@", accessToken);
	
	if(accessToken == NULL) {
		//NSURL *requestTokenURL = [NSURL URLWithString:@"https://fireeagle.yahooapis.com/oauth/request_token"];
		//NSURL *requestTokenURL = [NSURL URLWithString:@"http://mobitag.pictearthusa.com/api/1.0/oauth/request_token"];
		NSURL *requestTokenURL = [NSURL URLWithString:@"http://localhost:8000/oauth/request_token"];
		//NSURL *requestTokenURL = [NSURL URLWithString:@"http://bynotes.com/api/1.0/oauth/request_token"];
		
	
		OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:requestTokenURL
																   consumer:consumer
																	  token:nil   // we don't have a Token yet
																	  realm:nil   // our service provider doesn't specify a realm
														  signatureProvider:[[OAPlaintextSignatureProvider alloc] init]]; // use the default method, HMAC-SHA1
		
		[request setHTTPMethod:@"GET"];
		
		OADataFetcher *fetcher = [[OADataFetcher alloc] init];
		
		[fetcher fetchDataWithRequest:request
							delegate:self
				didFinishSelector:@selector(requestTokenTicket:didFinishWithData:)
				  didFailSelector:@selector(requestTokenTicket:didFailWithError:)];
	} else {
		NSLog(@"In Here");
	}
}

- (void)requestTokenTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data {
	NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	if (ticket.didSucceed) {
		requestToken = [[OAToken alloc] initWithHTTPResponseBody:responseBody];
		[requestToken storeInUserDefaultsWithServiceProviderName:@"mobitag.pictearth.com" prefix:@"MobitagRequest"];
		//NSString *xxx = [NSString stringWithFormat:@"https://fireeagle.yahoo.net/oauth/authorize?oauth_token=%@&&oauth_callback=mobitag://somethinghere",requestToken.key];
		//NSString *xxx = [NSString stringWithFormat:@"http://mobitag.pictearthusa.com/api/1.0/oauth/authorize?oauth_token=%@&oauth_callback=mobitag://somethinghere",requestToken.key];
		//NSString *xxx = [NSString stringWithFormat:@"http://bynotes.com/api/1.0/oauth/authorize?oauth_token=%@&&oauth_callback=mobitag://somethinghere",requestToken.key];
		NSString *xxx = [NSString stringWithFormat:@"http://localhost:8000/oauth/authorize?oauth_token=%@&oauth_callback=mobitag://somethinghere",requestToken.key];
		oauthUrlString = [xxx copy];
		
		UIAlertView *warning = [[UIAlertView alloc]
								initWithTitle:@"Opening Browser to Authenticate You"
								message:@"Some nice message here to tell the user whats happening"
								delegate:self 
								cancelButtonTitle:nil
								otherButtonTitles:@"OK", nil];
		[warning show];
	} else {
		NSLog(@"Request Token Ticket Failed");
	}
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger) buttonIndex {
	//This is a dirty hack, but for the moment we are only listening to one alert button
	[alertView release];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:oauthUrlString]];
}


- (BOOL)application: (UIApplication *)application handleOpenURL:(NSURL *)url {
	launchDefault = NO;
	//ByNotes
	//OAConsumer *consumer = [[OAConsumer alloc] initWithKey:@"yw1yag90ptqy290qp1qkcrqo0th4vco8" secret:@"p0syik010vu56migwh8wrcg4vy1ckco1"];
	//FireEagle
	//OAConsumer *consumer = [[OAConsumer alloc] initWithKey:@"DCMIA8IT4S1I" secret:@"sWBXgywgtsjhz7C7oMQBBsLHPXOVmJcg"];
	//Mobitag
	OAConsumer *consumer = [[OAConsumer alloc] initWithKey:@"60vnbtmjffa0jcoel9tfc0jmlcc8lrnp" secret:@"10e7cer098glrzwysogwhajne7rafkrv"];
	
	//NSURL *accessTokenURL = [NSURL URLWithString:@"https://fireeagle.yahooapis.com/oauth/access_token"];
	NSURL *accessTokenURL = [NSURL URLWithString:@"http://mobitag.pictearthusa.com/api/1.0/oauth/access_token"];
	//NSURL *accessTokenURL = [NSURL URLWithString:@"http://bynotes.com/api/1.0/oauth/access_token"];	
	
	requestToken = [[OAToken alloc] initWithUserDefaultsUsingServiceProviderName:@"mobitag.pictearth.com" prefix:@"MobitagRequest"];
	NSLog(@"requestToken in handleOpenURL = %@", requestToken);
	OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:accessTokenURL
																   consumer:consumer
																	  token:requestToken
																	  realm:nil 
														  signatureProvider:[[OAHMAC_SHA1SignatureProvider alloc] init]];
	
	[request setHTTPMethod:@"POST"];
	
	OADataFetcher *fetcher = [[OADataFetcher alloc] init];
	
	[fetcher fetchDataWithRequest:request
						 delegate:self
				didFinishSelector:@selector(accessTokenTicket:didFinishWithData:)
				  didFailSelector:@selector(accessTokenTicket:didFailWithError:)];
	return YES;
}

- (void) accessTokenTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data {
	if (ticket.didSucceed) {
		NSString *responseBody = [[NSString alloc] initWithData:data
													   encoding:NSUTF8StringEncoding];	
		accessToken = [[OAToken alloc] initWithHTTPResponseBody:responseBody];
		[accessToken storeInUserDefaultsWithServiceProviderName:@"mobitag.pictearth.com" prefix:@"MobitagAccess"];
		launchDefault = YES;
		[self postLaunch];
	} else {
		NSLog(@"accessTokenTicket Failed in didFinishWithData");
	}
}


- (void) testOAuthAccessProtected {
	accessToken = [[OAToken alloc] initWithUserDefaultsUsingServiceProviderName:@"mobitag.pictearth.com" prefix:@"MobitagAccess"];
	NSLog(@"accessToken in testOAuthAccess Protected = %@", accessToken);
	//ByNotes
	//OAConsumer *consumer = [[OAConsumer alloc] initWithKey:@"yw1yag90ptqy290qp1qkcrqo0th4vco8" secret:@"p0syik010vu56migwh8wrcg4vy1ckco1"];
	//FireEagle
	//OAConsumer *consumer = [[OAConsumer alloc] initWithKey:@"DCMIA8IT4S1I" secret:@"sWBXgywgtsjhz7C7oMQBBsLHPXOVmJcg"];
	//Mobitag
	OAConsumer *consumer = [[OAConsumer alloc] initWithKey:@"60vnbtmjffa0jcoel9tfc0jmlcc8lrnp" secret:@"10e7cer098glrzwysogwhajne7rafkrv"];
	
	NSURL *url = [NSURL URLWithString:@"http://mobitag.pictearthusa.com/api/1.0/rest/oauth/user/profile.json"];
	//NSURL *url = [NSURL URLWithString:@"https://fireeagle.yahooapis.com/api/0.1/user.json"];
	//NSURL *url = [NSURL URLWithString:@"http://bynotes.com/api/1.0/rest/oauth/position/position.json"];	
	
    OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:url
                                                                   consumer:consumer
                                                                      token:accessToken
                                                                      realm:nil
                                                          signatureProvider:[[OAPlaintextSignatureProvider alloc] init]];
	[request setHTTPMethod:@"GET"];
	
	//OARequestParameter *addressParam = [[OARequestParameter alloc] initWithName:@"address" value:@"319 S. Ditmar #1 Oceanside, CA"];
	//NSArray *params = [NSArray arrayWithObjects:addressParam,  nil];
    //[request setParameters:params];

    OADataFetcher *fetcher = [[OADataFetcher alloc] init];
    [fetcher fetchDataWithRequest:request
                         delegate:self
                didFinishSelector:@selector(apiTicket:didFinishWithData:)
                  didFailSelector:@selector(apiTicket:didFailWithError:)];
}

- (void) apiTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data {
	NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];	
	
	/*
	//SBJSON *jsonParser = [SBJSON new];
	
	NSDictionary *feed = [jsonParser objectWithString:responseBody error:NULL];
	
	NSLog(@"user: %@", [feed valueForKey:@"user"]);
	
	NSDictionary *user = (NSDictionary *)[feed valueForKey:@"user"];
	
	NSArray *location_hierarchy = (NSArray *)[user valueForKey:@"location_hierarchy"];
	
	int ndx;
	for (ndx = 0; ndx < location_hierarchy.count; ndx++) {
		NSDictionary *location = (NSDictionary *)[location_hierarchy objectAtIndex:ndx];
		NSLog(@"name: %@", [location valueForKey:@"name"]);
		NSLog(@"woeid: %@", [location valueForKey:@"woeid"]);
		NSLog(@"place_id: %@", [location valueForKey:@"place_id"]);
	}
	 */
}

- (void)dealloc {
    [window release];
    [super dealloc];
}

@end
