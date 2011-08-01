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
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.delegate.cardDecks.numberOfDecks;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Card deck";
}
static NSString *CellIdentifier = @"CardDeckCell";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }

    CardDeck *cardDeck = [self.delegate.cardDecks deckByIndex:indexPath.row];
    if ( cardDeck == self.delegate.currentDeck ) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        selectedDeckIndex = indexPath.row;
    } else
        cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text = cardDeck.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ( indexPath.row == selectedDeckIndex )
        return;
    
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:selectedDeckIndex inSection:0];
    
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
}

@end
