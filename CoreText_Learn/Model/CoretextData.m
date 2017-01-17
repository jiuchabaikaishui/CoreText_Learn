//
//  CoretextData.m
//  CoreText_Learn
//
//  Created by 綦 on 16/12/1.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "CoretextData.h"

@implementation CoretextData

- (void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    [self setFillImagePosition];
}

- (void)setFillImagePosition
{
    if (self.imageArray.count == 0) {
        return;
    }
    else
    {
        NSArray *lines = (__bridge NSArray *)CTFrameGetLines(self.frameRef);
        
        int lineCount = lines.count;
        CGPoint lineOrigins[lineCount];
        CTFrameGetLineOrigins(self.frameRef, CFRangeMake(0, 0), lineOrigins);
        
        int imageIndex = 0;
        CoreTextImageData *imageData = self.imageArray[imageIndex];
        
        for (int index = 0; index < lineCount; index++) {
            if (imageData == nil) {
                break;
            }
            
            CTLineRef lineRef = (__bridge CTLineRef)lines[index];
            NSArray *runArray = (__bridge NSArray *)CTLineGetGlyphRuns(lineRef);
            for (id runObj in runArray) {
                CTRunRef run = (__bridge CTRunRef)runObj;
                NSDictionary *runAttributes = (__bridge NSDictionary *)CTRunGetAttributes(run);
                CTRunDelegateRef delegateRef = (__bridge CTRunDelegateRef)[runAttributes valueForKey:(__bridge NSString *)kCTRunDelegateAttributeName];
                
                if (delegateRef == nil) {
                    continue;
                }
                else
                {
                    CGRect runBounds;
                    CGFloat ascent;
                    CGFloat descent;
                    runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
                    runBounds.size.height = ascent + descent;
                    
                    CGFloat xOffset = CTLineGetOffsetForStringIndex(lineRef, CTRunGetStringRange(run).location, NULL);
                    runBounds.origin.x = lineOrigins[index].x + xOffset;
                    runBounds.origin.y = lineOrigins[index].y - descent;
                    
                    CGPathRef pathRef = CTFrameGetPath(self.frameRef);
                    CGRect rolRect = CGPathGetBoundingBox(pathRef);
                    
                    CGRect delegateBounds = CGRectOffset(runBounds, rolRect.origin.x, rolRect.origin.y);
                    
                    imageData.imageRect = delegateBounds;
                    imageIndex++;
                    if (imageIndex == self.imageArray.count) {
                        imageData = nil;
                        break;
                    }
                    else
                    {
                        imageData = self.imageArray[imageIndex];
                    }
                }
            }
        }
    }
}
- (void)setFrameRef:(CTFrameRef)frameRef
{
    if (_frameRef != frameRef && _frameRef != NULL) {
        CFRelease(_frameRef);
    }
    
    _frameRef = CFRetain(frameRef);
}

- (void)dealloc
{
    if (_frameRef != NULL) {
        CFRelease(_frameRef);
        _frameRef = nil;
    }
}

@end



@implementation CoreTextImageData

@end
