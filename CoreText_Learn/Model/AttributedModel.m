//
//  AttributedModel.m
//  CoreText_Learn
//
//  Created by 綦 on 16/12/22.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "AttributedModel.h"

@implementation AttributedModel

+ (instancetype)attributedModelWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.title = dic[@"title"];
        self.describe = dic[@"describe"];
        self.effectString = dic[@"effectString"];
    }
    
    return self;
}

@end
