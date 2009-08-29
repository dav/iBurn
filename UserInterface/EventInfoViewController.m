//
//  EventInfoViewController.m
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-09-22.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import "EventInfoViewController.h"
#import "Event.h"
#import "ThemeCamp.h"
#import "ArtInstall.h"
#import "Favorite.h"
#import "EventTableViewController.h"
#import "iBurnAppDelegate.h"


@implementation EventInfoViewController

@synthesize event, selectedIndexPath, descriptionLabel, webView;

- (EventInfoViewController *)initWithPk: (int) eventPk {
	self = [super init];
	Event *selectedEvent = [Event findByPK:eventPk];
	self.event = selectedEvent;
	self.title = self.event.title;
	[self.tabBarItem initWithTitle:self.title image:NULL tag:NULL];
	CGRect bounds = [self.view bounds];
	tableView = [[UITableView alloc] initWithFrame:CGRectInset(bounds, 0.0f, 44.0f) style:UITableViewStylePlain];
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
    return 8;
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
			if(event.eventType != @"None"){
				return 44.0f;
			} else {
				return 0.0f;
			}
		case 5: {
			if([event.website length] > 0){
				return 44.0f;
			} else {
				return 0.0f;
			}
		}
		case 6:
			if([event.emailAddress length] > 0){
				return 44.0f;
			} else {
				return 0.0f;
			}
		case 7: {
			CGSize constraintSize;
			constraintSize.width = 260.0f;
			constraintSize.height = MAXFLOAT;
			CGSize theSize = [self.event.description sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
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
			cell = [tableView dequeueReusableCellWithIdentifier:@"eventTitleCell"];
			if(!cell) {
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"eventTitleCell"] autorelease];
			}
			cell.text = self.event.title; 
			break;
		}
		case 1: {
			cell = [tableView dequeueReusableCellWithIdentifier:@"eventStartTimeCell"];
			if(!cell) {
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"eventStartTimeCell"] autorelease];
			}
			NSDateFormatter *inputFormat = [[NSDateFormatter alloc] init];
			[inputFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
			NSDate *myDate = [inputFormat dateFromString: event.startTime];
			NSDateFormatter *outputFormat = [[NSDateFormatter alloc] init];
			[outputFormat setDateFormat:@"E MMMM d, h:mm a"];
			NSString *dateString = [outputFormat stringFromDate:myDate];			
			cell.text = dateString;
			cell.text = self.event.startTime;			
			break;
		}
		case 2: {
			cell = [tableView dequeueReusableCellWithIdentifier:@"eventEndTimeCell"];
			if(!cell) {
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"eventEndTimeCell"] autorelease];
			}
			NSDateFormatter *inputFormat = [[NSDateFormatter alloc] init];
			[inputFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
			NSDate *myDate = [inputFormat dateFromString: event.endTime];
			NSDateFormatter *outputFormat = [[NSDateFormatter alloc] init];
			[outputFormat setDateFormat:@"E MMMM d, h:mm a"];
			NSString *dateString = [outputFormat stringFromDate:myDate];			
			//cell.text = dateString;
			cell.text = self.event.endTime;
			break;
		}
        case 3: {
			cell = [tableView dequeueReusableCellWithIdentifier:@"eventTypeCell"];
			if(!cell) {
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"eventTypeCell"] autorelease];
			}
			NSLog(@"camp=%@", self.event.camp);
			NSLog(@"art=%@", self.event.art);
			if (self.event.camp) {
				NSString *criteria = [NSString stringWithFormat:@"where id=%@", self.event.camp];
				ThemeCamp *camp = [ThemeCamp findFirstByCriteria:criteria];
				if(camp) {
					//Should show Camp Icon, and link to camp
					cell.text = camp.name;
				}
				//[camp dealloc];
			} else if (self.event.art) {
				NSString *criteria = [NSString stringWithFormat:@"where id=%@", self.event.art];
				ArtInstall *art = [ArtInstall findFirstByCriteria:criteria];
				if(art) {
					//Should show Art Icon, and link to camp
					cell.text = art.name;
				}
				//[art dealloc];
			} else {
				cell.text = self.event.otherLocation; 
			}
			break;
		}
        case 4: {
			cell = [tableView dequeueReusableCellWithIdentifier:@"eventTypeCell"];
			if(!cell) {
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"eventTypeCell"] autorelease];
			}
			cell.text = self.event.eventType; 
			break;
		}
        case 5: {
			cell = [tableView dequeueReusableCellWithIdentifier:@"eventURLCell"];
			if(!cell) {
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"eventURLCell"] autorelease];
			}
			cell.text = self.event.website; 
			break;
		}
		case 6: {
			cell = [tableView dequeueReusableCellWithIdentifier:@"eventContactEmailCell"];
			if(!cell) {
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"eventContactEmailCell"] autorelease];
			}
			cell.text = self.event.emailAddress; 
			break;
		}
        case 7: {
			descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 10.0f, 280.0f, 44.0f)];
			cell = [tableView dequeueReusableCellWithIdentifier:@"descriptionCell"];
			if(!cell) {
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"descriptionCell"] autorelease];
				[cell addSubview:descriptionLabel];
			}
			descriptionLabel.text = self.event.description;
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
        case 1: return @"Start Time";			
        case 2: return @"End Time";
        case 3: return @"Location";
        case 4: return @"Type";
        case 5: return @"URL";
        case 6: return @"Contact Email";			
        case 7: return @"Description";
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger section = [indexPath section];

    switch (section) {
    }
}

- (void) addToFavorites: (id) sender
{
	NSString *criteria = [NSString stringWithFormat:@"where type='event' and object_id=%@", self.event.eventId];
	Favorite *favorite = [Favorite findFirstByCriteria:criteria];
	NSString *message = NULL;
	if(favorite) {
		message = @"Already in your Favorites";
		//Should 'release' favorite? both release and dealloc crash the app???
	} else {
		
		Favorite *favorite = [[Favorite alloc] init];
		favorite.type = @"event";
		favorite.objectId = self.event.eventId;
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
    [event release];
    [super dealloc];
}

@end