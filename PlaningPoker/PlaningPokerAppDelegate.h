//
//  PlaningPokerAppDelegate.h
//  PlaningPoker
//
//  Created by Junglas Bodo on 01.08.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#include "CardDeckViewController.h"

@interface PlaningPokerAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CardDeckViewController *cardDeckViewController;

@end
