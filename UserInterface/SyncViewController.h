//
//  SyncViewController.h
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-01-11.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SyncViewController : UITableViewController {
	IBOutlet UITableView * syncTable;
	UIActivityIndicatorView * activityIndicator;
	UISwitch *mapSwitch;
}

@property (nonatomic, retain) UISwitch *mapSwitch;

@end

