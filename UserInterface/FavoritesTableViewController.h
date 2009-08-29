//
//  FavoritesTableViewController.h
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-01-25.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FavoritesTableViewController : UITableViewController {
	IBOutlet UITableView * favoritesTable;
	UIActivityIndicatorView * activityIndicator;
	NSMutableArray * favorites;
	
	// a temporary item; added to the "Favorites" array one at a time, and cleared for the next one
	NSMutableDictionary * item;
}

@end
