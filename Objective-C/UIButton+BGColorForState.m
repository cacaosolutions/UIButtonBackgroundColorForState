//
//  UIButton+BGColorForState.m
//
//  Created by Tarun Tyagi on 07/10/16.
//  Copyright © 2016 Cacao Solutions. All rights reserved.
//

#import "UIButton+BGColorForState.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

#define KeyStateNormal       "StateNormal"
#define KeyStateHighlighted  "StateHighlighted"
#define KeyStateDisabled     "StateDisabled"
#define KeyStateSelected     "StateSelected"
#define KeyStateApplication  "StateApplication"
#define KeyStateReserved     "StateReserved"

@implementation UIButton (BGColorForState)


#pragma mark - Convenience

-(nullable UIColor *)backgroundColorForState:(UIControlState)state
{
    return (UIColor *)objc_getAssociatedObject(self, [self keyForControlState:state]);
}

-(void)setBackgroundColor:(nullable UIColor *)backgroundColor forState:(UIControlState)state
{
    objc_setAssociatedObject(self, [self keyForControlState:state],
                             nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, [self keyForControlState:state],
                             backgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - UIResponder Hooks

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self observeState];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self observeState];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self observeState];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    [self observeState];
}


#pragma mark - State Tracking

-(void)observeState
{
    self.backgroundColor = [self backgroundColorForState:self.state];
}


#pragma mark - Utility

-(const void *)keyForControlState:(UIControlState)state
{
    if((state & UIControlStateNormal) == UIControlStateNormal)
        return KeyStateNormal;
    
    else if((state & UIControlStateHighlighted) == UIControlStateHighlighted)
        return KeyStateHighlighted;
    
    else if((state & UIControlStateDisabled) == UIControlStateDisabled)
        return KeyStateDisabled;
    
    else if((state & UIControlStateSelected) == UIControlStateSelected)
        return KeyStateSelected;
    
    else if((state & UIControlStateApplication) == UIControlStateApplication)
        return KeyStateApplication;
    
    else if((state & UIControlStateReserved) == UIControlStateReserved)
        return KeyStateReserved;
    
    else
        return KeyStateNormal;
}


@end

NS_ASSUME_NONNULL_END
