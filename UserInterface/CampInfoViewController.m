//
//  CampInfoViewController.m
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-01-18.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import "CampInfoViewController.h"
#import "ThemeCamp.h"
#import "CampTableViewController.h"
#import "Favorite.h"
#import "iBurnAppDelegate.h"


@implementation CampInfoViewController

@synthesize camp, selectedIndexPath, descriptionLabel, webView;

- (CampInfoViewController *)initWithPk: (int) campPk {
	self = [super init];
	ThemeCamp *selectedCamp = [ThemeCamp findByPK:campPk];
	self.camp = selectedCamp;
	self.title = self.camp.name;
	[self.tabBarItem initWithTitle:self.title image:NULL tag:NULL];
	CGRect bounds = [self.view bounds];
	tableView = [[UITableView alloc] initWithFrame:CGRectInset(bounds, 0.0f,44.0f) style:UITableViewStylePlain];
	tableView.delegate = self;
	tableView.dataSource = self;
	[self.view addSubview:tableView];
	[tableView release];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
											   initWithImage:[UIImage imageNamed:@"empty_star.png"]
											   style:UIBarButtonItemStylePlain
											   target:self
											   action:@selector(addToFavorites:)] autorelease];	
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
    return 6;
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
		case 3:
			return 44.0f;
		case 4:
			return 44.0f;
		case 5: {
			CGSize constraintSize;
			constraintSize.width = 260.0f;
			constraintSize.height = MAXFLOAT;
			CGSize theSize = [self.camp.description sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
			return theSize.height+10;
		}
		default:
			return 0.0f;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger section = [indexPath section];
	UITableViewCell *cell;
	
    switch (section) {
        case 0: {
			cell = [tableView dequeueReusableCellWithIdentifier:@"campNameCell"];
			if(!cell) {
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"campNameCell"] autorelease];
			}
			cell.textLabel.text = self.camp.name; 
			break;
		}
        case 1: {
			cell = [tableView dequeueReusableCellWithIdentifier:@"campURLCell"];
			if(!cell) {
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"campURLCell"] autorelease];
			}
			cell.textLabel.text = self.camp.url; 
			break;
		}
		case 2: {
			cell = [tableView dequeueReusableCellWithIdentifier:@"campContactEmailCell"];
			if(!cell) {
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"campContactEmailCell"] autorelease];
			}
			cell.textLabel.text = self.camp.contactEmail; 
			break;
		}
		case 3: {
			cell = [tableView dequeueReusableCellWithIdentifier:@"campHometownCell"];
			if(!cell) {
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"campHometownCell"] autorelease];
			}
			cell.textLabel.text = self.camp.hometown; 
			break;
		}
		case 4: {
			cell = [tableView dequeueReusableCellWithIdentifier:@"campLocationCell"];
			if(!cell) {
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"campLocationCell"] autorelease];
			}
			cell.textLabel.text = self.camp.location; 
			break;
		}
        case 5: {
			descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 10.0f, 280.0f, 44.0f)];
			cell = [tableView dequeueReusableCellWithIdentifier:@"descriptionCell"];
			if(!cell) {
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"descriptionCell"] autorelease];
				[cell addSubview:descriptionLabel];
			}
			descriptionLabel.text = self.camp.description;
			descriptionLabel.textAlignment = UITextAlignmentLeft;
			descriptionLabel.adjustsFontSizeToFitWidth = true;
			descriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
			descriptionLabel.numberOfLines = 0;
			[descriptionLabel sizeToFit];
			break;
		}
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tv titleForHeaderInSection:(NSInteger)section {
    // Return the displayed title for the specified section.
    switch (section) {
        case 0: return @"Name";
        case 1: return @"URL";
        case 2: return @"Contact Email";			
        case 3: return @"Hometown";			
        case 4: return @"Location";			
        case 5: return @"Description";
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger section = [indexPath section];
    switch (section) {
        case 1: {
			if(camp.url) {
				/*
				NSURL *url = [NSURL URLWithString:camp.url];
				NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
				[webView loadRequest:requestObj];
				self.view = webView;
				 */
			}
		}
    }
}

- (void) addToFavorites: (id) sender
{
	NSString *criteria = [NSString stringWithFormat:@"where type='camp' and object_id=%@", self.camp.id];
	Favorite *favorite = [Favorite findFirstByCriteria:criteria];
	NSString *message = NULL;
	if(favorite) {
		message = @"Already in your Favorites";
		//Should 'release' favorite? both release and dealloc crash the app???
	} else {
		
		Favorite *favorite = [[Favorite alloc] init];
		favorite.type = @"camp";
		favorite.objectId = self.camp.id;
		NSDate *today = [NSDate date];
		favorite.dateSaved = today;
		[favorite save];
		message = @"Saved!";
		[favorite release];
	}
	UIAlertView *addToFavoritesMsg = [[UIAlertView alloc]
						   initWithTitle:@"Add To Favorites"
						   message:message
						   delegate:self 
						   cancelButtonTitle:nil
						   otherButtonTitles:@"OK", nil];
	[addToFavoritesMsg show];
	[addToFavoritesMsg release];
	[message release];
}	

- (void)dealloc {
    [selectedIndexPath release];
    [tableView release];
    [camp release];
    [super dealloc];
}


@end