//
//  CardDeckViewController.m
//  PlaningPoker
//
//  Created by Junglas Bodo on 01.08.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import "CardDeckViewController.h"

@implementation CardDeckViewController

@synthesize cardButtons = _cardButtons;
@synthesize cardDecks = _cardDecks;
@synthesize currentDeck = _currentDeck;

- (IBAction)selectCard:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    CardHiddenViewController *controller;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        controller = [[[CardHiddenViewController alloc] initWithNibName:@"CardHiddenView_iPhone" bundle:nil] autorelease];
    else
        controller = [[[CardHiddenViewController alloc] initWithNibName:@"CardHiddenView_iPad" bundle:nil] autorelease];
        
    controller.delegate = self;
    id cardValue = [self.currentDeck.cardValues objectAtIndex:button.tag];
    
    if ( [cardValue isKindOfClass:[NSString class]] ) {
        controller.cardValueString = cardValue;
        controller.cardValueImage = nil;
    } else if ( [cardValue isKindOfClass:[NSArray class]] ) {
        controller.cardValueString = nil;
        controller.cardValueImage = [cardValue objectAtIndex:1];
    }
    
    controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:controller animated:YES];
}

- (void)cardHiddenFinished:(CardHiddenViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];    
}

- (IBAction)settings:(id)sender
{
    SettingsViewController *controller;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        controller = [[[SettingsViewController alloc] initWithNibName:@"SettingsView_iPhone" bundle:nil] autorelease];
    else
        controller = [[[SettingsViewController alloc] initWithNibName:@"SettingsView_iPad" bundle:nil] autorelease];
    controller.delegate = self;
    
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
}

- (void)settingsFinished:(SettingsViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)setCurrentDeckIndex:(NSInteger)deckIndex
{
    if (_currentDeck != nil) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setInteger:deckIndex forKey:@"activeCardDeck"];
        [userDefaults synchronize];        
    }
    
    _currentDeck = [self.cardDecks deckByIndex:deckIndex];
    
    for (UIButton *button in self.cardButtons) {
        if (button.tag >= self.currentDeck.cardValues.count) {
            button.hidden = YES;
        } else {
            button.hidden = NO;
            id cardValue = [self.currentDeck.cardValues objectAtIndex:button.tag];
            
            if ( [cardValue isKindOfClass:[NSString class]] ) {
                [button setTitle:cardValue
                        forState:UIControlStateNormal];
                [button setImage:nil
                        forState:UIControlStateNormal];
            } else if ( [cardValue isKindOfClass:[NSArray class]] ) {
                [button setTitle:nil
                        forState:UIControlStateNormal];
                [button setImage:[cardValue objectAtIndex:0]
                        forState:UIControlStateNormal];
            }
        }
    } 
}

- (BOOL)hideSelectedCard
{
    return _hideSelectedCard;
}

- (void)setHideSelectedCard:(BOOL)hideSelectedCard
{
    if ( _hideSelectedCard != hideSelectedCard) {
        _hideSelectedCard = hideSelectedCard;
        [[NSUserDefaults standardUserDefaults] setBool:hideSelectedCard forKey:@"hideSelectedCard"];
    }
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

    NSDictionary *initDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithBool:YES], @"hideSelectedCard", 
                                  [NSNumber numberWithInt:1], @"activeCardDeck",
                                  nil];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults registerDefaults:initDefaults];

    _cardDecks = [[CardDecks alloc] init];    
    self.hideSelectedCard = [userDefaults boolForKey:@"hideSelectedCard"];
    [self setCurrentDeckIndex:[userDefaults integerForKey:@"activeCardDeck"]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [_cardDecks release];
    self.cardButtons = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait) || (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

@end
