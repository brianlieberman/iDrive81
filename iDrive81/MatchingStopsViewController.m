//
//  MatchingStopsViewController.m
//  iDrive81
//
//  Created by Brian Lieberman on 12/4/12.
//  Copyright (c) 2012 GroupC. All rights reserved.
//

#import "MatchingStopsViewController.h"
#import "MatchCell.h"
#import "MapViewController.h"

@interface MatchingStopsViewController ()

@end

@implementation MatchingStopsViewController

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
    
    //load exit data
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"exitLocations" ofType:@"plist"];
    
    //instantiate dictionary with file
    self.rootExitLocs = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    
    //load exit data
    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"exits" ofType:@"plist"];
    
    //instantiate dictionary with file
    self.rootExitAmens = [[NSDictionary alloc] initWithContentsOfFile:filePath2];
    
    //load exit names into array
    self.allExits  = [[self.rootExitLocs allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    self.matchedExits = [[NSMutableArray alloc] init];
    
    //find exits in location range
    for(int i = 0; i < [self.allExits count]; i++)
    {
        NSArray *exit = [self.rootExitLocs objectForKey:[self.allExits objectAtIndex:i]];
        
        //find all the exits between start and stop 
        if((((self.from.latitude < [[exit objectAtIndex:0] doubleValue] ) && ([[exit objectAtIndex:0] doubleValue] < self.to.latitude ))) || (((self.from.latitude > [[exit objectAtIndex:0] doubleValue] ) && ([[exit objectAtIndex:0] doubleValue] > self.to.latitude )) )   )
            
        {
            //add matched exit
            [self.matchedExits addObject:exit];
            
        }
    }
    

    int exitCount = [self.matchedExits count];
    //filter exits meeting criteria
    for(int i = 0; i < exitCount; i++)
    {
        NSMutableDictionary * currentExit = [self.rootExitAmens objectForKey:[[self.matchedExits objectAtIndex:i] objectAtIndex:2]];
        
        for(int j = 0; j < [self.selectedCats count]; j++)
        {
            NSArray * currentAmen = [currentExit objectForKey:[self.selectedCats objectAtIndex:j]];
            
            if([currentAmen count] == 0)
            {
             
               
                [self.matchedExits removeObjectAtIndex:i];
                i--;
                exitCount--;
                break;
               
            }
            
        }
        
    }
    

    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.matchedExits count];
}

- (MatchCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get row number
    NSUInteger rowNumber = [indexPath row];
    
    MatchCell *cell = (MatchCell *)[tableView dequeueReusableCellWithIdentifier:@"matchCell"];
    
    
    
    //customize cell
    cell.exitLabel.text = [[self.matchedExits objectAtIndex:rowNumber] objectAtIndex:2];
    
    return cell;
    
}


// Informs the table view delegate that the specified row is now selected.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray * currentExit = [self.matchedExits objectAtIndex:[indexPath row]];
    
    self.exit = CLLocationCoordinate2DMake([[currentExit objectAtIndex:0] doubleValue], [[currentExit objectAtIndex:1] doubleValue]);
    
    self.exitName = [currentExit objectAtIndex:2];
    
    [self.matchesTable deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:@"showMap" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString * identifier = [segue identifier];
    
    if([identifier isEqualToString:@"showMap"])
    {
        //pass entered data downstream
        
       MapViewController *mapFeaturesViewController = [segue destinationViewController];
        
        [mapFeaturesViewController setTo:self.to];
        [mapFeaturesViewController setFrom:self.from];
        [mapFeaturesViewController setExit:self.exit];
        [mapFeaturesViewController setExitName:self.exitName];
        
      
        
        
    }
}


@end
