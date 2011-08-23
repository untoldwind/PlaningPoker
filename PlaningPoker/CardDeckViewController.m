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

    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(controller.view.bounds.size);
    [controller.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    _backLayer.frame = button.frame;
    _backLayer.contents = (id)UIGraphicsGetImageFromCurrentImageContext().CGImage;
    
    UIGraphicsEndImageContext();
    
    [CATransaction commit];

    _animationView.hidden = NO;
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [self presentModalViewController:controller animated:NO];
        controller.view.frame = _currentFrame;
//        _frontLayer.frame = button.frame;
        _animationView.hidden = YES;
    }];

    BOOL portrait = UIDeviceOrientationIsPortrait(_orientation);
    if ( portrait ) {
        CAAnimation *front = CAHFlipResizeAnimation(0.5f, 0.0, -M_PI, 0.0, 0.0, button.frame, _animationView.bounds);
        CAAnimation *back = CAHFlipResizeAnimation(0.5f, M_PI, 0.0, 0.0, 0.0, button.frame, _animationView.bounds);
        [_frontLayer addAnimation:front forKey:@"flip"];
        [_backLayer addAnimation:back forKey:@"flip"];
    } else {
        CAAnimation *front = CAHFlipResizeAnimation(0.5f, 0.0, -M_PI, 0.0, M_PI_2, button.frame, _animationView.bounds);
        CAAnimation *back = CAHFlipResizeAnimation(0.5f, M_PI, 0.0, 0.0, M_PI_2, button.frame, _animationView.bounds);
        [_frontLayer addAnimation:front forKey:@"flip"];
        [_backLayer addAnimation:back forKey:@"flip"];    
    }
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
    
    _backLayer.frame = _animationView.bounds;
    _backLayer.contents = (id)UIGraphicsGetImageFromCurrentImageContext().CGImage;

    [CATransaction commit];
    
    UIGraphicsEndImageContext();

    [self dismissModalViewControllerAnimated:NO];
    self.view.frame = _currentFrame;

    _animationView.hidden = NO;
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        _animationView.hidden = YES;
    }];
    
    BOOL portrait = UIDeviceOrientationIsPortrait(_orientation);
    if ( portrait ) {
        CAAnimation *front = CAHFlipResizeAnimation(0.5f, -M_PI, 0.0, 0.0, 0.0, _backLayer.frame, _frontLayer.frame);
        CAAnimation *back = CAHFlipResizeAnimation(0.5f, 0.0, M_PI, 0.0, 0.0, _backLayer.frame, _frontLayer.frame);
        [_frontLayer addAnimation:front forKey:@"flip"];
        [_backLayer addAnimation:back forKey:@"flip"];
    } else {
        CAAnimation *front = CAHFlipResizeAnimation(0.5f, -M_PI, 0.0, M_PI_2, 0.0, _backLayer.frame, _frontLayer.frame);
        CAAnimation *back = CAHFlipResizeAnimation(0.5f, 0.0, M_PI, M_PI_2, 0.0, _backLayer.frame, _frontLayer.frame);
        [_frontLayer addAnimation:front forKey:@"flip"];
        [_backLayer addAnimation:back forKey:@"flip"];        
    }
    
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

- (void)createButtons:(NSInteger)count
{    
    for (UIButton *button in _cardButtons) {
        [button removeFromSuperview];
    }
    [_cardButtons removeAllObjects];
    
    for ( NSInteger i = 0; i < count; i++ ) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0,0,100,100);
        button.tag = i;
        [button addTarget:self action:@selector(selectCard:) forControlEvents:UIControlEventTouchDown];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0];
            button.titleLabel.shadowOffset = CGSizeMake(1, 1);
        } else {
            button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:50.0];
            button.titleLabel.shadowOffset = CGSizeMake(2, 2);            
        }
        
        [self.view insertSubview:button belowSubview:_animationView];
        [_cardButtons addObject:button];
    }
}

