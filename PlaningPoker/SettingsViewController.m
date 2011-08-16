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
    return YES;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"General";
        case 1:
            return @"Card Deck";
        case 2:
            return @"Card Background";
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch(section) {
        case 0:
            return 1;
        case 1:
            return self.delegate.cardDecks.numberOfDecks;
        case 2:
            return self.delegate.cardBackgrounds.numberOfBackgrounds;
    }
    return 0;
}

static NSString *GeneralCellIdentifier = @"SettingsGeneralCell";
static NSString *DeckCellIdentifier = @"SettingsDeckCell";
static NSString *ColorCellIdentifier = @"SettingsColorCell";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    switch (indexPath.section) {
        case 0: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GeneralCellIdentifier];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GeneralCellIdentifier] autorelease];
            }
            
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Hide selected card";
                    UISwitch *hideSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
                    [hideSwitch setOn:self.delegate.hideSelectedCard];
                    [hideSwitch addTarget:self action:@selector(hideSelectedCardChanged:) forControlEvents:UIControlEventValueChanged];
                    cell.accessoryView = hideSwitch;
                    [hideSwitch release];
                    break;
            }
            return cell;
        }
        case 1: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DeckCellIdentifier];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DeckCellIdentifier] autorelease];
            }
            
            CardDeck *cardDeck = [self.delegate.cardDecks deckByIndex:indexPath.row];
            if ( cardDeck == self.delegate.currentDeck ) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                selectedDeckIndex = indexPath.row;
            } else
                cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.text = cardDeck.name;
            return cell;;
        }
        case 2: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ColorCellIdentifier];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ColorCellIdentifier] autorelease];
            }
            
            id <CardBackground> cardBackground = [self.delegate.cardBackgrounds backgroundByIndex:indexPath.row];
            if ( cardBackground == self.delegate.currentCardBackground ) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                selectedBackgroundIndex = indexPath.row;
            } else
                cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.text = cardBackground.name;
            return cell;
        }

    }
    return nil;
}

- (void)hideSelectedCardChanged:(id)sender
{
    UISwitch *hideSwitch = (UISwitch *)sender;
    
    self.delegate.hideSelectedCard = hideSwitch.on;
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
        case 2: {
            if ( indexPath.row == selectedBackgroundIndex )
                return;
            
            NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:selectedBackgroundIndex inSection:2];
            
            UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];    
            if (newCell.accessoryType == UITableViewCellAccessoryNone) {
                newCell.accessoryType = UITableViewCellAccessoryCheckmark;
                selectedBackgroundIndex = indexPath.row;
                [self.delegate setCurrentBackgroundIndex:selectedBackgroundIndex];
                [self.delegate setCurrentDeckIndex:selectedDeckIndex];
            }
            
            UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];    
            if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) {
                oldCell.accessoryType = UITableViewCellAccessoryNone;
            }            
        }
    }
}

@end
