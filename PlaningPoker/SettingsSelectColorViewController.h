//
//  SettingsSelectColorViewController.h
//  PlaningPoker
//
//  Created by Junglas Bodo on 02.08.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardBackgrounds.h"

@class SettingsSelectColorViewController;
@protocol SettingsViewControllerDelegate;

@protocol SettingsSelectColorViewControllerDelegate
- (void)settingsSelectColorFinished:(SettingsSelectColorViewController *)controller;
@end

@interface SettingsSelectColorViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    @private
    NSInteger selectedBackgroundIndex;
}

@property (nonatomic, assign) id <SettingsSelectColorViewControllerDelegate> delegate;
@property (nonatomic, assign) id <SettingsViewControllerDelegate> settingsDelegate;

- (IBAction)done;

@end
