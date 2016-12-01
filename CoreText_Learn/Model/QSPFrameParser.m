//
//  QSPFrameParser.m
//  CoreText_Learn
//
//  Created by 綦 on 16/12/1.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "QSPFrameParser.h"

@implementation QSPFrameParser

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
+ (CoretextData *)parseContent:(NSString *)content config:(QSPFrameParserConfig *)config
{
    NSDictionary *dic = [self attributesWithConfig:config];
    NSAttributedString *aStr = [[NSAttributedString alloc] initWithString:content attributes:dic];
    
    //创建CTFramesetterRef是例
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

@end
