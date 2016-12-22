//
//  AttributedFrameModel.m
//  CoreText_Learn
//
//  Created by 綦 on 16/12/22.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "AttributedFrameModel.h"

@implementation AttributedFrameModel

+ (instancetype)attributedFrameModelWithDic:(NSDictionary *)dic
{
    return [self attributedFrameModelWithAttributedModel:[AttributedModel attributedModelWithDic:dic]];
}
+ (instancetype)attributedFrameModelWithAttributedModel:(AttributedModel *)model
{
    return [[self alloc] initWithAttributedModel:model];
}
- (instancetype)initWithAttributedModel:(AttributedModel *)model
{
    if (self = [super init]) {
        self.attributedModel = model;
    }
    
    return self;
}

- (void)setAttributedModel:(AttributedModel *)attributedModel
{
    if (attributedModel) {
        _attributedModel = attributedModel;
        
        CGFloat spacing = 8;
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGSize limitSize = CGSizeMake(screenWidth - 2*spacing, CGFLOAT_MAX);
        CGFloat Y = spacing;
        CGSize size = [attributedModel.title boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: Title_Font, NSForegroundColorAttributeName: Title_Color} context:nil].size;
        _titleRect = (CGRect){{spacing, Y}, size};
        
        Y = Y + size.height + spacing;
        size = [attributedModel.describe boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: Describe_Font, NSForegroundColorAttributeName: Describe_Color} context:nil].size;
        _describeRect = (CGRect){{spacing, Y}, size};
        
        Y = Y + size.height + spacing;
        NSRange range = NSMakeRange(0, 0);
        NSDictionary *attributes = [attributedModel.effectString attributesAtIndex:0 effectiveRange:&range];
        size = [attributedModel.effectString boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        _effectRect = (CGRect){{spacing, Y}, size};
        
        _cellHeight = Y + size.height + spacing;
    }
}

@end
