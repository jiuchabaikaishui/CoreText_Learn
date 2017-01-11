//
//  AttributedFrameModel.m
//  CoreText_Learn
//
//  Created by 綦 on 16/12/22.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "AttributedFrameModel.h"
#import "AttributedViewController.h"

#define Default_Font                    [UIFont systemFontOfSize:14]

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
        NSDictionary *attributes;
        while (range.location + range.length < attributedModel.effectString.length) {
            attributes = [attributedModel.effectString attributesAtIndex:range.location + range.length effectiveRange:&range];
            if (![attributes valueForKey:NSFontAttributeName]) {
                NSMutableDictionary *mAttributes = [[NSMutableDictionary alloc] initWithDictionary:attributes];
                [mAttributes setValue:Default_Font forKey:NSFontAttributeName];
                NSMutableAttributedString *maStr;
                if ([attributedModel.effectString isKindOfClass:[NSMutableAttributedString class]]) {
                    maStr = (NSMutableAttributedString *)attributedModel.effectString;
                }
                else
                {
                    maStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributedModel.effectString];
                }
                [maStr addAttributes:mAttributes range:range];
                attributedModel.effectString = maStr;
            }
        }
        size = [attributedModel.effectString boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        AttributedCell *cell = [AttributedCell attributedCellWithAttributedFrameModel:self andTableView:nil];
        _effectRect = (CGRect){{spacing, Y}, [cell.effectTextView sizeThatFits:limitSize]};
        
        _cellHeight = Y + _effectRect.size.height + spacing;
    }
}

@end
