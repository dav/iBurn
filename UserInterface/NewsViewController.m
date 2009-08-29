//
//  NewsViewController.m
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-01-11.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import "NewsViewController.h"


@implementation NewsViewController

- (id)init {
	if( self = [super init]) {
		[self.tabBarItem initWithTitle:self.title image:[UIImage imageNamed:@"news.png"] tag:NULL];
		self.title=@"News";
	}
	return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	contentView = [[UIView alloc] init];
	self.view = contentView;
	[contentView release];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[contentView release];
    [super dealloc];
}


@end