- (void)arrangeButtons
{
    CGSize size = self.view.bounds.size;
    
    int xcount;
    int ycount;
    BOOL portrait = UIDeviceOrientationIsPortrait(_orientation);
    CGSize buttonSize;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if ( portrait ) {
            buttonSize = CGSizeMake(75, 100);
            xcount = 4;
            ycount = 4;
        } else {
            buttonSize = CGSizeMake(75, 95);            
            xcount = 5;
            ycount = 3;
            size.width -= 40;
        }        
    } else {
        if ( portrait ) {
            buttonSize = CGSizeMake(175, 230);
            xcount = 4;
            ycount = 4;
        } else {
            buttonSize = CGSizeMake(175, 230);            
            xcount = 5;
            ycount = 3;
            size.width -= 40;
        }        
    }

    for ( int i = 0; i < ycount; i++ ) {
        for ( int j = 0; j < xcount; j++ ) {
            if ( i * xcount + j >= _cardButtons.count )
                break;
            
            UIButton *button = [_cardButtons objectAtIndex:i * xcount + j];
            button.frame = CGRectMake((j + 0.5) * size.width / xcount - 0.5 * buttonSize.width, (i + 0.5) * size.height / ycount - 0.5 * buttonSize.height, buttonSize.width, buttonSize.height);
        }
    }
}


- (IBAction)setCurrentDeckIndex:(NSInteger)deckIndex
{
    if (_currentDeck != nil) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setInteger:deckIndex forKey:@"activeCardDeck"];
        [userDefaults synchronize];        
    }
    
    _currentDeck = [self.cardDecks deckByIndex:deckIndex];
    
    [self createButtons:_currentDeck.numberOfCards];
    [self arrangeButtons];
    
    for (UIButton *button in _cardButtons) {
        [button setTitleColor:self.currentCardBackground.textColor forState:UIControlStateNormal];
        [button setTitleColor:self.currentCardBackground.textColor forState:UIControlStateHighlighted];
        [button setTitleShadowColor:self.currentCardBackground.shadowColor forState:UIControlStateNormal];
        [button setTitleShadowColor:self.currentCardBackground.shadowColor forState:UIControlStateHighlighted];
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
    
    _orientation = [[UIApplication sharedApplication] statusBarOrientation];

    _cardButtons = [[NSMutableArray alloc] initWithCapacity:14];
    
    _animationView = [[UIView alloc] initWithFrame:self.view.bounds] ;
    _animationView.opaque = NO;
    _animationView.backgroundColor = [UIColor clearColor];
    _animationView.hidden = YES;
    _animationView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:_animationView];
    
	_frontLayer = [CALayer layer];
	_frontLayer.doubleSided = NO;
	_frontLayer.name = @"Front";
	[_frontLayer setMasksToBounds:YES];
    
	_backLayer = [CALayer layer];
	_backLayer.doubleSided = NO;
	_backLayer.name = @"Back";
	[_backLayer setMasksToBounds:YES];

    CGFloat zDistance = 1500.0f;
    CATransform3D perspective = CATransform3DIdentity; 
    perspective.m34 = -1. / zDistance;
    _frontLayer.transform = perspective;
    _backLayer.transform = perspective;
    
    [_animationView.layer addSublayer:_backLayer];
	[_animationView.layer addSublayer:_frontLayer];

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

    _currentFrame = self.view.frame;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [_cardDecks release];
    [_cardBackgrounds release];
    [_frontLayer release];
    [_backLayer release];
    [_cardButtons release];
    [_animationView release];
}

- (void)willAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration]; 
    _orientation = toInterfaceOrientation;
    [self arrangeButtons];
    [UIView commitAnimations];
}

- (void)willAnimateSecondHalfOfRotationFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration]; 
    [self arrangeButtons];
    [UIView commitAnimations];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    _currentFrame = self.view.frame;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
@end
