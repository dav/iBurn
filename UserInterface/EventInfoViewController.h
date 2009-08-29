//
//  EventInfoViewController.h
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-08-22.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Event;

@interface EventInfoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    Event *event;
	UITableView *tableView;
	CGSize cellSize;
    NSIndexPath *selectedIndexPath;
	UILabel *descriptionLabel;
	UIWebView *webView;
}

@property (nonatomic, retain) Event *event;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
@property (nonatomic, retain) UILabel *descriptionLabel;
@property (nonatomic, retain) UIWebView *webView;

@end


