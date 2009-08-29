//
//  FavoritesTableViewController.m
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-01-25.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import "FavoritesTableViewController.h"
#import "Favorite.h"
#import "ThemeCamp.h"
#import "ArtInstall.h"
#import "Event.h"
#import "CampInfoViewController.h"
#import "ArtInfoViewController.h"
#import "EventInfoViewController.h"

@implementation FavoritesTableViewController

- (id)init {
	if( self = [super init]) {
		[self.tabBarItem initWithTitle:self.title image:[UIImage imageNamed:@"favorites.png"] tag:NULL];
		if([favorites count] == 0) {
			[self loadFavorites];
		}		
		self.title=@"Favorites";
	}
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
	//Not sure if this is the best place to do this?
	[self loadFavorites];
	[self performSelector:(@selector(refreshDisplay:)) withObject:(favoritesTable) afterDelay:1];
	[favoritesTable setNeedsDisplay]; // repaint
	[favoritesTable setNeedsLayout]; // re-layout	
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[self loadFavorites];
	[self performSelector:(@selector(refreshDisplay:)) withObject:(favoritesTable) afterDelay:1];
	[favoritesTable setNeedsDisplay]; // repaint
	[favoritesTable setNeedsLayout]; // re-layout	
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; 
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [favorites count];
}

- (void)refreshDisplay:(UITableView *)tableView {
   	[favoritesTable reloadData]; 
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
	int favoritesIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	[cell setText:[[favorites objectAtIndex: favoritesIndex] objectForKey: @"name"]];	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	int favoriteIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	NSObject *objectId = [[favorites objectAtIndex: favoriteIndex] objectForKey:@"objectId"];
	NSObject *objectType = [[favorites objectAtIndex: favoriteIndex] objectForKey:@"type"];
	if([objectType isEqualToString:@"camp"]) {
		//should be using some kind of initWithId method on ViewController
		NSString *criteria = [NSString stringWithFormat:@"where id=%@", objectId];
		ThemeCamp *camp = [ThemeCamp findFirstByCriteria:criteria];
		if(camp) {
			CampInfoViewController *campInfoView = [[CampInfoViewController alloc] initWithPk:camp.pk];
			[[self navigationController] pushViewController:campInfoView animated:YES];
		} else {
		}
	} else if([objectType isEqualToString:@"art"]) {
		//should be using some kind of initWithId method on ViewController
		NSString *criteria = [NSString stringWithFormat:@"where id=%@", objectId];
		ArtInstall *art = [ArtInstall findFirstByCriteria:criteria];
		if(art) {
			ArtInfoViewController *artInfoView = [[ArtInfoViewController alloc] initWithPk:art.pk];
			[[self navigationController] pushViewController:artInfoView animated:YES];
		} else {
		}
	} else if([objectType isEqualToString:@"event"]) {
		//should be using some kind of initWithId method on ViewController
		NSString *criteria = [NSString stringWithFormat:@"where event_id=%@", objectId];
		Event *event = [Event findFirstByCriteria:criteria];
		if(event) {
			EventInfoViewController *eventInfoView = [[EventInfoViewController alloc] initWithPk:event.pk];
			[[self navigationController] pushViewController:eventInfoView animated:YES];
		} else {
		}
	} else {
	}	
}

- (void)loadFavorites {
	favorites = NULL;
	favorites= [[NSMutableArray alloc] init];
	NSString *criteria = [NSString stringWithFormat:@"order by date_saved desc"];
	NSArray *favoritesArray = [[Favorite class] findByCriteria:criteria];
	
	for(Favorite *f in favoritesArray) {
		item = [[NSMutableDictionary alloc] init];
		[item setValue:[NSNumber numberWithInt:f.pk] forKey:@"primaryKey"];
		[item setObject:f.type forKey:@"type"];
		[item setObject:f.objectId forKey:@"objectId"];
		if([f.type isEqualToString:@"camp"]) {
			NSString *criteria = [NSString stringWithFormat:@"where id=%@", f.objectId];
			ThemeCamp *camp = [ThemeCamp findFirstByCriteria:criteria];
			if(camp) {
				//Should show Camp Icon, and link to camp
				[item setObject:camp.name forKey:@"name"];
			} else {
				[item setObject:@"?" forKey:@"name"];
			}
		} else if([f.type isEqualToString:@"art"]) {
			NSString *criteria = [NSString stringWithFormat:@"where id=%@", f.objectId];
			ArtInstall *art = [ArtInstall findFirstByCriteria:criteria];
			if(art) {
				//Should show Art Icon
				[item setObject:art.name forKey:@"name"];
			} else {
				[item setObject:@"?" forKey:@"name"];
			}
		} else if([f.type isEqualToString:@"event"]) {
			NSString *criteria = [NSString stringWithFormat:@"where event_id=%@", f.objectId];
			Event *event = [Event findFirstByCriteria:criteria];
			if(event) {
				//Should show Event Icon
				[item setObject:event.title forKey:@"name"];
			} else {
				[item setObject:@"?" forKey:@"name"];
			}
		} else {
			[item setObject:@"?" forKey:@"name"];
		}

		[favorites addObject:[item copy]];
	}
	//[favoritesArray dealoc];
	[favoritesTable reloadData];
	[favoritesTable setNeedsDisplay]; // repaint
	[favoritesTable setNeedsLayout]; // re-layout	
}


- (void)dealloc {
    [super dealloc];
}


@end

