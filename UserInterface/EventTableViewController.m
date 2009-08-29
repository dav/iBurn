//
//  EventTableViewController.m
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-08-22.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import "EventTableViewController.h"
#import "Event.h"
#import "EventInfoViewController.h"
#import "EventTableCell.h"

@implementation EventTableViewController

@synthesize dateString;

- (id)initWithTitle: (NSString *) aTitle {
	if( self = [super init]) {
		NSString *title = [NSString stringWithFormat:@"Events %@", aTitle];
		dateString = aTitle;
		self.title=title;
		UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
		temporaryBarButtonItem.title = aTitle;
		self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
		[temporaryBarButtonItem release];
		
		if([events count] == 0) {
			[self loadEvents];
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
	return [events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
    EventTableCell *cell = (EventTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[EventTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
	else {
		cell.mNeedsLayout = YES;
		[cell setNeedsDisplay];
	}
    
	int eventIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	
	[cell setEventInfo: [events objectAtIndex: eventIndex]];
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	int eventIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	int eventPk = [[[events objectAtIndex: eventIndex] objectForKey:@"primaryKey"] intValue];
	EventInfoViewController *eventInfoView = [[EventInfoViewController alloc] initWithPk:eventPk];
	[[self navigationController] pushViewController:eventInfoView animated:YES];
}

- (void)loadEvents {
	events = [[NSMutableArray alloc] init];
	//This should also check for events that started the previous day and end today ... i.e. span midnight
	NSString *criteria = [NSString stringWithFormat:@"where (start_time >= '%@ 00:00:00' and end_time <= '%@ 23:59:00') or (start_time < '%a 00:00:00' and end_time > '%a 00:00:00') order by start_time" , self.dateString, self.dateString, self.dateString, self.dateString];
	NSLog(@"criteria = %@", criteria);
	NSArray *eventsArray = [[Event class] findByCriteria:criteria];

	for(Event *e in eventsArray) {
		item = [[NSMutableDictionary alloc] init];
		[item setValue:[NSNumber numberWithInt:e.pk] forKey:@"primaryKey"];
		[item setObject:e.title forKey:@"title"];
		if(e.startTime != NULL & e.endTime != NULL) {
			NSDateFormatter *inputFormat = [[NSDateFormatter alloc] init];
			[inputFormat setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
			NSDate *startTime = [inputFormat dateFromString:e.startTime];
			NSDate *endTime = [inputFormat dateFromString:e.endTime];
			NSDateFormatter *outputFormat = [[NSDateFormatter alloc] init];
			[outputFormat setDateFormat: @"h:mm a"];
			NSString *startTimeString = [outputFormat stringFromDate:startTime];
			NSString *endTimeString = [outputFormat stringFromDate:endTime];
			NSString *time = [NSString stringWithFormat:@"%@ to %@", startTimeString, endTimeString];
			[item setObject:time forKey:@"time"];
		} else {
			[item setObject:@"" forKey:@"time"];
		}
		[events addObject:[item copy]];
	}
	[eventsTable reloadData];
}

- (void)dealloc {
	[dateString dealloc];
    [super dealloc];
}

@end