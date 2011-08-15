//
//  CardDeckViewController.m
//  PlaningPoker
//
//  Created by Junglas Bodo on 01.08.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import "CardDeckViewController.h"

#import "CardBackground.h"
#import "CardSymbol.h"
#import "CAHelper.h"

@implementation CardDeckViewController

@synthesize cardButtons = _cardButtons;
@synthesize animationView = _animationView;
@synthesize cardDecks = _cardDecks;
@synthesize currentDeck = _currentDeck;
@synthesize currentCardBackground = _currentCardBackground;
@synthesize cardBackgrounds = _cardBackgrounds;

- (IBAction)selectCard:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    CardHiddenViewController *controller;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        controller = [[[CardHiddenViewController alloc] initWithNibName:@"CardHiddenView_iPhone" bundle:nil] autorelease];
    else
        controller = [[[CardHiddenViewController alloc] initWithNibName:@"CardHiddenView_iPad" bundle:nil] autorelease];
    
    controller.delegate = self;
    controller.cardValue = [self.currentDeck.cardValues objectAtIndex:button.tag];
    
    [CATransaction begin];
    [CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
    
    UIGraphicsBeginImageContext(button.bounds.size);
    [button.layer renderInContext:UIGraphicsGetCurrentContext()];
        
    _frontLayer.frame = button.frame;
    _frontLayer.contents = (id)UIGraphicsGetImageFromCurrentImageContext().CGImage;
    _frontLayer.hidden = NO;

    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(controller.view.bounds.size);
    [controller.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    _backLayer.frame = button.frame;
    _backLayer.contents = (id)UIGraphicsGetImageFromCurrentImageContext().CGImage;
    _backLayer.hidden = NO;
    
    UIGraphicsEndImageContext();
    
    [CATransaction commit];

    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [self presentModalViewController:controller animated:NO];
        _frontLayer.frame = button.frame;
        _frontLayer.hidden = YES;
        _backLayer.hidden = YES;
    }];
    
    CAAnimation *front = CAHFlipResizeAnimation(0.5f, 0.0, -M_PI, button.frame, controller.view.bounds);
    CAAnimation *back = CAHFlipResizeAnimation(0.5f, M_PI, 0.0, button.frame, controller.view.bounds);
    [_frontLayer addAnimation:front forKey:@"flip"];
    [_backLayer addAnimation:back forKey:@"flip"];
    
    [CATransaction commit];
        
//    controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
//    [self presentModalViewController:controller animated:YES];
}

- (void)cardHiddenFinished:(CardHiddenViewController *)controller
{
    [CATransaction begin];
    [CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];

    UIGraphicsBeginImageContext(controller.view.bounds.size);
    [controller.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    _backLayer.frame = controller.view.bounds;
    _backLayer.contents = (id)UIGraphicsGetImageFromCurrentImageContext().CGImage;
    _backLayer.hidden = NO;
    _frontLayer.hidden = NO;

    [CATransaction commit];
    
    UIGraphicsEndImageContext();

    [self dismissModalViewControllerAnimated:NO];    

    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        _frontLayer.hidden = YES;
        _backLayer.hidden = YES;
    }];
    
    CAAnimation *front = CAHFlipResizeAnimation(0.5f, -M_PI, 0.0, _backLayer.frame, _frontLayer.frame);
    CAAnimation *back = CAHFlipResizeAnimation(0.5f, 0.0, M_PI, _backLayer.frame, _frontLayer.frame);
    [_frontLayer addAnimation:front forKey:@"flip"];
    [_backLayer addAnimation:back forKey:@"flip"];
    
    [CATransaction commit];
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
            } else if ( [cardValue isKindOfClass:[CardSymbol class]] ) {
                [button setTitle:nil
                        forState:UIControlStateNormal];
                [button setImage:[cardValue imageWithSize:button.titleLabel.font.pointSize 
                                                    color:[button titleColorForState:UIControlStateNormal]
                                             shadowOffset:button.titleLabel.shadowOffset
                                              shadowColor:[button titleShadowColorForState:UIControlStateNormal]] 
                        forState:UIControlStateNormal];
            }
            [button setBackgroundImage:[self.currentCardBackground normal:button.frame.size 
                                                                cardValue:cardValue] 
                              forState:UIControlStateNormal];
        }
    } 
}

- (void)setCurrentBackgroundIndex:(NSInteger)backgroundIndex
{
    if (_currentCardBackground != nil) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setInteger:backgroundIndex forKey:@"activeCardBackground"];
        [userDefaults synchronize];        
    }

    _currentCardBackground = [self.cardBackgrounds backgroundByIndex:backgroundIndex];

    for (UIButton *button in self.cardButtons) {
        [button setTitleColor:self.currentCardBackground.textColor forState:UIControlStateNormal];
        [button setTitleColor:self.currentCardBackground.textColor forState:UIControlStateHighlighted];
        [button setTitleShadowColor:self.currentCardBackground.shadowColor forState:UIControlStateNormal];
        [button setTitleShadowColor:self.currentCardBackground.shadowColor forState:UIControlStateHighlighted];
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

    
	_frontLayer= [CALayer layer];
	_frontLayer.doubleSided = NO;
    _frontLayer.hidden = YES;
	_frontLayer.name = @"Front";
	[_frontLayer setMasksToBounds:YES];
    
	_backLayer = [CALayer layer];
	_backLayer.doubleSided = NO;
    _backLayer.hidden = YES;
	_backLayer.name = @"Back";
	[_backLayer setMasksToBounds:YES];

    CGFloat zDistance = 1500.0f;
    CATransform3D perspective = CATransform3DIdentity; 
    perspective.m34 = -1. / zDistance;
    _frontLayer.transform = perspective;
    _backLayer.transform = perspective;
    
    [self.animationView.layer addSublayer:_backLayer];
	[self.animationView.layer addSublayer:_frontLayer];

    NSDictionary *initDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithBool:YES], @"hideSelectedCard", 
                                  [NSNumber numberWithInt:1], @"activeCardDeck",
                                  [NSNumber numberWithInt:0], @"activeCardBackground",
                                  nil];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults registerDefaults:initDefaults];

    _cardDecks = [[CardDecks alloc] init];    
    _cardBackgrounds = [[CardBackgrounds alloc] init];
    
    self.hideSelectedCard = [userDefaults boolForKey:@"hideSelectedCard"];
    [self setCurrentBackgroundIndex:[userDefaults integerForKey:@"activeCardBackground"]];
    [self setCurrentDeckIndex:[userDefaults integerForKey:@"activeCardDeck"]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [_cardDecks release];
    [_cardBackgrounds release];
    [_frontLayer release];
    [_backLayer release];
    self.cardButtons = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait) || (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

@end
