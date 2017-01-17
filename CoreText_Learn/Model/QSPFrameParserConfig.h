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

@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *content;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat fontSize;
@property (assign, nonatomic) CGFloat lineSpace;
@property (strong, nonatomic) UIColor *textColor;
@property (assign, nonatomic) CGFloat firstLineHeadIndent;
@property (copy, nonatomic) NSString *imageName;
@property (assign, nonatomic) CGFloat imageWidth;
@property (assign, nonatomic) CGFloat imageHeight;

+ (QSPFrameParserConfig *)frameParserConfigWithDic:(NSDictionary *)dic;
- (QSPFrameParserConfig *)initWithDic:(NSDictionary *)dic;

@end
