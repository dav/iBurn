// This protocol is used to send the text for location updates back to another view controller
@protocol MyCLControllerDelegate <NSObject>
@required
-(void)newLocationUpdate:(CLLocation *)newLocation;
-(void)newError:(NSString *)text;
@end


// Class definition
@interface MyCLController : NSObject <CLLocationManagerDelegate> {
	CLLocationManager *locationManager;
	id delegate;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic,assign) id <MyCLControllerDelegate> delegate;


- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation;

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error;

+ (MyCLController *)sharedInstance;

@end

