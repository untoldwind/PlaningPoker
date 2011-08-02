//
//  SettingsSelectColorViewController.m
//  PlaningPoker
//
//  Created by Junglas Bodo on 02.08.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import "SettingsSelectColorViewController.h"

#import "SettingsViewController.h"

@implementation SettingsSelectColorViewController

@synthesize delegate = _delegate;
@synthesize settingsDelegate = _settingsDelegate;

- (IBAction)done
{
    [self.delegate settingsSelectColorFinished:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Card color";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.settingsDelegate.cardBackgrounds.numberOfBackgrounds;
}

static NSString *CellIdentifier = @"SettingsSelectColorCell";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    CardBackground *cardBackground = [self.settingsDelegate.cardBackgrounds backgroundByIndex:indexPath.row];
    if ( cardBackground == self.settingsDelegate.currentCardBackground ) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
            selectedBackgroundIndex = indexPath.row;
        } else
            cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text = cardBackground.name;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ( indexPath.row == selectedBackgroundIndex )
        return;
            
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:selectedBackgroundIndex inSection:0];
            
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];    
    if (newCell.accessoryType == UITableViewCellAccessoryNone) {
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        selectedBackgroundIndex = indexPath.row;
        [self.settingsDelegate setCurrentBackgroundIndex:selectedBackgroundIndex];
    }
            
    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];    
    if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        oldCell.accessoryType = UITableViewCellAccessoryNone;
    }
}

@end
