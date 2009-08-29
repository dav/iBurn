//
//  PeopleInfoViewController.h
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-05-25.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@interface PeopleInfoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    User *user;
	UITableView *tableView;
	CGSize cellSize;
    NSIndexPath *selectedIndexPath;
}

@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;

@end