//
//  PeopleTableViewController.h
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-01-12.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PeopleTableViewController : UITableViewController {
	IBOutlet UITableView * usersTable;
	UIActivityIndicatorView * activityIndicator;
	NSMutableArray * users;
	
	// a temporary item; added to the "Users" array one at a time, and cleared for the next one
	NSMutableDictionary * item;
}

@end
