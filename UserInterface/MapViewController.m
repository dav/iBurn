//
//  MapViewController.m
//  iBurn
//
//  Created by Jeffrey Johnson on 2008-12-25.
//  Copyright Burning Man Earth 2008. All rights reserved.
//

#import "MapViewController.h"

#import "RMMapContents.h"
#import "RMFoundation.h"
#import "RMMarker.h"
#import "RMMarkerManager.h"
#import "RMTileLoader.h"
#import "RMOpenStreetMapsSource.h"
#import "RMTileImageSet.h"
#import "CampTableCell.h"

@implementation MapViewController

@synthesize mapView;

- (MapViewController *)initWithTitle: (NSString *) aTitle {
	self = [super init];
	self.title = aTitle;
	[self.tabBarItem initWithTitle:self.title image:[UIImage imageNamed:@"map.png"] tag:NULL];
	locationButton = [[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"position.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(startLocation:)] autorelease];
	[self.navigationItem setTitle:@"Black Rock City Map"];
	self.navigationItem.rightBarButtonItem = locationButton;
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]
											   initWithImage:[UIImage imageNamed:@"home_nav_button.png"]
											   style:UIBarButtonItemStylePlain
											   target:self
											   action:@selector(home:)] autorelease];
    return self;
}

- (void) startLocation: (id) sender
{
	if ( ! [MyCLController sharedInstance].locationManager.locationServicesEnabled ) {
        locationButton.enabled = NO;
    }
	else {
		NSString *msg;
		if(isCurrentlyUpdating) {
			[[MyCLController sharedInstance].locationManager stopUpdatingLocation];
			isCurrentlyUpdating = NO;
			msg = @"Updating Stopped";
		} else {
			[[MyCLController sharedInstance].locationManager startUpdatingLocation];
			isCurrentlyUpdating = YES;
			msg = @"Updating Started";
		}
		UIAlertView *locationStatus = [[UIAlertView alloc]
									   initWithTitle:@"Location Tracking"
									   message:msg
									   delegate:self 
									   cancelButtonTitle:nil
									   otherButtonTitles:@"OK", nil];
		[locationStatus show];
		[locationStatus release];
	}
}	

- (void) home: (id) sender
{
	CLLocationCoordinate2D point;
	point.latitude = 40.769288; //Center of 2009 City
	point.longitude = -119.220037;
	[mapView moveToLatLong:point];
	RMMapContents *contents = [mapView contents];
	[contents setZoom:13.0];
	
	/*
	//Temporarily here
	id<RMTileSource> tileSource;
	tileSource = [contents tileSource];
	[tileSource removeAllCachedImages];
	
	RMTileLoader *loader = [contents tileLoader];
	[loader reload];
	
	RMTileRect newTileRect = [contents tileBounds];
	RMTileImageSet *images = [contents imagesOnScreen];
	CGRect newLoadedBounds = [images addTiles:newTileRect ToDisplayIn:[contents screenBounds]];
	
	RMMercatorToScreenProjection *mercatorToScreenProjection;
	*/
}	

 - (void)loadView {
	 [self setMapView:[[[RMMapView alloc]initWithFrame:CGRectMake(0.0, 0.0, 320, 480)]autorelease]];
	 [mapView setBackgroundColor:[UIColor blackColor]];
	 self.view = mapView;
 }

- (void)viewDidLoad {
    [super viewDidLoad];
	tap=NO;
	[mapView setDelegate:self];
	[MyCLController sharedInstance].delegate = self;

    if ( ! [MyCLController sharedInstance].locationManager.locationServicesEnabled ) {
        locationButton.enabled = NO;
    }
	
	CLLocationCoordinate2D point;
	point.latitude = 40.775; // Offset slightly south from 2009 city location so that map is center
	point.longitude = -119.220037;
		
	markerManager = [mapView markerManager];	

	[mapView setBackgroundColor:[UIColor blackColor]];
	[mapView moveToLatLong:point];	
}

-(void)newLocationUpdate:(CLLocation *)newLocation {
	CLLocationCoordinate2D aPoint;
	if (signbit(newLocation.horizontalAccuracy)) {
		
	}else {
		aPoint.latitude = newLocation.coordinate.latitude;
		aPoint.longitude = newLocation.coordinate.longitude;
		[markerManager removeMarker:currentLocationMarker];
		currentLocationMarker = [[RMMarker alloc]initWithUIImage:[UIImage imageNamed:@"blue_dot.gif"]];
		[markerManager addMarker:currentLocationMarker AtLatLong:aPoint];
		[currentLocationMarker release];
		NSLog(@"MoveTo: Lat: %lf Lon: %lf %lf", aPoint.latitude, aPoint.longitude, newLocation.horizontalAccuracy);
		//Write This to Track Log Table
		[mapView moveToLatLong:aPoint];
	}
}

-(void)newError:(NSString *)text {
	[self addTextToLog:text];
	UIAlertView *errorAlert = [[UIAlertView alloc]
								   initWithTitle:@"Location Delegate Error"
								   message:text
								   delegate:self 
								   cancelButtonTitle:nil
								   otherButtonTitles:@"OK", nil];
	[errorAlert show];
	[errorAlert release];
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

-(void)zoomMapToLocation:(double)latitude: (double) longitude {
	CLLocationCoordinate2D point;
	point.latitude = latitude;
	point.longitude = longitude;
	[mapView moveToLatLong:point];
	RMMapContents *contents = [mapView contents];
	[contents setZoom:18.0];
	self.tabBarController.selectedIndex = 0;
}

- (void)dealloc {
	[mapView release];
    [super dealloc];
}
@end