//
//  CoretextData.m
//  CoreText_Learn
//
//  Created by 綦 on 16/12/1.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "CoretextData.h"

@implementation CoretextData

- (void)setFrameRef:(CTFrameRef)frameRef
{
    if (_frameRef != frameRef && _frameRef != NULL) {
        CFRelease(_frameRef);
    }
    
    _frameRef = CFRetain(frameRef);
}

- (void)dealloc
{
    if (_frameRef != NULL) {
        CFRelease(_frameRef);
        _frameRef = nil;
    }
}

@end
