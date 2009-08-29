//
//  SettingsTableViewController.m
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-01-25.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import "SyncViewController.h"


@implementation SyncViewController

@synthesize mapSwitch;

- (id)init {	
	if( self = [super init]) {
		[self.tabBarItem initWithTitle:self.title image:[UIImage imageNamed:@"sync.png"] tag:NULL];
		self.title=@"Sync";
		[self.navigationItem setTitle:@"Sync with Web"];
		
	}
    return self;
}

- (void)viewDidLoad {
 [super viewDidLoad];
 }

/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
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

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void) switchEm: (UIControl *) sender
{
	
}

- (void) doSync: (UIControl *) sender
{
	UIAlertView *doSync = [[UIAlertView alloc]
								   initWithTitle:@"Syncing"
								   message:@"Not Yet Implemented"
								   delegate:self 
								   cancelButtonTitle:nil
								   otherButtonTitles:@"OK", nil];
	[doSync show];
	[doSync release];	
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSInteger section = [indexPath section];
	UITableViewCell *cell;
	
    switch (section) {
        case 0: {
			cell = [tableView dequeueReusableCellWithIdentifier:@"mapSwitchCell"];
			UISwitch *switchView = NULL;
			if(!cell) {
				switchView = [[UISwitch alloc] initWithFrame: CGRectMake(4.0f, 16.0f, 100.0f, 28.0f)];
				[switchView setTag:999];
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"mapSwitchCell"] autorelease];
				cell.selectionStyle = UITableViewCellSelectionStyleGray;
				[switchView addTarget:self action:@selector(switchEm:) forControlEvents:UIControlEventValueChanged];
				switchView.on = TRUE;
				[cell setText:@"Sync Map"];
				cell.accessoryView = switchView;
			}
			break;
		}
        case 1: {
			cell = [tableView dequeueReusableCellWithIdentifier:@"campSwitchCell"];
			UISwitch *switchView = NULL;
			if(!cell) {
				switchView = [[UISwitch alloc] initWithFrame: CGRectMake(4.0f, 16.0f, 100.0f, 28.0f)];
				[switchView setTag:998];
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"campSwitchCell"] autorelease];
				cell.selectionStyle = UITableViewCellSelectionStyleGray;
				[switchView addTarget:self action:@selector(switchEm:) forControlEvents:UIControlEventValueChanged];
				switchView.on = TRUE;
				[cell setText:@"Sync Camps"];
				cell.accessoryView = switchView;
			}
			break;
		}
        case 2: {
			cell = [tableView dequeueReusableCellWithIdentifier:@"artSwitchCell"];
			UISwitch *switchView = NULL;
			if(!cell) {
				switchView = [[UISwitch alloc] initWithFrame: CGRectMake(4.0f, 16.0f, 100.0f, 28.0f)];
				[switchView setTag:997];
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"artSwitchCell"] autorelease];
				cell.selectionStyle = UITableViewCellSelectionStyleGray;
				[switchView addTarget:self action:@selector(switchEm:) forControlEvents:UIControlEventValueChanged];
				[cell setText:@"Sync Art Installs"];
				switchView.on = TRUE;
				cell.accessoryView = switchView;
			}
			break;
		}
        case 3: {
			cell = [tableView dequeueReusableCellWithIdentifier:@"eventsSwitchCell"];
			UISwitch *switchView = NULL;
			if(!cell) {
				switchView = [[UISwitch alloc] initWithFrame: CGRectMake(4.0f, 16.0f, 100.0f, 28.0f)];
				[switchView setTag:996];
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"eventsSwitchCell"] autorelease];
				cell.selectionStyle = UITableViewCellSelectionStyleGray;
				[switchView addTarget:self action:@selector(switchEm:) forControlEvents:UIControlEventValueChanged];
				[cell setText:@"Sync Events"];
				switchView.on = TRUE;
				cell.accessoryView = switchView;
			}
			break;
		}
        case 4: {
			cell = [tableView dequeueReusableCellWithIdentifier:@"tweetsSwitchCell"];
			UISwitch *switchView = NULL;
			if(!cell) {
				switchView = [[UISwitch alloc] initWithFrame: CGRectMake(4.0f, 16.0f, 100.0f, 28.0f)];
				[switchView setTag:999];
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"tweetsSwitchCell"] autorelease];
				cell.selectionStyle = UITableViewCellSelectionStyleGray;
				[switchView addTarget:self action:@selector(switchEm:) forControlEvents:UIControlEventValueChanged];
				[cell setText:@"Sync Tweets"];
				switchView.on = TRUE;
				cell.accessoryView = switchView;
			}
			break;
		}
        case 5: {
			cell = [tableView dequeueReusableCellWithIdentifier:@"syncButtonCell"];
			UIButton *syncButton = NULL;
			if(!cell) {
				syncButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
				syncButton.frame = CGRectMake(20.0f, 20.0f, 200.0f, 44.0f); // position in the parent view and set the size of the button
				[syncButton setTitle:@"Sync!" forState:UIControlStateNormal];
				[syncButton addTarget:self action:@selector(doSync:) forControlEvents:UIControlEventTouchUpInside];

				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"tweetsSwitchCell"] autorelease];
				cell.selectionStyle = UITableViewCellSelectionStyleGray;
				cell.accessoryView = syncButton;
			}
			break;
		}
			
	}
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
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

