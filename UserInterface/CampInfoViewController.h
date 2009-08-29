//
//  CampInfoViewController.h
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-01-18.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ThemeCamp;

@interface CampInfoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    ThemeCamp *camp;
	UITableView *tableView;
	CGSize cellSize;
    NSIndexPath *selectedIndexPath;
	UILabel *descriptionLabel;
	UIWebView *webView;
}

@property (nonatomic, retain) ThemeCamp *camp;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
@property (nonatomic, retain) UILabel *descriptionLabel;
@property (nonatomic, retain) UIWebView *webView;

@end


