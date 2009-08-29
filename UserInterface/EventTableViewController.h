//
//  EventTableViewController.h
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-08-22.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EventTableViewController : UITableViewController {
	IBOutlet UITableView * eventsTable;
	UIActivityIndicatorView * activityIndicator;
	NSMutableArray * events;
	NSString *dateString;
	
	// a temporary item; added to the "Events" array one at a time, and cleared for the next one
	NSMutableDictionary * item;
}

@property (nonatomic,readwrite,retain) NSString *dateString;
@end
