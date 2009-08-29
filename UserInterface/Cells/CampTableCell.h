//
//  CampTableCell.h
//  iBurn
//
//  Created by Chuck Toussieng on 8/25/09.
//  Copyright 2009. All rights reserved.
//

@protocol CellMapLinkDelegate <NSObject>
@optional
-(void)zoomMapToLocation:(double)latitude: (double) longitude;
@end

#import <Foundation/Foundation.h>

//--Name Info UI layout values
#define CELL_ORIGIN_X	0.0
#define CELL_ORIGIN_Y	0.0
#define HORIZONTAL_GAP	4.0
#define VERTICAL_GAP	1.0

#define NAME_STATUS_PERCENTAGE		0.17
#define NAME_INFO_PERCENTAGE		0.63
#define VIEW_MAP_PERCENTAGE			0.28

#define NAME_TITLE_FIELD_HEIGHT		22.0
#define NAME_DESC_FIELD_HEIGHT		14.0
#define VIEW_MAP_BUTTON_HEIGHT		37.0
#define VIEW_MAP_BUTTON_WIDTH		37.0
#define NAME_STATUS_VIEW_HEIGHT		50.0
#define NO_NAME_TEXT_HEIGHT			37.0
//--End Name Info UI layout values

@class ThemeCamp;

@interface CampTableCell : UITableViewCell {
	UILabel			*mNameTitleField;
	UILabel			*mNameDescriptionField;
	UIButton		*mViewMapButton;
	UIImageView		*mNameStatusView;
	NSNumber			*latitude;
	NSNumber			*longitude;
	
	ThemeCamp		*tc;
	
	BOOL			mNeedsLayout;

	UILabel			*mNoNameText;
	id<CellMapLinkDelegate> delegate;	
}

@property(readwrite) BOOL mNeedsLayout;
@property (nonatomic, retain, readwrite) id<CellMapLinkDelegate> delegate;

- (void) layOutViews;
- (void) viewMap:(id)inSender;
- (void) setCampInfo: (ThemeCamp *) inCamp;
- (void) hideAllInfoElements:(BOOL)inBoolVal;


@end
