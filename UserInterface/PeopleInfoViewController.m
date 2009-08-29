//
//  PeopleInfoViewController.m
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-05-25.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import "PeopleInfoViewController.h"
#import "User.h"
#import "PeopleTableViewController.h"
#import "iBurnAppDelegate.h"


@implementation PeopleInfoViewController

@synthesize user, selectedIndexPath;

- (PeopleInfoViewController *)initWithPk: (int) userPk {
	self = [super init];
	User *selectedUser = [User findByPK:userPk];
	self.user = selectedUser;
	self.title = self.user.username;
	[self.tabBarItem initWithTitle:self.title image:NULL tag:NULL];
	CGRect bounds = [self.view bounds];
	tableView = [[UITableView alloc] initWithFrame:CGRectInset(bounds, 0.0f, 0.0f) style:UITableViewStylePlain];
	tableView.delegate = self;
	tableView.dataSource = self;
	[self.view addSubview:tableView];
	[tableView release];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)viewWillAppear:(BOOL)animated {
    // Remove any existing selection.
    [tableView deselectRowAtIndexPath:selectedIndexPath animated:NO];
    // Redisplay the data.
    [tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath {
	int section = [indexPath section];
	switch (section){
		case 0:
			return 44.0f;
		case 1:
			return 44.0f;
		case 2:
			return 44.0f;
		default:
			return 0.0f;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger section = [indexPath section];
	UITableViewCell *cell;
	
    switch (section) {
        case 0: {
			cell = [tableView dequeueReusableCellWithIdentifier:@"userNameCell"];
			if(!cell) {
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"userNameCell"] autorelease];
			}
			cell.text = self.user.username; 
			break;
		}
        case 1: {
			cell = [tableView dequeueReusableCellWithIdentifier:@"userFirstLastNameCell"];
			if(!cell) {
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"userFirstLastNameCell"] autorelease];
			}
			NSString *fullName = [NSString stringWithFormat:@"%@", self.user.name]; 
			cell.text = fullName;
			break;
		}
		case 2: {
			cell = [tableView dequeueReusableCellWithIdentifier:@"userEmailCell"];
			if(!cell) {
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"userEmailCell"] autorelease];
			}
			cell.text = self.user.emailAddress; 
			break;
		}
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tv titleForHeaderInSection:(NSInteger)section {
    // Return the displayed title for the specified section.
    switch (section) {
        case 0: return @"Userame";
        case 1: return @"Name";
        case 2: return @"Contact Email";			
    }
    return nil;
}

- (NSIndexPath *)tableView:(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Only allow selection if editing.
    return (self.editing) ? indexPath : nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
}

- (void)dealloc {
    [selectedIndexPath release];
    [tableView release];
    [user release];
    [super dealloc];
}

@end