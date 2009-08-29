//
//  CampTableViewController.m
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-01-12.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import "CampTableViewController.h"
#import "ThemeCamp.h"
#import "CampInfoViewController.h"
#import "CampTableCell.h"


@implementation CampTableViewController

@synthesize mapDelegate;

- (id)init {
	if( self = [super init]) {
		[self.tabBarItem initWithTitle:self.title image:[UIImage imageNamed:@"camps.png"] tag:NULL];
		self.title=@"Camps";
		[self.navigationItem setTitle:@"Theme Camps"];
		UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
		temporaryBarButtonItem.title = @"Camps";
		self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
		[temporaryBarButtonItem release];
		/*
		searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0,320,44)];
		searchBar.delegate = self;
		searchBar.barStyle = UIBarStyleBlackTranslucent;
		searchBar.placeholder = @"search theme camps";
		UITextField *searchField = [[searchBar subviews] lastObject];
		[searchField setReturnKeyType:UIReturnKeyDone];
		self.tableView.tableHeaderView = searchBar;
		[searchBar release];
		 */
		
		if([camps count] == 0) {
			[self loadCamps];
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
	
	//cellSize = CGSizeMake([campsTable bounds].size.width, 60);
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

- (void)searchBarSearchButtonClicked:(UISearchBar *) searchBar {
	[searchBar resignFirstResponder];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [camps count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"Cell";
    CampTableCell *cell = (CampTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[CampTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		cell.delegate = self.mapDelegate;
    }
	else {
		cell.mNeedsLayout = YES;
		[cell setNeedsDisplay];
	}
    
	int campIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	
	[cell setCampInfo: [camps objectAtIndex: campIndex]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	int campIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	int campPk = [[[camps objectAtIndex: campIndex] objectForKey:@"primaryKey"] intValue];
	CampInfoViewController *campInfoView = [[CampInfoViewController alloc] initWithPk:campPk];
	[[self navigationController] pushViewController:campInfoView animated:YES];
}

- (void)loadCamps {
	camps = [[NSMutableArray alloc] init];
	NSArray *campsArray = [[ThemeCamp class] allObjects];
	for(ThemeCamp *tc in campsArray) {
		item = [[NSMutableDictionary alloc] init];
		[item setValue:[NSNumber numberWithInt:tc.pk] forKey:@"primaryKey"];
		[item setObject:tc.name forKey:@"name"];
		if(tc.location != NULL) {
			[item setObject:tc.location forKey:@"location"];
		} else {
			[item setObject:@"" forKey:@"location"];
		}
		if(tc.latitude != NULL) {
			[item setObject:tc.latitude forKey:@"latitude"];
			[item setObject:tc.longitude forKey:@"longitude"];
		}
		[camps addObject:[item copy]];
	}
	//[campsArray dealoc];
	[campsTable reloadData];
}

- (void)dealloc {
    [super dealloc];
}

@end