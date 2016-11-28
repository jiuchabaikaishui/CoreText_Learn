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
    
    //step1:获取当前图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //step2:矩阵变换，由于CoreGraphs的坐标系在左下角，把坐标系变换到左上角
    //还原矩阵
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    //矩阵向上平移一个高度
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    //矩阵y方向缩放-1倍
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //step3:创建并设置路径
    //创建路径
    CGMutablePathRef path = CGPathCreateMutable();
    //添加矩形到路径中
    CGPathAddRect(path, NULL, self.bounds);
    
    //step4:
    //创建富文本
    NSAttributedString *aStr = [[NSAttributedString alloc] initWithString:@"Hello"];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)aStr);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, aStr.length), path, NULL);
    
    //step5:绘制
    CTFrameDraw(frame, context);
    
    //step6:释放资源
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
}

@end
