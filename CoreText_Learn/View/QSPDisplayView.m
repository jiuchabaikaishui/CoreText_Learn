//
//  QSPDisplayView.m
//  CoreText_Learn
//
//  Created by 綦 on 16/11/28.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "QSPDisplayView.h"
#import <CoreText/CoreText.h>

@implementation QSPDisplayView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
//    NSString *str = @"就是这样";
//    [str drawAtPoint:CGPointMake(0, 0) withAttributes:nil];
    //step1:获取当前图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    //step3:创建并设置路径，即绘制的区域
    //创建路径
    CGMutablePathRef path = CGPathCreateMutable();
    //添加矩形到路径中
    CGPathMoveToPoint(path, NULL, 0, 10);
    CGPathAddLineToPoint(path, NULL, 0, self.bounds.size.height);
    CGPathAddLineToPoint(path, NULL, self.bounds.size.width, self.bounds.size.height);
    CGPathCloseSubpath(path);
//    CGPathAddEllipseInRect(path, NULL, CGRectMake(0, 10, self.frame.size.width, self.frame.size.height - 10));
    
    //step2:矩阵变换，由于CoreGraphs的坐标系在左下角，把坐标系变换到左上角
    //还原矩阵
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    //矩阵向上平移一个高度
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    //矩阵y方向缩放-1倍
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //step4:
    //创建富文本
    NSAttributedString *aStr = [[NSAttributedString alloc] initWithString:@"Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货Hello粉红色的就爱上对方啥地方哈萨克好地方开始的海景房卡死啦好地方收到回复上空间和对方收到货"];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)aStr);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, aStr.length), path, NULL);
    
    //step5:绘制
    CTFrameDraw(frame, context);
    
    CGContextRestoreGState(context);
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    
    //step6:释放资源
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
}

@end
