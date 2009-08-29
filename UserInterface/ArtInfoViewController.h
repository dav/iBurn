//
//  ArtInfoViewController.h
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-01-18.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArtInstall;

@interface ArtInfoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    ArtInstall *art;
	UITableView *tableView;
	CGSize cellSize;
    NSIndexPath *selectedIndexPath;
	UILabel *descriptionLabel;
}

@property (nonatomic, retain) ArtInstall *art;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
@property (nonatomic, retain) UILabel *descriptionLabel;

@end


