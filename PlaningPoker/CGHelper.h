//
//  CGHelper.h
//  PlaningPoker
//
//  Created by Junglas Bodo on 12.08.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

CGPathRef CGHRoundedRectPath(CGRect rect, CGFloat cornerRadius);
CGPathRef CGHRoundedRectPathWithCutEdge(CGRect rect, CGFloat cornerRadius, CGFloat cutSize);
CGPathRef CGHTriangle(CGPoint p1, CGPoint p2, CGPoint p3);
