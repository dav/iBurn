//
//  ArtInfoViewController.m
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-01-18.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import "ArtInfoViewController.h"
#import "ArtInstall.h"
#import "Favorite.h"

#import "ArtTableViewController.h"
#import "iBurnAppDelegate.h"


@implementation ArtInfoViewController

@synthesize art, selectedIndexPath, descriptionLabel;

- (ArtInfoViewController *)initWithPk: (int) artPk {
	self = [super init];
	ArtInstall *selectedArt = [ArtInstall findByPK:artPk];
	self.art = selectedArt;
	self.title = self.art.name;
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
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
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
    return 4;
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
		case 3: {
			CGSize constraintSize;
			constraintSize.width = 260.0f;
			constraintSize.height = MAXFLOAT;
			CGSize theSize = [self.art.description sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
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
			cell = [tableView dequeueReusableCellWithIdentifier:@"artNameCell"];
			if(!cell) {
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"artNameCell"] autorelease];
			}
			cell.text = self.art.name; 
			break;
		}
		case 1: {
			cell = [tableView dequeueReusableCellWithIdentifier:@"artArtistCell"];
			if(!cell) {
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"artArtistCell"] autorelease];
			}
			cell.text = self.art.artist; 
			break;
		}
        case 2: {
			cell = [tableView dequeueReusableCellWithIdentifier:@"artURLCell"];
			if(!cell) {
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"artURLCell"] autorelease];
			}
			cell.text = self.art.url; 
			break;
		}
        case 3: {
			descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 10.0f, 280.0f, 44.0f)];
			cell = [tableView dequeueReusableCellWithIdentifier:@"descriptionCell"];
			if(!cell) {
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"descriptionCell"] autorelease];
				[cell addSubview:descriptionLabel];
				
			}			
			descriptionLabel.text = self.art.description;
			descriptionLabel.textAlignment = UITextAlignmentLeft;
			descriptionLabel.adjustsFontSizeToFitWidth = true;
			descriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
			descriptionLabel.numberOfLines = 0;
			[descriptionLabel sizeToFit];
			break;
		}
		/*
		case 4: {
			cell = [tableView dequeueReusableCellWithIdentifier:@"artImageCell"];
			if(!cell) {
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"artImageCell"] autorelease];
			}
			NSURL *url = [NSURL URLWithString:@"http://1.bp.blogspot.com/_f8Gs7G4iHlU/SlyWhKeaVlI/AAAAAAAAACo/e6yHUogz3T4/s1600/Gnomeface.preview.jpg"];
			NSData *data = [NSData dataWithContentsOfURL:url];
			UIImage *img = [[UIImage alloc] initWithData:data cache:NO];
			cell.image = img;
			break;
		}
		*/
			
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tv titleForHeaderInSection:(NSInteger)section {
    // Return the displayed title for the specified section.
    switch (section) {
        case 0: return @"Name";
        case 1: return @"Artist";			
        case 2: return @"URL";
        case 3: return @"Description";
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger section = [indexPath section];
    switch (section) {
        case 2: {
			if(self.art.url) {
				/*
				UIView *webViewContainer = [UIView alloc];
				UIWebView *webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
				NSURL *url = [NSURL URLWithString:self.art.url];
				NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
				[webView loadRequest:requestObj];
				[webViewContainer addSubview:webView];
				[self.view addSubview:webView];
				//[[self navigationController] pushViewController:webViewContainer];
				 */
			}
		}
    }
	
}

- (void) addToFavorites: (id) sender
{
	NSString *criteria = [NSString stringWithFormat:@"where type='art' and object_id=%@", self.art.id];
	Favorite *favorite = [Favorite findFirstByCriteria:criteria];
	NSString *message = NULL;
	if(favorite) {
		message = @"Already in your Favorites";
		//Should 'release' favorite? both release and dealloc crash the app???
	} else {
		Favorite *favorite = [[Favorite alloc] init];
		favorite.type = @"art";
		favorite.objectId = self.art.id;
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
    [art release];
    [super dealloc];
}

@end