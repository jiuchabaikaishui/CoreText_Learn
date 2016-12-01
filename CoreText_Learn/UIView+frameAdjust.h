//
//  UIView+frameAdjust.h
//  CoreText_Learn
//
//  Created by 綦 on 16/11/30.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (frameAdjust)

@property (assign, nonatomic) CGPoint frameOrigin;
@property (assign, nonatomic) CGSize frameSize;

@property (assign, nonatomic) CGFloat frameX;
@property (assign, nonatomic) CGFloat frameY;

@property (assign, nonatomic) CGFloat frameWidth;
@property (assign, nonatomic) CGFloat frameHeight;

@property (assign, nonatomic, readonly) CGFloat frameRight;
@property (assign, nonatomic, readonly) CGFloat frameBottom;

@end
