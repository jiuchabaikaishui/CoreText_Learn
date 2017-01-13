//
//  QSPFramePaserConfig.h
//  CoreText_Learn
//
//  Created by 綦 on 16/12/1.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Default_With                    200.0f
#define Default_LineSpace               8.0f
#define Default_FontSize                16.0f
#define Default_TextColor               Color_RGB(108, 108, 108)

@interface QSPFrameParserConfig : NSObject

@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat fontSize;
@property (assign, nonatomic) CGFloat lineSpace;
@property (strong, nonatomic) UIColor *textColor;

@end
