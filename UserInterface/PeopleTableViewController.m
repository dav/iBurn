//
//  PeopleTableViewController.m
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-01-12.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import "PeopleTableViewController.h"
#import "User.h"
#import "PeopleInfoViewController.h"

@implementation PeopleTableViewController

- (id)init {
	if( self = [super init]) {
		[self.tabBarItem initWithTitle:self.title image:[UIImage imageNamed:@"people.png"] tag:NULL];
		self.title=@"People";
		if([users count] == 0) {
			[self loadUsers];
		}
	}
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	
	//cellSize = CGSizeMake([UsersTable bounds].size.width, 60);
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
	int userIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	[cell setText:[[users objectAtIndex: userIndex] objectForKey: @"userName"]];	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	int userIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	int userPk = [[[users objectAtIndex: userIndex] objectForKey:@"primaryKey"] intValue];
	PeopleInfoViewController *PeopleInfoView = [[PeopleInfoViewController alloc] initWithPk:userPk];
	[[self navigationController] pushViewController:PeopleInfoView animated:YES];
}

- (void)loadUsers {
	
	users = [[NSMutableArray alloc] init];
	NSArray *UsersArray = [[User class] allObjects];

	for(User *u in UsersArray) {
		item = [[NSMutableDictionary alloc] init];
		[item setValue:[NSNumber numberWithInt:u.pk] forKey:@"primaryKey"];
		[item setObject:u.username forKey:@"userName"];
		//[item setObject:u.name forKey:@"name"];	
		//[item setObject:u.emailAddress forKey:@"emailAddress"];		
		[users addObject:[item copy]];
	}
	//[UsersArray dealoc];
	[usersTable reloadData];
}

- (void)dealloc {
    [super dealloc];
}

@end