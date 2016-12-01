//
//  UIView+frameAdjust.m
//  CoreText_Learn
//
//  Created by 綦 on 16/11/30.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "UIView+frameAdjust.h"

@implementation UIView (frameAdjust)

- (CGPoint)frameOrigin
{
    return self.frame.origin;
}
- (void)setFrameOrigin:(CGPoint)frameOrigin
{
    self.frame = CGRectMake(frameOrigin.x, frameOrigin.y, self.frame.size.width, self.frame.size.height);
}

- (CGSize)frameSize
{
    return self.frame.size;
}
- (void)setFrameSize:(CGSize)frameSize
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, frameSize.width, frameSize.height);
}

- (CGFloat)frameX
{
    return self.frame.origin.x;
}
- (void)setFrameX:(CGFloat)frameX
{
    self.frame = CGRectMake(frameX, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameY
{
    return self.frame.origin.y;
}
- (void)setFrameY:(CGFloat)frameY
{
    self.frame = CGRectMake(self.frame.origin.x, frameY, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameWidth
{
    return self.frame.size.width;
}
- (void)setFrameWidth:(CGFloat)frameWidth
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, frameWidth, self.frame.size.height);
}

- (CGFloat)frameHeight
{
    return self.frame.size.height;
}
- (void)setFrameHeight:(CGFloat)frameHeight
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, frameHeight);
}

- (CGFloat)frameRight
{
    return self.frame.origin.x + self.frame.size.width;
}
//- (void)setFrameRight:(CGFloat)frameRight
//{
//    
//}
- (CGFloat)frameBottom
{
    return self.frame.origin.y + self.frame.size.height;
}
//- (void)setFrameBottom:(CGFloat)frameBottom
//{
//    
//}

@end
