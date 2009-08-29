//
//  TweetTableViewController.h
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-01-12.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TweetTableViewController : UITableViewController {
	IBOutlet UITableView * tweetsTable;
	UIActivityIndicatorView * activityIndicator;
	CGSize cellSize;
	NSXMLParser * rssParser;
	NSMutableArray * tweets;
	
	// a temporary item; added to the "stories" array one at a time, and cleared for the next one
	NSMutableDictionary * item;
	
	// it parses through the document, from top to bottom...
	// we collect and cache each sub-element value, and then save each item to our array.
	// we use these to track each current item, until it's ready to be added to the "stories" array
	NSString * currentElement;
	NSDictionary * currentAttributeDict;
	NSMutableString * currentTitle, * currentDate, * currentSummary, * currentLink;		
}

- (void)parseXMLFileAtURL:(NSString *)URL;

@end