//
//  AttributedFrameModel.h
//  CoreText_Learn
//
//  Created by 綦 on 16/12/22.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AttributedModel.h"

#define Title_Font              [UIFont systemFontOfSize:15]
#define Describe_Font           [UIFont systemFontOfSize:14]
#define Effect_Font             [UIFont systemFontOfSize:14]
#define Title_Color             [UIColor colorWithRed:0 green:0 blue:0 alpha:1]
#define Describe_Color          [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1]

@interface AttributedFrameModel : NSObject

@property (assign, nonatomic, readonly)CGRect titleRect;
@property (assign, nonatomic, readonly)CGRect describeRect;
@property (assign, nonatomic, readonly)CGRect effectRect;
@property (assign, nonatomic, readonly)CGFloat cellHeight;
@property (strong, nonatomic) AttributedModel *attributedModel;

+ (instancetype)attributedFrameModelWithDic:(NSDictionary *)dic;
+ (instancetype)attributedFrameModelWithAttributedModel:(AttributedModel *)model;
- (instancetype)initWithAttributedModel:(AttributedModel *)model;

@end
