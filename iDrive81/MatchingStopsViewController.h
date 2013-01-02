//
//  MatchingStopsViewController.h
//  iDrive81
//
//  Created by Brian Lieberman on 12/4/12.
//  Copyright (c) 2012 GroupC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MatchingStopsViewController : UIViewController


//data structures for storing/sorting exits
@property (nonatomic, strong) NSMutableArray *selectedCats;

@property (nonatomic, strong) NSMutableArray *matchedExits;

@property (nonatomic, strong) NSArray *allExits;

@property (nonatomic, strong) NSDictionary *rootExitLocs;

@property (nonatomic, strong) NSDictionary *rootExitAmens;

@property (strong, nonatomic) IBOutlet UITableView *matchesTable;

@property (nonatomic, strong) NSString *exitName;


//start data entered by user
@property  CLLocationCoordinate2D from;

//destination data entered by user
@property CLLocationCoordinate2D to;

//exit object
@property CLLocationCoordinate2D exit;

@end
