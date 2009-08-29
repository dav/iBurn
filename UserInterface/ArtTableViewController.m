//
//  ArtTableViewController.m
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-01-24.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import "ArtTableViewController.h"
#import "ArtInstall.h"
#import "ArtInfoViewController.h"
#import "ArtTableCell.h"


@implementation ArtTableViewController

@synthesize mapDelegate;

- (id)init {
	if( self = [super init]) {
		[self.tabBarItem initWithTitle:self.title image:[UIImage imageNamed:@"art2.png"] tag:NULL];
		self.title=@"Art";
		[self.navigationItem setTitle:@"Art Installations"];
		searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0,320,44)];
		searchBar.delegate = self;
		UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
		temporaryBarButtonItem.title = @"Art";
		self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
		[temporaryBarButtonItem release];
		/*
		searchBar.barStyle = UIBarStyleBlackTranslucent;
		searchBar.placeholder = @"search art installations";
		UITextField *searchField = [[searchBar subviews] lastObject];
		[searchField setReturnKeyType:UIReturnKeyDone];
		self.tableView.tableHeaderView = searchBar;
		[searchBar release];
		 */
		if([art count] == 0) {
			[self loadArt];
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
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *) searchBar {
	[searchBar resignFirstResponder];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [art count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"Cell";
    ArtTableCell *cell = (ArtTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ArtTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		cell.delegate = self.mapDelegate;
    }
	else {
		cell.mNeedsLayout = YES;
		[cell setNeedsDisplay];
	}
    
	int artIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	
	[cell setArtInfo: [art objectAtIndex: artIndex]];
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	int artIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	int artPk = [[[art objectAtIndex: artIndex] objectForKey:@"primaryKey"] intValue];
	ArtInfoViewController *artInfoView = [[ArtInfoViewController alloc] initWithPk:artPk];
	[[self navigationController] pushViewController:artInfoView animated:YES];
}

- (void)loadArt {
	art = [[NSMutableArray alloc] init];
	NSArray *artArray = [[ArtInstall class] allObjects];
	for(ArtInstall *ai in artArray) {
		item = [[NSMutableDictionary alloc] init];
		[item setValue:[NSNumber numberWithInt:ai.pk] forKey:@"primaryKey"];
		[item setObject:ai.name forKey:@"name"];
		if(ai.artist != NULL) {
			NSString* artistString = [NSString stringWithFormat:@"by %@", ai.artist];
			[item setObject:artistString forKey:@"artist"];
		} else {
			[item setObject:@"" forKey:@"artist"];
		}
		if(ai.latitude != NULL) {
			[item setObject:ai.latitude forKey:@"latitude"];
			[item setObject:ai.longitude forKey:@"longitude"];
		}		
		[art addObject:[item copy]];
	}
	//[artArray dealoc];
	[artTable reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
    [super dealloc];
}


@end

