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

+ (QSPFrameParserConfig *)frameParserConfigWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}
- (QSPFrameParserConfig *)initWithDic:(NSDictionary *)dic
{
    if (self = [self init]) {
        if (dic) {
            self.type = dic[@"type"];
            if ([self.type isEqualToString:@"text"]) {
                self.content = dic[@"content"];
                self.width = [dic[@"width"] floatValue];
                self.lineSpace = [dic[@"lineSpace"] floatValue];
                self.fontSize = [dic[@"size"] floatValue];
                self.textColor = [self isBlankString:dic[@"color"]] ? Default_TextColor : [self colorWithString:dic[@"color"]];
                self.firstLineHeadIndent = [dic[@"firstLineHeadIndent"] floatValue];
            }
            else if ([self.type isEqualToString:@"image"])
            {
                self.imageName = dic[@"imageName"];
                self.imageWidth = [dic[@"imageWidth"] floatValue];
                self.imageHeight = [dic[@"imageHeight"] floatValue];
            }
        }
    }
    
    return self;
}

//判空
- (BOOL)isBlankString:(NSString *)string
{
    if (string == nil || string == NULL)
        return YES;
    
    if ([string isKindOfClass:[NSNull class]])
        return YES;
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
        return YES;
    
    return NO;
}
- (UIColor *)colorWithString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1];
}
- (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

@end
