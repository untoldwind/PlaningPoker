//
//  CardHiddenViewController.m
//  SCRUMPlaningPoker
//
//  Created by Junglas Bodo on 29.07.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import "CardHiddenViewController.h"
#import "CardBackground.h"

@implementation CardHiddenViewController

@synthesize delegate = _delegate;
@synthesize cardValueString = _cardValueString;
@synthesize cardValueImage = _cardValueImage;

@synthesize revealButton = _revealButton;
@synthesize cardButton = _cardButton;

- (IBAction)reaveal:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5]; 
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    [self.revealButton setHidden:YES];
    [self.cardButton setHidden:NO];
    [UIView commitAnimations];
}

- (IBAction)dismiss:(id)sender
{    
    [self.delegate cardHiddenFinished:self];    
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

    [self.cardButton setTitle:self.cardValueString forState:UIControlStateNormal];
    [self.cardButton setImage:self.cardValueImage forState:UIControlStateNormal];
    [self.cardButton setBackgroundImage:[self.delegate.currentCardBackground normal:self.cardButton.frame.size] forState:UIControlStateNormal];
    [self.revealButton setBackgroundImage:[self.delegate.currentCardBackground hidden:self.revealButton.frame.size] forState:UIControlStateNormal];
    if (!self.delegate.hideSelectedCard) {
        [self.revealButton setHidden:YES];
        [self.cardButton setHidden:NO];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.revealButton = nil;
    self.cardButton = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait) || (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

@end
