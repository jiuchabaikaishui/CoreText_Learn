//
//  SectionAttributedModel.m
//  CoreText_Learn
//
//  Created by 綦 on 17/1/5.
//  Copyright © 2017年 PowesunHolding. All rights reserved.
//

#import "SectionAttributedModel.h"

@implementation SectionAttributedModel

+ (instancetype)sectionAttributedModelWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        if (dic) {
            self.title = dic[@"title"];
            NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:1];
            for (NSDictionary *theDic in dic[@"items"]) {
                [mArr addObject:[AttributedFrameModel attributedFrameModelWithDic:theDic]];
            }
            self.items = mArr;
        }
    }
    
    return self;
}

@end
