//
//  PlanRouteViewController.m
//  iDrive81
//
//  Created by CS3714 on 11/29/12.
//  Copyright (c) 2012 GroupC. All rights reserved.
//

#import "PlanRouteViewController.h"
#import "StopFeaturesViewController.h"

@interface PlanRouteViewController ()

@end

@implementation PlanRouteViewController

BOOL validAddress;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please do not use this app and drive." delegate:self cancelButtonTitle:@"Accept" otherButtonTitles:@"Deline", nil];
    [alert show];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//hide the keyboard when the user is done editing
-(IBAction)keyBoardDone:(id)sender
{
    [sender resignFirstResponder];
    
}

//check validitiy of input then show next view
- (IBAction)selectRoutePressed:(id)sender {
    
    [self setFrom:[self getLocationFromString:[self.startTextField text]]];
    if(!validAddress)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Invalid Start Address" delegate:self cancelButtonTitle:@"Accept" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
   
    validAddress = false;
    
   [self setTo:[self getLocationFromString:[self.endTextField text]]];
    if(!validAddress)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Invalid End Address" delegate:self cancelButtonTitle:@"Accept" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    
    
    [self performSegueWithIdentifier:@"stopFeatures" sender:self];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString * identifier = [segue identifier];
    
    if([identifier isEqualToString:@"stopFeatures"])
    {
        //pass entered data downstream
        
        StopFeaturesViewController *stopFeaturesViewController = [segue destinationViewController];
        
        [stopFeaturesViewController setTo:self.to];
        [stopFeaturesViewController setFrom:self.from];
        
        
    }
}

//returns location object from address string using Google Maps API to geocode
-(CLLocationCoordinate2D) getLocationFromString:(NSString*) addressStr {
    
    NSString *urlStr = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=csv",
                        [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *locationStr = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlStr] encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *items = [locationStr componentsSeparatedByString:@","];
    
    double lat = 0.0;
    double lon = 0.0;
    
    if([items count] >= 4 && [[items objectAtIndex:0] isEqualToString:@"200"]) {
        lat = [[items objectAtIndex:2] doubleValue];
        lon = [[items objectAtIndex:3] doubleValue];
        
        validAddress = true;
    }
    else {
        
        validAddress = false;
    }
    CLLocationCoordinate2D location;
    location.latitude = lat;
    location.longitude = lon;
    
    
    return location;
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 0)
    {
        //do nothing
    }
    else
    {
        //quit app
        exit(0);
    }
}

@end
