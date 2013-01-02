//
//  StopFeaturesViewController.m
//  iDrive81
//
//  Created by CS3714 on 11/29/12.
//  Copyright (c) 2012 GroupC. All rights reserved.
//

#import "StopFeaturesViewController.h"
#import "CategoryCell.h"
#import "MatchingStopsViewController.h"

@interface StopFeaturesViewController ()

@end

@implementation StopFeaturesViewController

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
    //load category data file
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ammenities" ofType:@"plist"];
    
    //instantiate dictionary with file
    self.rootCats = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    self.cats = [self.rootCats objectForKey:@"Ammenities"];
    
    self.selectedCats = [[NSMutableArray alloc] init];
    
   
    
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
    return [self.cats count];
}

- (CategoryCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    //get row number
    NSUInteger rowNumber = [indexPath row];
    
     CategoryCell *cell = (CategoryCell *)[tableView dequeueReusableCellWithIdentifier:@"catCell"];
    
    //customize cell
    cell.catLabel.text = [self.cats objectAtIndex:rowNumber];
    
    return cell;
    
}


// Informs the table view delegate that the specified row is now selected.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //add selected object to the array
    [self.selectedCats addObject:[self.cats objectAtIndex:[indexPath row]]];
    
}

//informs of deselection event
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.selectedCats removeObject:[self.cats objectAtIndex:[indexPath row]]];
    
}


- (IBAction)findMyExitsPressed:(id)sender {
    
    [self performSegueWithIdentifier:@"matchStops" sender:self];
    
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString * identifier = [segue identifier];
    
    if([identifier isEqualToString:@"matchStops"])
    {
        //pass entered data downstream
        
        MatchingStopsViewController *matchingStopsViewController = [segue destinationViewController];
        
        //pass the array of selected items down
        [matchingStopsViewController setSelectedCats:self.selectedCats];
        [matchingStopsViewController setTo:self.to];
        [matchingStopsViewController setFrom:self.from];
        
        
    }
}
@end
