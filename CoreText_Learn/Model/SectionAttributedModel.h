//
//  SectionAttributedModel.h
//  CoreText_Learn
//
//  Created by 綦 on 17/1/5.
//  Copyright © 2017年 PowesunHolding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AttributedFrameModel.h"

@interface SectionAttributedModel : NSObject

@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray *items;

+ (instancetype)sectionAttributedModelWithDic:(NSDictionary *)dic;
- (instancetype)initWithDic:(NSDictionary *)dic;

@end
