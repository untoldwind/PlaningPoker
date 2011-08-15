//
//  CardHiddenViewController.m
//  SCRUMPlaningPoker
//
//  Created by Junglas Bodo on 29.07.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import "CardHiddenViewController.h"
#import "CardBackground.h"
#import "CardSymbol.h"

@implementation CardHiddenViewController

@synthesize delegate = _delegate;
@synthesize cardValue = _cardValue;

@synthesize revealButton = _revealButton;
@synthesize cardButton = _cardButton;

- (IBAction)reaveal:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5]; 
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    self.revealButton.hidden = YES;
    self.cardButton.hidden = NO;
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
        
    [self.cardButton setTitleColor:self.delegate.currentCardBackground.textColor forState:UIControlStateNormal];
    [self.cardButton setTitleColor:self.delegate.currentCardBackground.textColor forState:UIControlStateHighlighted];
    [self.cardButton setTitleShadowColor:self.delegate.currentCardBackground.shadowColor forState:UIControlStateNormal];
    [self.cardButton setTitleShadowColor:self.delegate.currentCardBackground.shadowColor forState:UIControlStateHighlighted];
    
    if ( [self.cardValue isKindOfClass:[NSString class]] ) {
        [self.cardButton setTitle:self.cardValue forState:UIControlStateNormal];
        [self.cardButton setImage:nil forState:UIControlStateNormal];
    } else if ( [self.cardValue isKindOfClass:[CardSymbol class]] ) {
        [self.cardButton setTitle:nil forState:UIControlStateNormal];
        [self.cardButton setImage:[self.cardValue imageWithSize:self.cardButton.titleLabel.font.pointSize 
                                                            color:[self.cardButton titleColorForState:UIControlStateNormal]
                                                    shadowOffset:self.cardButton.titleLabel.shadowOffset
                                                     shadowColor:[self.cardButton titleShadowColorForState:UIControlStateNormal]] 
                         forState:UIControlStateNormal];        
    }
        
    [self.cardButton setBackgroundImage:[self.delegate.currentCardBackground normal:self.cardButton.frame.size 
                                                                          cardValue:self.cardValue]
                               forState:UIControlStateNormal];
    [self.revealButton setBackgroundImage:[self.delegate.currentCardBackground hidden:self.revealButton.frame.size] forState:UIControlStateNormal];
    if (!self.delegate.hideSelectedCard) {
        self.revealButton.hidden = YES;
        self.cardButton.hidden = NO;
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
