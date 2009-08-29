//
//  TweetComposerViewController.m
//  iBurn
//
//  Created by Jeffrey Johnson on 2009-01-19.
//  Copyright 2009 Burning Man Earth. All rights reserved.
//

#import "TweetComposerViewController.h"
#import "MultipartForm.h"


@implementation TweetComposerViewController

- (TweetComposerViewController *)initWithTitle: (NSString *) aTitle {
	self = [super init];
	self.title = aTitle;
	[self.tabBarItem initWithTitle:self.title image:NULL tag:NULL];
    return self;
}

- (void)loadView {
	tweetContent = [[UITextView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	[tweetContent setDelegate:self];
	self.view = tweetContent;
	[tweetContent release];
}

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

- (void) textViewDidBeginEditing: (UITextView *) textViewDidBeginEditing
{
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] 
											  initWithTitle:@"Send"
											  style:UIBarButtonItemStyleDone
											  target:self
											   action:@selector(sendTweet:)] 
											  autorelease];
												
}

- (void) sendTweet: (id) sender
{
	//Not Implemented
	UIAlertView *notImplemented = [[UIAlertView alloc]
								   initWithTitle:@"Send a Tweet"
								   message:@"Not Yet Implemented"
								   delegate:self 
								   cancelButtonTitle:nil
								   otherButtonTitles:@"OK", nil];
	[notImplemented show];
	/*
	
	NSString *tweetText = [tweetContent text];	
	NSURL *postUrl = [NSURL URLWithString:@"http://pemobiletag.pictearthusa.com/geotag/image_upload/"];

	MultipartForm *form = [[MultipartForm alloc] initWithURL:postUrl];
    [form addFormField:@"tweetText" withStringData:tweetText];
	NSMutableURLRequest *postRequest = [form mpfRequest];

	NSData *urlData;
    NSURLResponse *response;
    NSError *error;
	urlData = [NSURLConnection sendSynchronousRequest:postRequest returningResponse:&response error:&error];
	 */	
	//[result release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[tweetContent release];
    [super dealloc];
}


@end
