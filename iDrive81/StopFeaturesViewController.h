//
//  StopFeaturesViewController.h
//  iDrive81
//
//  Created by CS3714 on 11/29/12.
//  Copyright (c) 2012 GroupC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface StopFeaturesViewController : UIViewController

//destination data entered by user
@property  CLLocationCoordinate2D from;

//destination data entered by user
@property CLLocationCoordinate2D to;

//root dictionary file
@property (nonatomic, strong) NSDictionary *rootCats;

//selected array
@property (nonatomic, strong) NSMutableArray *selectedCats;

//categories array
@property (nonatomic, strong) NSArray *cats;

//handler for find button
- (IBAction)findMyExitsPressed:(id)sender;


@end
