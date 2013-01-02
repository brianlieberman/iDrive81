//
//  PlanRouteViewController.h
//  iDrive81
//
//  Created by CS3714 on 11/29/12.
//  Copyright (c) 2012 GroupC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface PlanRouteViewController : UIViewController

//handler to hide the keyboard
-(IBAction)keyBoardDone:(id)sender;

//handler for Select Route Button
- (IBAction)selectRoutePressed:(id)sender;

//Text Fields
@property (strong, nonatomic) IBOutlet UITextField *startTextField;

@property (strong, nonatomic) IBOutlet UITextField *endTextField;

//destination data entered by user
@property  CLLocationCoordinate2D from;

//destination data entered by user
@property CLLocationCoordinate2D to;
@end
