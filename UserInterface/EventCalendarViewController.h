//
//  EventCalendarViewController.h
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-01-18.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLCalendarView.h"

@interface EventCalendarViewController : UIViewController <KLCalendarViewDelegate> {
	KLCalendarView *calendarView;
	KLTile *currentTile;
}

@property (nonatomic, retain) KLCalendarView *calendarView;
@property (nonatomic, retain) KLTile *currentTile;

- (void)forwardTransitionToShowFrontOfTile:(KLTile *)tile;
- (void)backwardTransitionFromShowingFrontOfTile;
- (void)panFromCurrentTileToTile:(KLTile *)tile;
- (void)makeCurrentTile:(KLTile *)tile;
- (void)relinquishCurrentTile:(KLTile *)tile;

@end
