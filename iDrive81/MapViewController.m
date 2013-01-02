//
//  MapViewController.m
//  iDrive81
//
//  Created by Brian Lieberman on 12/7/12.
//  Copyright (c) 2012 GroupC. All rights reserved.
//

#import "MapViewController.h"
#import "MapAnnotation.h"

@interface MapViewController ()

@end

@implementation MapViewController

bool track;

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
    MapAnnotation * exitAnnotation = [[MapAnnotation alloc]
                                    initWithMapCoordinate:self.exit
                                    annotationTitle: self.exitName
                                    annotationSubtitle: [NSString stringWithFormat:@"Open Spots: %d", arc4random() % (20)]];
    
    
    MapAnnotation * startAnnotation = [[MapAnnotation alloc]
                                      initWithMapCoordinate:self.from
                                      annotationTitle: @"Start"
                                      annotationSubtitle: @""];
    
    MapAnnotation * endAnnotation = [[MapAnnotation alloc]
                                      initWithMapCoordinate:self.to
                                      annotationTitle: @"Destination"
                                      annotationSubtitle: @""];
    
    
    
    [self.mapView addAnnotation:exitAnnotation];
    [self.mapView addAnnotation:startAnnotation];
    [self.mapView addAnnotation:endAnnotation];
    
    track = YES;
    
    [self.mapView.userLocation addObserver:self
                                forKeyPath:@"location"
                                   options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld)
                                   context:nil];
    

    
  
    
    [super viewDidLoad];
    
   	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    MKCoordinateRegion region;
    region.center = self.mapView.userLocation.coordinate;
    
    MKCoordinateSpan span;
    span.latitudeDelta  = .0065; // Change these values to change the zoom
    span.longitudeDelta = .0065;
    region.span = span;
    
 
    
    
    [self.mapView setRegion:region animated:YES];
    
   }

- (void)dealloc
{
    if(track)
    {
    [self.mapView.userLocation removeObserver:self forKeyPath:@"location"];
    }
    [self.mapView removeFromSuperview]; 
    self.mapView = nil;

}
- (IBAction)trackButtonPressed:(id)sender {
    
    if(track)
    {
        [self.mapView.userLocation removeObserver:self forKeyPath:@"location"];
        self.trackButton.title = @"Tracking: Off";
        
        track = NO;
        return;
    }
    else
    {
        [self.mapView.userLocation addObserver:self
                                    forKeyPath:@"location"
                                       options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld)
                                       context:nil];
        
        self.trackButton.title = @"Tracking: On";
        track = YES;
        return;

    }
    
}
@end
