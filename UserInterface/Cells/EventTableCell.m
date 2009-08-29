//
//  EventTableCell.m
//  iBurn
//
//  Created by Jeffrey Johnson on 8/27/09.
//  Copyright 2009. All rights reserved.
//

#import "EventTableCell.h"

@interface EventTableCell(Private_Methods)
	-(void)layoutViewsInRect:(CGRect)frame;
@end

@implementation EventTableCell

@synthesize mNeedsLayout;
@synthesize mDelegate;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	
	if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
		
		// Initialization code
		mNeedsLayout = YES;
		
		// Setup Cell accessory type
		self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		CGRect dummyRect = {0.0,0.0,0.0,0.0};

		/*Initialize and setup Name Title Field*/
		mNameTitleField = [ [ UILabel alloc ] initWithFrame: dummyRect];
		mNameTitleField.opaque = NO;
		mNameTitleField.textAlignment = UITextAlignmentLeft;
		mNameTitleField.textColor = [UIColor blueColor];
		mNameTitleField.highlightedTextColor = [ UIColor whiteColor];
		mNameTitleField.font = [UIFont systemFontOfSize:15.0];
		mNameTitleField.lineBreakMode = UILineBreakModeTailTruncation;
		[self.contentView addSubview:mNameTitleField];
		[mNameTitleField release];
		
		/*Initialise and setup Name Description Field*/
		mNameDescriptionField = [ [ UILabel alloc ] initWithFrame: dummyRect];
		mNameDescriptionField.opaque = NO;
		mNameDescriptionField.textAlignment = UITextAlignmentLeft;
		mNameDescriptionField.textColor = [UIColor darkGrayColor];
		mNameDescriptionField.highlightedTextColor = [ UIColor whiteColor];
		mNameDescriptionField.font = [UIFont systemFontOfSize:11.0];
		mNameDescriptionField.lineBreakMode = UILineBreakModeTailTruncation;
		[self.contentView addSubview:mNameDescriptionField];
		[mNameDescriptionField release];
				
		/*Initialise and setup View Button*/
		/*
		mViewMapButton = [ UIButton buttonWithType:UIButtonTypeCustom];
		[mViewMapButton setFrame:dummyRect];
		[mViewMapButton addTarget:self action:@selector(viewMap:) forControlEvents:UIControlEventTouchDown]; 
		[mViewMapButton setImage:[UIImage imageNamed:@"map_black.png"] forState:UIControlStateNormal]; 
		mViewMapButton.showsTouchWhenHighlighted = YES; 
		mViewMapButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
		mViewMapButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
		[self.contentView addSubview:mViewMapButton];
		 */
	}
	return self;
}


-(void)dealloc
{
	[mViewMapButton release];
	[super dealloc];
}

- (void)drawRect:(CGRect)rect {
	// Drawing code
	
	[super drawRect: rect];
	
	if( mNeedsLayout )
	{
		[self layoutViewsInRect:self.contentView.frame];
		self.mNeedsLayout = NO;
	}
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	// Configure the view for the selected state
	[super setSelected:selected animated:animated];
}


- (void)prepareForReuse {
	// If the cell is reusable (has a reuse identifier), this method is called just before the cell is returned from the table view method dequeueReusableCellWithIdentifier:
	[super prepareForReuse];
}


//Layout the Name Info UI elements 
-(void)layOutViews
{
	[self layoutViewsInRect:self.contentView.frame];
}

//Action method invoked when View Map button is pressed
-(void)viewMap:(id)inSender
{
	//Delegate the view map click to the designated delegate
	if( [mDelegate respondsToSelector:@selector(tableViewCellDidClickViewMap:)] )
	{
		[mDelegate tableViewCellDidClickViewMap:self];
	}
}



//Layout the Name Info display UI elements in given Frame 'inFrame'
-(void)layoutViewsInRect:(CGRect)inFrame
{
	CGRect msgTitleRect       = { 10,   2, 275, NAME_TITLE_FIELD_HEIGHT};
	CGRect msgDescriptionRect = { 10,   20, 275, NAME_DESC_FIELD_HEIGHT};
	CGRect viewMapRect        = { 253,   8, VIEW_MAP_BUTTON_WIDTH, VIEW_MAP_BUTTON_HEIGHT};
	
	[mNameTitleField setFrame:msgTitleRect];
	[mNameDescriptionField setFrame:msgDescriptionRect];
	[mViewMapButton setFrame:viewMapRect];
}


//Initalise the UI elements with appropriate values from the passed in Event object
- (void) setEventInfo:(Event *)inEvent
{		
	//Assign appropriate values to the UI elements
	[mNameTitleField setText:[inEvent objectForKey: @"title"]];
	[mNameDescriptionField setText:[inEvent objectForKey: @"time"]];

	[mViewMapButton setHidden:NO];	
}




@end
