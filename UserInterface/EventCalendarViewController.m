//
//  EventCalendarViewController.m
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-01-18.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import "EventCalendarViewController.h"
#import "CheckmarkTile.h"
#import "EventTableViewController.h"

@interface EventCalendarViewController ()  // private methods
- (void)forwardTransitionToShowFrontOfTile:(KLTile *)tile;
- (void)backwardTransitionFromShowingFrontOfTile;
- (void)panFromCurrentTileToTile:(KLTile *)tile;
- (void)makeCurrentTile:(KLTile *)tile;
- (void)relinquishCurrentTile:(KLTile *)tile;
@end

@implementation EventCalendarViewController

@synthesize calendarView, currentTile;

- (EventCalendarViewController *)initWithTitle: (NSString *) aTitle {
	self = [super init];
	self.title = aTitle;
	[self.tabBarItem initWithTitle:self.title image:[UIImage imageNamed:@"events.png"] tag:NULL];
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Calendar";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
	[self.navigationItem setTitle:@"Playa Event Calendar"];
	NSLog(@"in loadView");
	UIView *clip = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 41.0f, 320.0f, 321.0f)] autorelease];
    clip.clipsToBounds = YES;
    clip.autoresizesSubviews = NO;	
	self.calendarView = [[[KLCalendarView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 321.0f) delegate:self] autorelease];
	[clip addSubview:self.calendarView];
    [self.view addSubview:clip];
	
    [self didChangeMonths]; // ugly hack because the calendar view does not have access to the clip view the first time it builds the calendar		
	
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

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

- (void)didChangeMonths;
{
    UIView *clip = self.calendarView.superview;
    if (!clip)
        return;
    
    CGRect f = clip.frame;
    NSInteger weeks = [self.calendarView selectedMonthNumberOfWeeks];
    CGFloat adjustment = 0.f;
    
    switch (weeks) {
        case 4:
            adjustment = 92.f;
            break;
        case 5:
            adjustment = 46.f;
            break;
        case 6:
            adjustment = 0.f;
            break;
        default:
            break;
    }
    f.size.height = 321.f - adjustment;
    clip.frame = f;
}

// --------------------------------------------------------------------------------------------
//      restoreOriginalClipSize:
// 
//      Triggered when the calendar zooms in on a tile.
//      During the zoomed in mode, it doesn't matter how many weeks are
//      in the selected month, the clip & calendar will always be
//      the same height (321 points).
//
- (void)restoreOriginalClipSize
{
    UIView *clip = [self.calendarView superview];
    CGRect f = clip.frame;
    f.size.height = 321.f;
    clip.frame = f;    
}

// --------------------------------------------------------------------------------------------
//      calendarView:createTileForDate:
// 
//      Triggered when a tile needs to be added to a calendar for display to the user.
//      This is the delegate's opportunity to instantiate their own tile 
//		and configure it according to the application's needs.
//
- (KLTile *)calendarView:(KLCalendarView *)calendarView createTileForDate:(KLDate *)date
{
	// In this demo I will be marking days with checkmarks,
	// so I instantiate my KLTile subclass here.
	CheckmarkTile *tile = [[CheckmarkTile alloc] init];
	
	// Since this is a demo, I just randomly enable the checkmark,
	// but in a real application you would use the date to lookup 
	// whether to place the checkmark or not.
	//tile.checkmarked = rand() % 5 == 0;
	
	// Yes, I am intentionally returning a non-autoreleased object here.
	// The calendar view will release it after it adds it to its view hierarchy.
	return tile;
}

// --------------------------------------------------------------------------------------------
//      calendarView:tappedTile:
// 
//      Triggered when a tile is tapped on the calendar.
//      
- (void)calendarView:(KLCalendarView *)calendarView tappedTile:(KLTile *)aTile
{
	// Cast the tile to the specific subclass that I'm using in this demo.
	// The cast is safe since this demo only creates one type of tile
	// and that is CheckmarkTile (see -[KCalendarAppDelegate calendarView:createTileWithFrame:date:])
	CheckmarkTile *tile = (CheckmarkTile *)aTile;
	
    // No matter which state we're in,
    // do not allow any taps on dates in the future
	/*
    if ([tile.date isLaterThan:[KLDate today]]) {
        [tile flash];
        return;        
    }
	 */
    
    // if we're looking at the whole month, zoom in on the tapped tile
	/*
	if ( ![self.calendarView isZoomedIn] ) {
        [self forwardTransitionToShowFrontOfTile:tile];
        return;
    }
    
    // If the zoomed tile is already checked, then remove the checkmark
    if (tile.checkmarked && tile == self.currentTile) {
        tile.checkmarked = NO;
        [self.calendarView redrawNeighborsAndTile:tile];
        return;
    }
    
    // While zoomed in, a tap on an adjacent tile will pan to that tile
    if (tile != self.currentTile) {
        [self panFromCurrentTileToTile:tile];
        return;
    }
	 */
	
    // Default case:
    //     While zoomed in, a blank tile was tapped. So we place the checkmark on the tile.
	//tile.checkmarked = YES;
	
	NSString *dateDescription = [NSString stringWithFormat:tile.date.description];
	EventTableViewController *eventsTable = [[EventTableViewController alloc] initWithTitle:dateDescription];
	
	[[self navigationController] pushViewController:eventsTable animated:YES];	
	[self.calendarView redrawNeighborsAndTile:tile];
}


// ~~~~~~~~~~~~~~~~~~~~ Calendar related logic and behavior ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


// --------------------------------------------------------------------------------------------
//      panFromCurrentTileToTile:
// 
//      If the calendar is zoomed in on the front of a tile,
//      pan over to the provided tile and update the currentTile pointer.
//      If the calendar is zoomed out, do nothing.
//      If tile is nil, do nothing.
//      If tile is later than today, do nothing.
//      
- (void)panFromCurrentTileToTile:(KLTile *)tile
{
    if (!tile)
        return; // can't pan over because there is no tile there
    
    if ([tile.date isLaterThan:[KLDate today]])
        return;
    
    if ( ![self.calendarView isZoomedIn] )
        return;
    
    KLTile *formerTile = self.currentTile;
    [self relinquishCurrentTile:formerTile];
    [self makeCurrentTile:tile];
    [self.calendarView panToTile:tile];
}

// --------------------------------------------------------------------------------------------
//		makeCurrentTile:
//
//		Common tasks needed to put the focus on a date/tile.
//		This is where you would update the contents of a view below the calendar
//		to display the details for the selected date/tile.
//
- (void)makeCurrentTile:(KLTile *)tile
{
    self.currentTile = tile;
}

// --------------------------------------------------------------------------------------------
//		relinquishCurrentTile:
//
//		Common tasks needed to give up the perks & priveledges of being the current tile
//
- (void)relinquishCurrentTile:(KLTile *)tile
{
    self.currentTile = nil;
}

- (void)forwardTransitionToShowFrontOfTile:(KLTile *)tile
{
    [self makeCurrentTile:tile];
    [self restoreOriginalClipSize];
    [self.calendarView zoomInOnTile:tile];
}

- (void)backwardTransitionFromShowingFrontOfTile
{
    KLTile *formerTile = self.currentTile;
    [self relinquishCurrentTile:formerTile];
    [self didChangeMonths];  // adjust clip view height to only show weeks in calendar month
    //[self.calendarView zoomOutFromTile:formerTile];
}

@end
