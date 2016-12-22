//
//  AttributedModel.h
//  CoreText_Learn
//
//  Created by 綦 on 16/12/22.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttributedModel : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *describe;
@property (copy, nonatomic) NSAttributedString *effectString;

+ (instancetype)attributedModelWithDic:(NSDictionary *)dic;
- (instancetype)initWithDic:(NSDictionary *)dic;

@end
