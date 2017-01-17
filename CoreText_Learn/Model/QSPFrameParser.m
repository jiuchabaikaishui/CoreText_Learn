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
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:1];
    NSAttributedString *content = [self loadTemplateFile:path with:width andImageArray:imageArray];
    CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)content);
    
    CGSize limitSize = CGSizeMake(width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetterRef, CFRangeMake(0, 0), NULL, limitSize, NULL);
    CGFloat textHeight = coreTextSize.height;
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathAddRect(pathRef, nil, CGRectMake(0, 0, coreTextSize.width, coreTextSize.height));
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetterRef, CFRangeMake(0, 0), pathRef, NULL);
    
    CoretextData *coretextData = [[CoretextData alloc] init];
    coretextData.imageArray = imageArray;
    coretextData.frameRef = frameRef;
    coretextData.height = textHeight;
    
    CFRelease(frameRef);
    CFRelease(pathRef);
    CFRelease(framesetterRef);
    
    return coretextData;
}
+ (NSAttributedString *)loadTemplateFile:(NSString *)path with:(CGFloat)width andImageArray:(NSMutableArray *)imageArray
{
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSMutableAttributedString *resultStr = [[NSMutableAttributedString alloc] init];
    if (data) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if ([arr isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in arr) {
                QSPFrameParserConfig *config = [QSPFrameParserConfig frameParserConfigWithDic:dic];
                config.width = width;
                
                if ([config.type isEqualToString:@"image"]) {
                    CoreTextImageData *imageData = [[CoreTextImageData alloc] init];
                    imageData.position = resultStr.length;
                    imageData.imageName = config.imageName;
                    [imageArray addObject:imageData];
                }
                
                NSAttributedString *mStr = [self parseAttributedFromConfig:config andWith:width];
                [resultStr appendAttributedString:mStr];
            }
        }
    }
    
    return resultStr;
}
static CGFloat delegateAscentCallback( void * refCon )
{
    QSPFrameParserConfig *config = (__bridge QSPFrameParserConfig *)refCon;
    return config.imageHeight;
}
static CGFloat delegateDescentCallback( void * refCon )
{
    return 0;
}
static CGFloat delegateWidthCallback( void * refCon )
{
    QSPFrameParserConfig *config = (__bridge QSPFrameParserConfig *)refCon;
    return config.imageWidth;
}
+ (NSAttributedString *)parseAttributedFromConfig:(QSPFrameParserConfig *)config andWith:(CGFloat)width
{
    NSAttributedString *resultStr = nil;
    
    if ([config.type isEqualToString:@"image"]) {
        CTRunDelegateCallbacks callbacks;
        callbacks.version = kCTRunDelegateVersion1;
        callbacks.getAscent = delegateAscentCallback;
        callbacks.getDescent = delegateDescentCallback;
        callbacks.getWidth = delegateWidthCallback;
        
        CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge void *)config);
        
        //设置占位符
        unichar replaceChar = 0xFFFC;
        NSString *content = [NSString stringWithCharacters:&replaceChar length:1];
        NSDictionary *attributes = [self attributesWithConfig:config];
        NSMutableAttributedString *space = [[NSMutableAttributedString alloc] initWithString:content attributes:attributes];
        CFAttributedStringSetAttribute((__bridge CFMutableAttributedStringRef)space, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
        
        //释放资源
        CFRelease(delegate);
        
        resultStr = space;
    }
    else if ([config.type isEqualToString:@"text"])
    {
        if (![self isBlankString:config.content]) {
            NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithCapacity:1];
            if (config.textColor) {
                [attributes setValue:config.textColor forKey:NSForegroundColorAttributeName];
            }
            if (config.fontSize > 0) {
                [attributes setValue:[UIFont systemFontOfSize:config.fontSize] forKey:NSFontAttributeName];
            }
            if (config.lineSpace > 0 || config.firstLineHeadIndent > 0) {
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                if (config.lineSpace > 0) {
                    paragraphStyle.lineSpacing = config.lineSpace;
                }
                if (config.firstLineHeadIndent > 0) {
                    paragraphStyle.firstLineHeadIndent = config.firstLineHeadIndent;
                }
                [attributes setValue:paragraphStyle forKey:NSParagraphStyleAttributeName];
            }
            
            resultStr = [[NSAttributedString alloc] initWithString:config.content attributes:attributes];
        }
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

+ (CoretextData *)parseConfig:(QSPFrameParserConfig *)config
{
    NSDictionary *dic = [self attributesWithConfig:config];
    NSAttributedString *aStr = [[NSAttributedString alloc] initWithString:config.content attributes:dic];
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

@end
