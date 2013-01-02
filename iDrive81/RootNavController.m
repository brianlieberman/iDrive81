//
//  RootNavController.m
//  iDrive81
//
//  Created by Brian Lieberman on 12/6/12.
//  Copyright (c) 2012 GroupC. All rights reserved.
//

#import "RootNavController.h"


@interface RootNavController ()

@end

@implementation RootNavController

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate
{
    
    return YES;
}


- (NSUInteger)supportedInterfaceOrientations {
    
    NSUInteger orientations = UIInterfaceOrientationMaskPortrait;
  
    if([[self topViewController] isMemberOfClass:NSClassFromString(@"MapViewController")])
    {
        orientations |= UIInterfaceOrientationMaskLandscapeLeft;
        orientations |= UIInterfaceOrientationMaskLandscapeRight;
    }
    return orientations;
}

@end
