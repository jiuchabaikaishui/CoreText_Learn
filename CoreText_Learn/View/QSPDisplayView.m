//
//  QSPDisplayView.m
//  CoreText_Learn
//
//  Created by 綦 on 16/11/28.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "QSPDisplayView.h"
#import <CoreText/CoreText.h>

@interface QSPDisplayView ()

@end

@implementation QSPDisplayView

- (void)setCoretextData:(CoretextData *)coretextData
{
    if (coretextData) {
        _coretextData = coretextData;
        
        [self setNeedsLayout];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.coretextData) {
        //step1:获取当前图形上下文
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //step2:矩阵变换，由于CoreGraphs的坐标系在左下角，把坐标系变换到左上角
        //还原矩阵
        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
        //矩阵向上平移一个高度
//        CGContextTranslateCTM(context, 0, self.bounds.size.height);
        CGContextTranslateCTM(context, 0, self.coretextData.height);
        //矩阵y方向缩放-1倍
        CGContextScaleCTM(context, 1.0, -1.0);
        
        CTFrameDraw(self.coretextData.frameRef, context);
    }
    else
    {
        DebugLog(@"%@", NSStringFromCGRect([UIScreen mainScreen].bounds));
        DebugLog(@"%@", NSStringFromCGRect(self.bounds));
        DebugLog(@"%@", NSStringFromCGRect(self.frame));
        //step1:获取当前图形上下文
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //step3:创建并设置路径，即绘制的区域
        //创建路径
        CGMutablePathRef pathRef = CGPathCreateMutable();
        //添加矩形到路径中
        CGPathMoveToPoint(pathRef, NULL, 10, 10);
        CGPathAddLineToPoint(pathRef, NULL, 10, self.bounds.size.height - 10);
        CGPathAddLineToPoint(pathRef, NULL, self.bounds.size.width - 10, self.bounds.size.height - 10);
        CGPathAddLineToPoint(pathRef, NULL, self.bounds.size.width - 10, 10);
        
        //step4:
        //创建富文本
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        //style.lineBreakMode = NSLineBreakByTruncatingMiddle;
        NSAttributedString *aStr = [[NSAttributedString alloc] initWithString:@"Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方" attributes:@{NSParagraphStyleAttributeName:style}];//收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货
        CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)aStr);
        CTFrameRef frameRef = CTFramesetterCreateFrame(framesetterRef, CFRangeMake(0, aStr.length), pathRef, NULL);
        CGPathCloseSubpath(pathRef);
        
        //step2:矩阵变换，由于CoreGraphs的坐标系在左下角，把坐标系变换到左上角
        //还原矩阵
        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
        //矩阵向上平移一个高度
        CGContextTranslateCTM(context, 0, self.bounds.size.height);
        //矩阵y方向缩放-1倍
        CGContextScaleCTM(context, 1.0, -1.0);
        
        CGContextAddPath(context, pathRef);
        CGContextStrokePath(context);
        
        //step5:绘制
        CTFrameDraw(frameRef, context);

        //step6:释放资源
        CFRelease(frameRef);
        CFRelease(framesetterRef);
        CFRelease(pathRef);
    }
}

@end
