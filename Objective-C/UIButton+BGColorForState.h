//
//  UIButton+BGColorForState.h
//
//  Created by Tarun Tyagi on 07/10/16.
//  Copyright © 2016 Cacao Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (BGColorForState)

-(nullable UIColor *)backgroundColorForState:(UIControlState)state NS_SWIFT_UNAVAILABLE("Use UIButton Swift extension instead");

-(void)setBackgroundColor:(nullable UIColor *)backgroundColor forState:(UIControlState)state NS_SWIFT_UNAVAILABLE("Use UIButton Swift extension instead");

@end

NS_ASSUME_NONNULL_END
