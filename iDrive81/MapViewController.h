//
//  MapViewController.h
//  iDrive81
//
//  Created by Brian Lieberman on 12/7/12.
//  Copyright (c) 2012 GroupC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController

@property (strong, nonatomic) IBOutlet MKMapView *mapView;


//start data entered by user
@property  CLLocationCoordinate2D from;

//destination data entered by user
@property CLLocationCoordinate2D to;

//exit object
@property CLLocationCoordinate2D exit;

@property (strong, nonatomic)  NSString *exitName;


- (IBAction)trackButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *trackButton;

@end
