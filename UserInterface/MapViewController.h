//
//  MapViewController.h
//  iBurn
//
//  Created by Jeffrey Johnson on 2008-12-25.
//  Copyright Burning Man Earth 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMMapView.h"
#import "MyCLController.h"
#import "CampTableCell.h"

@interface MapViewController : UIViewController <RMMapViewDelegate, MyCLControllerDelegate, CellMapLinkDelegate> {
	IBOutlet RMMapView * mapView;
	BOOL tap;
	NSInteger tapCount;
	BOOL isCurrentlyUpdating;
	BOOL firstUpdate;		
	UIBarButtonItem *locationButton;
	RMMarkerManager *markerManager;
	RMMarker *currentLocationMarker;
}

@property (nonatomic, retain) RMMapView * mapView;
@end

