//
//  CardBackground.h
//  PlaningPoker
//
//  Created by Junglas Bodo on 12.08.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CardBackground

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) UIColor *textColor;

- (UIImage *) normal:(CGSize) size;
- (UIImage *) hidden:(CGSize) size;

@end
