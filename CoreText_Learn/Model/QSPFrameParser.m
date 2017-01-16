//
//  QSPFrameParser.m
//  CoreText_Learn
//
//  Created by 綦 on 16/12/1.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "QSPFrameParser.h"

@implementation QSPFrameParser

+ (CoretextData *)parseAttributedTemplateFile:(NSString *)path andWith:(CGFloat)width
{
    NSAttributedString *content = [self loadTemplateFile:path andWith:width];
    CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)content);
    
    CGSize limitSize = CGSizeMake(width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetterRef, CFRangeMake(0, 0), NULL, limitSize, NULL);
    CGFloat textHeight = coreTextSize.height;
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathAddRect(pathRef, nil, CGRectMake(0, 0, coreTextSize.width, coreTextSize.height));
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetterRef, CFRangeMake(0, 0), pathRef, NULL);
    
    CoretextData *coretextData = [[CoretextData alloc] init];
    coretextData.frameRef = frameRef;
    coretextData.height = textHeight;
    
    CFRelease(frameRef);
    CFRelease(pathRef);
    CFRelease(framesetterRef);
    
    return coretextData;
}
+ (NSAttributedString *)loadTemplateFile:(NSString *)path andWith:(CGFloat)width
{
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@", str);
    NSMutableAttributedString *resultStr = [[NSMutableAttributedString alloc] init];
    if (data) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if ([arr isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in arr) {
                NSAttributedString *mStr = [self parseAttributedFromNSDictionary:dic andWith:width];
                [resultStr appendAttributedString:mStr];
            }
        }
    }
    
    return resultStr;
}
+ (NSAttributedString *)parseAttributedFromNSDictionary:(NSDictionary *)dic andWith:(CGFloat)width
{
    NSAttributedString *resultStr = nil;
    
    if ([self isBlankString:dic[@"content"]]) {
        NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithCapacity:1];
        UIColor *color = [self colorWithString:dic[@"color"]];
        if (color) {
            [attributes setValue:color forKey:NSForegroundColorAttributeName];
        }
        if (dic[@"size"] > 0) {
            [attributes setValue:[UIFont systemFontOfSize:[dic[@"size"] floatValue]] forKey:NSFontAttributeName];
        }
        
        resultStr = [[NSAttributedString alloc] initWithString:dic[@"content"] attributes:attributes];
    }
    
    return resultStr;
}
//判空
+ (BOOL)isBlankString:(NSString *)string
{
    if (string == nil || string == NULL)
        return YES;
    
    if ([string isKindOfClass:[NSNull class]])
        return YES;
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
        return YES;
    
    return NO;
}

+ (CoretextData *)parseContent:(NSString *)content config:(QSPFrameParserConfig *)config
{
    NSDictionary *dic = [self attributesWithConfig:config];
    NSAttributedString *aStr = [[NSAttributedString alloc] initWithString:content attributes:dic];
    //创建CTFramesetterRef示例
    CTFramesetterRef setterRef = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)aStr);
    
    //获取需要绘制的区域高度
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coretextSize = CTFramesetterSuggestFrameSizeWithConstraints(setterRef, CFRangeMake(0, 0), nil, restrictSize, nil);
    CGFloat textHeight = coretextSize.height;
    
    //生成CTFrameRef
    CTFrameRef frameRef = [self creatFrameWithFrameSetter:setterRef config:config height:textHeight];
    
    CoretextData *data = [[CoretextData alloc] init];
    data.frameRef = frameRef;
    data.height = textHeight;
    
    //释放内存
    CFRelease(setterRef);
    CFRelease(frameRef);
    
    return data;
}
+ (NSDictionary *)attributesWithConfig:(QSPFrameParserConfig *)config
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:(__bridge id)config.textColor.CGColor forKey:(__bridge NSString *)kCTForegroundColorAttributeName];
    
    CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)@"", config.fontSize, NULL);
    [dic setObject:(__bridge id)fontRef forKey:(__bridge NSString *)kCTFontAttributeName];
    CFRelease(fontRef);
    
    CGFloat lineSpace = config.lineSpace;
    const CFIndex numberOfSettings = 3;
    CTParagraphStyleSetting styleSetting[numberOfSettings] = {
        {kCTParagraphStyleSpecifierLineSpacing, sizeof(CGFloat), &lineSpace},
        {kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpace},
        {kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpace}
    };
    CTParagraphStyleRef styleRef = CTParagraphStyleCreate(styleSetting, numberOfSettings);
    [dic setObject:(__bridge id)styleRef forKey:(__bridge NSString *)kCTParagraphStyleAttributeName];
    CFRelease(styleRef);
    
    return dic;
}
+ (CTFrameRef)creatFrameWithFrameSetter:(CTFramesetterRef)setterRef config:(QSPFrameParserConfig *)config height:(CGFloat)height
{
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathAddRect(pathRef, NULL, CGRectMake(0, 0, config.width, height));
    CTFrameRef frameRef = CTFramesetterCreateFrame(setterRef, CFRangeMake(0, 0), pathRef, NULL);
    CFRelease(pathRef);
    return frameRef;
}

+ (UIColor *)colorWithString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1];
}
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
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
