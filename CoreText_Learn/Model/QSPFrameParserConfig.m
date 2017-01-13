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
        self.lineSpace = Default_With;
        self.fontSize = Default_LineSpace;
        self.textColor = Default_TextColor;
    }
    
    return self;
}

@end
