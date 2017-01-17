//
//  CoretextData.h
//  CoreText_Learn
//
//  Created by 綦 on 16/12/1.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface CoretextData : NSObject

@property (assign, nonatomic) CTFrameRef frameRef;
@property (assign, nonatomic) CGFloat height;
@property (strong, nonatomic) NSArray *imageArray;

@end


@interface CoreTextImageData : NSObject

@property (copy, nonatomic) NSString *imageName;
@property (assign, nonatomic) NSInteger position;
@property (assign, nonatomic) CGRect imageRect;

@end
