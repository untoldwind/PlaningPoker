//
//  CAHelper.m
//  PlaningPoker
//
//  Created by Junglas Bodo on 15.08.11.
//  Copyright 2011 ObjectCode GmbH. All rights reserved.
//

#import "CAHelper.h"

CAAnimation *CAHFlipResizeAnimation(NSTimeInterval duration, CGFloat yRotationStart, CGFloat yRotationEnd, CGFloat zRotationStart, CGFloat zRotationEnd, CGRect beginRect, CGRect endRect)
{    
    // Rotating halfway (pi radians) around the Y axis gives the appearance of flipping
    CABasicAnimation *flipAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    flipAnimation.fromValue = [NSNumber numberWithDouble:yRotationStart];
    flipAnimation.toValue = [NSNumber numberWithDouble:yRotationEnd];

    CABasicAnimation *flipAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    flipAnimation2.fromValue = [NSNumber numberWithDouble:zRotationStart];
    flipAnimation2.toValue = [NSNumber numberWithDouble:zRotationEnd];
    
    CABasicAnimation *resizeXAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    resizeXAnimation.fromValue = [NSNumber numberWithDouble:beginRect.origin.x + beginRect.size.width / 2];
    resizeXAnimation.toValue = [NSNumber numberWithDouble:endRect.origin.x + endRect.size.width / 2];

    CABasicAnimation *resizeYAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    resizeYAnimation.fromValue = [NSNumber numberWithDouble:beginRect.origin.y + beginRect.size.height / 2];
    resizeYAnimation.toValue = [NSNumber numberWithDouble:endRect.origin.y + endRect.size.height / 2];

    CABasicAnimation *resizeWidthAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    resizeWidthAnimation.fromValue = [NSNumber numberWithDouble:beginRect.size.width];
    resizeWidthAnimation.toValue = [NSNumber numberWithDouble:zRotationEnd > 0.0 ? endRect.size.height : endRect.size.width];

    CABasicAnimation *resizeHeightAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size.height"];
    resizeHeightAnimation.fromValue = [NSNumber numberWithDouble:beginRect.size.height];
    resizeHeightAnimation.toValue = [NSNumber numberWithDouble:zRotationEnd > 0.0 ? endRect.size.width : endRect.size.height];

    // Combine the flipping and shrinking into one smooth animation
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:flipAnimation, flipAnimation2, resizeXAnimation, resizeYAnimation, resizeWidthAnimation, resizeHeightAnimation, nil];
    
    // As the edge gets closer to us, it appears to move faster. Simulate this in 2D with an easing function
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationGroup.duration = duration;
    
    // Hold the view in the state reached by the animation until we can fix it, or else we get an annoying flicker
	// this really means keep the state of the object at whatever the anim ends at
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    
    return animationGroup;
}

CAAnimation *CAHResizeAnimation(NSTimeInterval duration, CGRect beginRect, CGRect endRect)
{
    CABasicAnimation *resizeXAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    resizeXAnimation.fromValue = [NSNumber numberWithDouble:beginRect.origin.x + beginRect.size.width / 2];
    resizeXAnimation.toValue = [NSNumber numberWithDouble:endRect.origin.x + endRect.size.width / 2];
    
    CABasicAnimation *resizeYAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    resizeYAnimation.fromValue = [NSNumber numberWithDouble:beginRect.origin.y + beginRect.size.height / 2];
    resizeYAnimation.toValue = [NSNumber numberWithDouble:endRect.origin.y + endRect.size.height / 2];
    
    CABasicAnimation *resizeWidthAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    resizeWidthAnimation.fromValue = [NSNumber numberWithDouble:beginRect.size.width];
    resizeWidthAnimation.toValue = [NSNumber numberWithDouble:endRect.size.width];
    
    CABasicAnimation *resizeHeightAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size.height"];
    resizeHeightAnimation.fromValue = [NSNumber numberWithDouble:beginRect.size.height];
    resizeHeightAnimation.toValue = [NSNumber numberWithDouble:endRect.size.height];
    
    // Combine the flipping and shrinking into one smooth animation
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:resizeXAnimation, resizeYAnimation, resizeWidthAnimation, resizeHeightAnimation, nil];
    
    // As the edge gets closer to us, it appears to move faster. Simulate this in 2D with an easing function
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationGroup.duration = duration;
    
    // Hold the view in the state reached by the animation until we can fix it, or else we get an annoying flicker
	// this really means keep the state of the object at whatever the anim ends at
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    
    return animationGroup;    
}