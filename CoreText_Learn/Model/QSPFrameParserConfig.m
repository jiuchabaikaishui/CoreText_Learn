//
//  QSPFramePaserConfig.m
//  CoreText_Learn
//
//  Created by 綦 on 16/12/1.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "QSPFrameParserConfig.h"

@implementation QSPFrameParserConfig

- (instancetype)init
{
    if (self = [super init]) {
        self.width = 200.0f;
        self.lineSpace = 8.0f;
        self.fontSize = 16.0f;
        self.textColor = Color_RGB(108, 108, 108);
    }
    
    return self;
}

@end
