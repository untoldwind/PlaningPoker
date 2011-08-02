//
//  SettingsViewController.m
//  SCRUMPlaningPoker
//
//  Created by Junglas Bodo on 30.07.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import "SettingsViewController.h"

@implementation SettingsViewController

@synthesize delegate = _delegate;

@synthesize cardDeckSelect = _cardDeckSelect;

- (IBAction)linkSelected:(id)sender
{
    NSURL *target = [NSURL URLWithString:@"http://objectcode.de"];
    [[UIApplication sharedApplication] openURL:target];
}

- (IBAction)done:(id)sender
{
    [self.delegate settingsFinished:self];
}

- (void)settingsSelectColorFinished:(SettingsSelectColorViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];    
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
    self.cardDeckSelect = nil;
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
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"General";
        case 1:
            return @"Card Deck";
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch(section) {
        case 0:
            return 2;
        case 1:
            return self.delegate.cardDecks.numberOfDecks;
    }
    return 0;
}

static NSString *CellIdentifier = @"SettingsCell";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Hide selected card";
                    UISwitch *hideSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
                    [hideSwitch setOn:self.delegate.hideSelectedCard];
                    [hideSwitch addTarget:self action:@selector(hideSelectedCardChanged:) forControlEvents:UIControlEventValueChanged];
                    cell.accessoryView = hideSwitch;
                    [hideSwitch release];
                    break;
                case 1:
                    cell.textLabel.text = @"Card color";
                    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
                    break;
            }
            break;
        case 1: {
            CardDeck *cardDeck = [self.delegate.cardDecks deckByIndex:indexPath.row];
            if ( cardDeck == self.delegate.currentDeck ) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                selectedDeckIndex = indexPath.row;
            } else
                cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.text = cardDeck.name;
            break;
        }
    }
    return cell;
}

- (void)hideSelectedCardChanged:(id)sender
{
    UISwitch *hideSwitch = (UISwitch *)sender;
    
    self.delegate.hideSelectedCard = hideSwitch.on;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 1: {
                    SettingsSelectColorViewController *controller;
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                        controller = [[[SettingsSelectColorViewController alloc] initWithNibName:@"SettingsSelectColorView_iPhone" bundle:nil] autorelease];
                    else
                        controller = [[[SettingsSelectColorViewController alloc] initWithNibName:@"SettingsSelectColorView_iPhone" bundle:nil] autorelease];
                    
                    controller.delegate = self;
                    controller.settingsDelegate = self.delegate;
                    
                    controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                    [self presentModalViewController:controller animated:YES];
                    break;
                }
            }
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.section) {
        case 1: {
           if ( indexPath.row == selectedDeckIndex )
                return;
    
            NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:selectedDeckIndex inSection:1];
    
            UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];    
            if (newCell.accessoryType == UITableViewCellAccessoryNone) {
                newCell.accessoryType = UITableViewCellAccessoryCheckmark;
                selectedDeckIndex = indexPath.row;
                [self.delegate setCurrentDeckIndex:selectedDeckIndex];
            }

            UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];    
            if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) {
                oldCell.accessoryType = UITableViewCellAccessoryNone;
            }
            break;

        }
    }
}

@end
