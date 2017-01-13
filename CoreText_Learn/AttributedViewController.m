//
//  AttributeViewController.m
//  CoreText_Learn
//
//  Created by 綦 on 16/12/22.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "AttributedViewController.h"

@interface AttributedViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArr;

@end

@implementation AttributedViewController

- (NSArray *)dataArr
{
    if (_dataArr == nil) {
        /*
            NSFontAttributeName                设置字体属性，默认值：字体：Helvetica(Neue) 字号：12
            NSForegroundColorAttributeNam      设置字体颜色，取值为 UIColor对象，默认值为黑色
            NSBackgroundColorAttributeName     设置字体所在区域背景颜色，取值为 UIColor对象，默认值为nil, 透明色
            NSLigatureAttributeName            设置连体属性，取值为NSNumber 对象(整数)，0 表示没有连体字符，1 表示使用默认的连体字符
            NSKernAttributeName                设定字符间距，取值为 NSNumber 对象（整数），正值间距加宽，负值间距变窄
            NSStrikethroughStyleAttributeName  设置删除线，取值为 NSNumber 对象（整数）
            NSStrikethroughColorAttributeName  设置删除线颜色，取值为 UIColor 对象，默认值为黑色
            NSUnderlineStyleAttributeName      设置下划线，取值为 NSNumber 对象（整数），枚举常量 NSUnderlineStyle中的值，与删除线类似
            NSUnderlineColorAttributeName      设置下划线颜色，取值为 UIColor 对象，默认值为黑色
            NSStrokeWidthAttributeName         设置笔画宽度，取值为 NSNumber 对象（整数），负值填充效果，正值中空效果
            NSStrokeColorAttributeName         填充部分颜色，不是字体颜色，取值为 UIColor 对象
            NSShadowAttributeName              设置阴影属性，取值为 NSShadow 对象
            NSTextEffectAttributeName          设置文本特殊效果，取值为 NSString 对象，目前只有图版印刷效果可用：
            NSBaselineOffsetAttributeName      设置基线偏移值，取值为 NSNumber （float）,正值上偏，负值下偏
            NSObliquenessAttributeName         设置字形倾斜度，取值为 NSNumber （float）,正值右倾，负值左倾
            NSExpansionAttributeName           设置文本横向拉伸属性，取值为 NSNumber （float）,正值横向拉伸文本，负值横向压缩文本
            NSWritingDirectionAttributeName    设置文字书写方向，从左向右书写或者从右向左书写
            NSVerticalGlyphFormAttributeName   设置文字排版方向，取值为 NSNumber 对象(整数)，0 表示横排文本，1 表示竖排文本
            NSLinkAttributeName                设置链接属性，点击后调用浏览器打开指定URL地址
            NSAttachmentAttributeName          设置文本附件,取值为NSTextAttachment对象,常用于文字图片混排  
            NSParagraphStyleAttributeName      设置文本段落排版格式，取值为 NSParagraphStyle 对象
         
         
            lineSpacing 字体的行间距
            firstLineHeadIndent  首行缩进
            alignment （两端对齐的）文本对齐方式：（左，中，右，两端对齐，自然）
            lineBreakMode 结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
            headIndent 整体缩进(首行除外)
            tailIndent
            minimumLineHeight 最低行高
            maximumLineHeight 最大行高
            paragraphSpacing 段与段之间的间距
            paragraphSpacingBefore 段首行空白空间
            baseWritingDirection 书写方向（一共三种）
            lineHeightMultiple
            hyphenationFactor 连字属性 在iOS，唯一支持的值分别为0和1
         */
        NSMutableAttributedString *singleFontStr = [[NSMutableAttributedString alloc] initWithString:@"我是单个字符10-20号随机系统字体"];
        for (int index = 0; index < singleFontStr.length; index++) {
            UIFont *randomFont = [UIFont systemFontOfSize:arc4random()%11 + 10];
            [singleFontStr addAttributes:@{NSFontAttributeName:randomFont} range:NSMakeRange(index, 1)];
        }
        
        NSMutableAttributedString *singleColorStr = [[NSMutableAttributedString alloc] initWithString:@"我是单个字符随机颜色文字"];
        for (int index = 0; index < singleColorStr.length; index++) {
            UIColor *randomColor = [UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1];
            [singleColorStr addAttributes:@{NSForegroundColorAttributeName:randomColor} range:NSMakeRange(index, 1)];
        }
        
        NSMutableAttributedString *singleBackColorStr = [[NSMutableAttributedString alloc] initWithString:@"我是单个字符随机背景颜色文字"];
        for (int index = 0; index < singleBackColorStr.length; index++) {
            UIColor *randomColor = [UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1];
            [singleBackColorStr addAttributes:@{NSBackgroundColorAttributeName:randomColor} range:NSMakeRange(index, 1)];
        }
        
        NSMutableAttributedString *singleKernColorStr = [[NSMutableAttributedString alloc] initWithString:@"我是单个随机间距10~20文字"];
        for (int index = 0; index < singleKernColorStr.length; index++) {
            [singleKernColorStr addAttributes:@{NSKernAttributeName:@((arc4random()%11) + 10)} range:NSMakeRange(index, 1)];
        }
        
        NSMutableAttributedString *singleStrokeStr = [[NSMutableAttributedString alloc] initWithString:@"我是单个随机描边颜色和宽度1~10文字"];
        for (int index = 0; index < singleStrokeStr.length; index++) {
            UIColor *randomColor = [UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1];
            [singleStrokeStr addAttributes:@{NSStrokeColorAttributeName:randomColor, NSStrokeWidthAttributeName:@(arc4random()%10 + 1)} range:NSMakeRange(index, 1)];
        }
        
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowOffset = CGSizeMake(3, 4);
        shadow.shadowBlurRadius = 5;
        shadow.shadowColor = [UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1];
        
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        UIImage *image = [UIImage imageNamed:@"Weizhifu"];
        attachment.image = image;
        attachment.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
        NSAttributedString *attributedStr = [NSAttributedString attributedStringWithAttachment:attachment];
        NSMutableAttributedString *mattributedStr = [[NSMutableAttributedString alloc] initWithString:@"我是带附件的文字" attributes:nil];
        [mattributedStr insertAttributedString:attributedStr atIndex:mattributedStr.length];
        [mattributedStr insertAttributedString:attributedStr atIndex:mattributedStr.length];
        [mattributedStr insertAttributedString:attributedStr atIndex:mattributedStr.length];
        [mattributedStr insertAttributedString:attributedStr atIndex:mattributedStr.length];
        
        NSMutableAttributedString *singleUnderLineColorStr = [[NSMutableAttributedString alloc] initWithString:@"我是单个下划线随机颜色文字" attributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}];
        for (int index = 0; index < singleUnderLineColorStr.length; index++) {
            UIColor *randomColor = [UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1];
            [singleUnderLineColorStr addAttributes:@{NSUnderlineColorAttributeName:randomColor} range:NSMakeRange(index, 1)];
        }
        
        NSMutableAttributedString *singleStrikethroughColorStr = [[NSMutableAttributedString alloc] initWithString:@"我是单个删除线随机颜色文字" attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)}];
        for (int index = 0; index < singleStrikethroughColorStr.length; index++) {
            UIColor *randomColor = [UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1];
            [singleStrikethroughColorStr addAttributes:@{NSStrikethroughColorAttributeName:randomColor} range:NSMakeRange(index, 1)];
        }
        
        NSMutableAttributedString *singleObliquenessColorStr = [[NSMutableAttributedString alloc] initWithString:@"我是单个倾斜度随机为-2~2的文字"];
        for (int index = 0; index < singleObliquenessColorStr.length; index++) {
            NSNumber *randomNuber = @(arc4random()%5-2);
            [singleObliquenessColorStr addAttributes:@{NSObliquenessAttributeName:randomNuber} range:NSMakeRange(index, 1)];
        }
        
        NSMutableParagraphStyle *lineSpacingParagraphStyle = [[NSMutableParagraphStyle alloc] init];
        lineSpacingParagraphStyle.lineSpacing = 20;
        
        NSMutableParagraphStyle *paragraphSpacingParagraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphSpacingParagraphStyle.paragraphSpacing = 20;
        
        NSMutableParagraphStyle *alignmentLParagraphStyle = [[NSMutableParagraphStyle alloc] init];
        alignmentLParagraphStyle.alignment = NSTextAlignmentLeft;
        
        NSMutableParagraphStyle *alignmentRParagraphStyle = [[NSMutableParagraphStyle alloc] init];
        alignmentRParagraphStyle.alignment = NSTextAlignmentRight;
        
        NSMutableParagraphStyle *alignmentCParagraphStyle = [[NSMutableParagraphStyle alloc] init];
        alignmentCParagraphStyle.alignment = NSTextAlignmentCenter;
        
        NSMutableParagraphStyle *firstLineHeadIndentParagraphStyle = [[NSMutableParagraphStyle alloc] init];
        firstLineHeadIndentParagraphStyle.firstLineHeadIndent = 20;
        
        NSMutableParagraphStyle *headIndentParagraphStyle = [[NSMutableParagraphStyle alloc] init];
        headIndentParagraphStyle.headIndent = 20;
        
        NSMutableParagraphStyle *tailIndentParagraphStyle = [[NSMutableParagraphStyle alloc] init];
        tailIndentParagraphStyle.tailIndent = 250;
        
        NSMutableParagraphStyle *lineBreakMode1ParagraphStyle = [[NSMutableParagraphStyle alloc] init];
        lineBreakMode1ParagraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSMutableParagraphStyle *lineBreakMode2ParagraphStyle = [[NSMutableParagraphStyle alloc] init];
        lineBreakMode2ParagraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        NSMutableParagraphStyle *lineBreakMode3ParagraphStyle = [[NSMutableParagraphStyle alloc] init];
        lineBreakMode3ParagraphStyle.lineBreakMode = NSLineBreakByClipping;
        NSMutableParagraphStyle *lineBreakMode4ParagraphStyle = [[NSMutableParagraphStyle alloc] init];
        lineBreakMode4ParagraphStyle.lineBreakMode = NSLineBreakByTruncatingHead;
        NSMutableParagraphStyle *lineBreakMode5ParagraphStyle = [[NSMutableParagraphStyle alloc] init];
        lineBreakMode5ParagraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        NSMutableParagraphStyle *lineBreakMode6ParagraphStyle = [[NSMutableParagraphStyle alloc] init];
        lineBreakMode6ParagraphStyle.lineBreakMode = NSLineBreakByTruncatingMiddle;
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 10;// 字体的行间距
        paragraphStyle.firstLineHeadIndent = 10.0f;//首行缩进
        paragraphStyle.alignment = NSTextAlignmentJustified;//（两端对齐的）文本对齐方式：（左，中，右，两端对齐，自然）
        paragraphStyle.headIndent = 20;//整体缩进(首行除外)
        paragraphStyle.minimumLineHeight = 10;//最低行高
        paragraphStyle.maximumLineHeight = 30;//最大行高
        paragraphStyle.paragraphSpacing = 15;//段与段之间的间距
        paragraphStyle.paragraphSpacingBefore = 10.0f;
        paragraphStyle.hyphenationFactor = 0;//连字属性 在iOS，唯一支持的值分别为0和1
        
        NSArray *arr = @[
                            @{@"title":@"文字字体", @"items":@[
                                                                @{@"title":@"NSFontAttributeName", @"describe":@"14号系统字体", @"effectString":[[NSAttributedString alloc] initWithString:@"我是14号系统字体" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}]},
                                                                @{@"title":@"NSFontAttributeName", @"describe":@"20号系统字体", @"effectString":[[NSAttributedString alloc] initWithString:@"我是20号系统字体" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}]},
                                                                @{@"title":@"NSFontAttributeName", @"describe":@"我是单个字符10-20号随机系统字体", @"effectString":singleFontStr}
                                                            ]
                              },
                            
                            @{@"title":@"文字段落风格", @"items":@[
                                                                    @{@"title":@"NSParagraphStyleAttributeName", @"describe":@"文字段落风格行距", @"effectString":[[NSAttributedString alloc] initWithString:@"我是30号系统字体，20个单位的行距的文字" attributes:@{NSParagraphStyleAttributeName:lineSpacingParagraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:30]}]},
                                                                    @{@"title":@"NSParagraphStyleAttributeName", @"describe":@"文字段落风格段落间距", @"effectString":[[NSAttributedString alloc] initWithString:@"我是30号系统字体\n20个单位的段落间距的文字" attributes:@{NSParagraphStyleAttributeName:paragraphSpacingParagraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:30]}]},
                                                                    @{@"title":@"NSParagraphStyleAttributeName", @"describe":@"文字段落风格左对齐", @"effectString":[[NSAttributedString alloc] initWithString:@"我是30号系统字体左对齐的文字" attributes:@{NSParagraphStyleAttributeName:alignmentLParagraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:30]}]},
                                                                    @{@"title":@"NSParagraphStyleAttributeName", @"describe":@"文字段落风格右对齐", @"effectString":[[NSAttributedString alloc] initWithString:@"我是30号系统字体右对齐的文字" attributes:@{NSParagraphStyleAttributeName:alignmentRParagraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:30]}]},
                                                                    @{@"title":@"NSParagraphStyleAttributeName", @"describe":@"文字段落风格居中对齐", @"effectString":[[NSAttributedString alloc] initWithString:@"我是30号系统字体居中对齐的文字" attributes:@{NSParagraphStyleAttributeName:alignmentCParagraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:30]}]},
                                                                    @{@"title":@"NSParagraphStyleAttributeName", @"describe":@"文字段落风格首行缩进", @"effectString":[[NSAttributedString alloc] initWithString:@"我是30号系统字体首行缩进20个单位的文字" attributes:@{NSParagraphStyleAttributeName:firstLineHeadIndentParagraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:30]}]},
                                                                    @{@"title":@"NSParagraphStyleAttributeName", @"describe":@"文字段落风格非首行缩进", @"effectString":[[NSAttributedString alloc] initWithString:@"我是30号系统字体非首行缩进20个单位的文字" attributes:@{NSParagraphStyleAttributeName:headIndentParagraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:30]}]},
                                                                    @{@"title":@"NSParagraphStyleAttributeName", @"describe":@"文字段落风格尾部缩进", @"effectString":[[NSAttributedString alloc] initWithString:@"我是30号系统字体尾部缩进250个单位的文字" attributes:@{NSParagraphStyleAttributeName:tailIndentParagraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:30]}]},
                                                                    @{@"title":@"NSParagraphStyleAttributeName", @"describe":@"文字段落风格lineBreakMode", @"effectString":[[NSAttributedString alloc] initWithString:@"我是30号系统字体lineBreakMode为NSLineBreakByWordWrapping的文字" attributes:@{NSParagraphStyleAttributeName:lineBreakMode1ParagraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:30]}]},
                                                                    @{@"title":@"NSParagraphStyleAttributeName", @"describe":@"文字段落风格lineBreakMode", @"effectString":[[NSAttributedString alloc] initWithString:@"我是30号系统字体lineBreakMode为NSLineBreakByCharWrapping的文字" attributes:@{NSParagraphStyleAttributeName:lineBreakMode2ParagraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:30]}]},
                                                                    @{@"title":@"NSParagraphStyleAttributeName", @"describe":@"文字段落风格lineBreakMode", @"effectString":[[NSAttributedString alloc] initWithString:@"我是30号系统字体lineBreakMode为NSLineBreakByClipping的文字" attributes:@{NSParagraphStyleAttributeName:lineBreakMode3ParagraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:30]}]},
                                                                    @{@"title":@"NSParagraphStyleAttributeName", @"describe":@"文字段落风格lineBreakMode", @"effectString":[[NSAttributedString alloc] initWithString:@"我是30号系统字体lineBreakMode为NSLineBreakByTruncatingHead的文字" attributes:@{NSParagraphStyleAttributeName:lineBreakMode4ParagraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:30]}]},
                                                                    @{@"title":@"NSParagraphStyleAttributeName", @"describe":@"文字段落风格lineBreakMode", @"effectString":[[NSAttributedString alloc] initWithString:@"我是30号系统字体lineBreakMode为NSLineBreakByTruncatingTail的文字" attributes:@{NSParagraphStyleAttributeName:lineBreakMode5ParagraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:30]}]},
                                                                    @{@"title":@"NSParagraphStyleAttributeName", @"describe":@"文字段落风格lineBreakMode", @"effectString":[[NSAttributedString alloc] initWithString:@"我是30号系统字体lineBreakMode为NSLineBreakByTruncatingMiddle的文字" attributes:@{NSParagraphStyleAttributeName:lineBreakMode6ParagraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:30]}]},
                                                                    @{@"title":@"NSParagraphStyleAttributeName", @"describe":@"文字段落风格lineBreakMode", @"effectString":[[NSAttributedString alloc] initWithString:@"我是30号系统字体文字段落风格多样的文字\n看我效果如何，唯有运行一试，看看吧，看看吧！" attributes:@{NSParagraphStyleAttributeName:paragraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:30]}]}
                                                                ]
                              },
                            @{@"title":@"文字颜色", @"items":@[
                                                                @{@"title":@"NSForegroundColorAttributeName", @"describe":@"红色文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是红色文字" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}]},
                                                                @{@"title":@"NSForegroundColorAttributeName", @"describe":@"青色文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是青色文字" attributes:@{NSForegroundColorAttributeName:[UIColor cyanColor]}]},
                                                                @{@"title":@"NSForegroundColorAttributeName", @"describe":@"单个随机颜色文字", @"effectString":singleColorStr}
                                                            ]
                              },
                            @{@"title":@"文字背景颜色", @"items":@[
                                                                @{@"title":@"NSBackgroundColorAttributeName", @"describe":@"背景红色文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是背景红色文字" attributes:@{NSBackgroundColorAttributeName:[UIColor redColor]}]},
                                                                @{@"title":@"NSBackgroundColorAttributeName", @"describe":@"背景青色文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是背景青色文字" attributes:@{NSBackgroundColorAttributeName:[UIColor cyanColor]}]},
                                                                @{@"title":@"NSBackgroundColorAttributeName", @"describe":@"我是单个随机背景颜色文字", @"effectString":singleBackColorStr}
                                                                ]
                              },
                            @{@"title":@"文字连字符", @"items":@[
                                                                @{@"title":@"NSLigatureAttributeName", @"describe":@"没有连字符", @"effectString":[[NSAttributedString alloc] initWithString:@"我是没有连字符文字" attributes:@{NSLigatureAttributeName:@0}]},
                                                                @{@"title":@"NSLigatureAttributeName", @"describe":@"默认连字符", @"effectString":[[NSAttributedString alloc] initWithString:@"我是默认连字符文字" attributes:@{NSLigatureAttributeName:@1}]}
                                                               ]
                              },
                            @{@"title":@"文字间距", @"items":@[
                                                                @{@"title":@"NSKernAttributeName", @"describe":@"间距10文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是背景红色文字" attributes:@{NSKernAttributeName:@10}]},
                                                                @{@"title":@"NSKernAttributeName", @"describe":@"间距15文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是背景青色文字" attributes:@{NSKernAttributeName:@15}]},
                                                                @{@"title":@"NSKernAttributeName", @"describe":@"我是单个随机间距10~20文字", @"effectString":singleKernColorStr}
                                                             ]
                              },
                            @{@"title":@"文字删除线", @"items":@[
                                                                @{@"title":@"NSStrikethroughStyleAttributeName", @"describe":@"NSUnderlineStyleNone不设置删除线文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是NSUnderlineStyleNone不设置删除线文字" attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleNone)}]},
                                                                @{@"title":@"NSStrikethroughStyleAttributeName", @"describe":@"NSUnderlineStyleSingle设置删除线为细单实线文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是NSUnderlineStyleSingle设置删除线为细单实线文字" attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)}]},
                                                                @{@"title":@"NSStrikethroughStyleAttributeName", @"describe":@"NSUnderlineStyleThick设置删除线为粗单实线文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是NSUnderlineStyleThick设置删除线为粗单实线文字" attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleThick)}]},
                                                                @{@"title":@"NSStrikethroughStyleAttributeName", @"describe":@"NSUnderlineStyleDouble设置删除线为细双实线文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是NSUnderlineStyleDouble设置删除线为细双实线文字" attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleDouble)}]}
                                                               ]
                              },
                            @{@"title":@"文字下滑线", @"items":@[
                                                                @{@"title":@"NSUnderlineStyleAttributeName", @"describe":@"NSUnderlineStyleNone不设置下滑线文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是NSUnderlineStyleNone不设置下滑线文字" attributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone)}]},
                                                                @{@"title":@"NSUnderlineStyleAttributeName", @"describe":@"NSUnderlineStyleSingle设置下滑线为细单实线文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是NSUnderlineStyleSingle设置下滑线为细单实线文字" attributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}]},
                                                                @{@"title":@"NSUnderlineStyleAttributeName", @"describe":@"NSUnderlineStyleThick设置下滑线为粗单实线文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是NSUnderlineStyleThick设置下滑线为粗单实线文字" attributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleThick)}]},
                                                                @{@"title":@"NSUnderlineStyleAttributeName", @"describe":@"NSUnderlineStyleDouble设置下滑线为细双实线文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是NSUnderlineStyleDouble设置下滑线为细双实线文字" attributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleDouble)}]}
                                                              ]
                              },
                            @{@"title":@"文字描边颜色和宽度", @"items":@[
                                                                        @{@"title":@"NSStrokeColorAttributeName和NSStrokeWidthAttributeName(此两个属性必须一起用才有效果)", @"describe":@"描边红色色和宽度2文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是描边红色色和宽度2文字" attributes:@{NSStrokeColorAttributeName:[UIColor redColor], NSStrokeWidthAttributeName:@2}]},
                                                                        @{@"title":@"NSStrokeColorAttributeName和NSStrokeWidthAttributeName(此两个属性必须一起用才有效果)", @"describe":@"描边青色色和宽度4文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是描边青色色和宽度4文字" attributes:@{NSStrokeColorAttributeName:[UIColor cyanColor], NSStrokeWidthAttributeName:@4}]},
                                                                        @{@"title":@"NSStrokeColorAttributeName和NSStrokeWidthAttributeName(此两个属性必须一起用才有效果)", @"describe":@"单个随机描边颜色和宽度1~10文字", @"effectString":singleStrokeStr},
                                                                      ]
                              },
                            @{@"title":@"文字阴影", @"items":@[
                                                                @{@"title":@"NSShadowAttributeName", @"describe":@"阴影文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是阴影文字" attributes:@{NSShadowAttributeName:shadow}]}
                                                             ]
                              },
                            @{@"title":@"文字特效", @"items":@[
                                                                @{@"title":@"NSTextEffectAttributeName", @"describe":@"特效文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是特效文字" attributes:@{NSTextEffectAttributeName:NSTextEffectLetterpressStyle}]}
                                                             ]
                              },
                            @{@"title":@"文字附件", @"items":@[
                                                                @{@"title":@"NSAttachmentAttributeName", @"describe":@"带附件的文字", @"effectString":mattributedStr}
                                                             ]
                              },
                            @{@"title":@"文字链接", @"items":@[
                                                                @{@"title":@"NSAttachmentAttributeName", @"describe":@"带链接的文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是带链接的文字" attributes:@{NSLinkAttributeName:@"https://www.baidu.com"}]}
                                                            ]
                              },
                            @{@"title":@"文字基线偏移", @"items":@[
                                                                    @{@"title":@"NSAttachmentAttributeName", @"describe":@"基线偏移为-5的文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是基线偏移为-5的文字" attributes:@{NSBaselineOffsetAttributeName:@-5}]},
                                                                    @{@"title":@"NSAttachmentAttributeName", @"describe":@"基线偏移为5的文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是基线偏移为5的文字" attributes:@{NSBaselineOffsetAttributeName:@5}]}
                                                                ]
                              },
                            @{@"title":@"文字下划线颜色", @"items":@[
                                                                    @{@"title":@"NSAttachmentAttributeName", @"describe":@"下划线为红色的文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是下划线为红色的文字" attributes:@{NSUnderlineColorAttributeName:[UIColor redColor], NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}]},
                                                                    @{@"title":@"NSAttachmentAttributeName", @"describe":@"下划线为青色的文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是下划线为青色的文字" attributes:@{NSUnderlineColorAttributeName:[UIColor cyanColor], NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}]},
                                                                    @{@"title":@"NSAttachmentAttributeName", @"describe":@"单个下划线随机颜色文字", @"effectString":singleUnderLineColorStr}
                                                                 ]
                              },
                            @{@"title":@"文字删除线颜色", @"items":@[
                                                                    @{@"title":@"NSAttachmentAttributeName", @"describe":@"删除线为红色的文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是删除线为红色的文字" attributes:@{NSStrikethroughColorAttributeName:[UIColor redColor], NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)}]},
                                                                    @{@"title":@"NSAttachmentAttributeName", @"describe":@"删除线为青色的文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是删除线为青色的文字" attributes:@{NSStrikethroughColorAttributeName:[UIColor cyanColor], NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)}]},
                                                                    @{@"title":@"NSAttachmentAttributeName", @"describe":@"单个删除线随机颜色文字", @"effectString":singleStrikethroughColorStr}
                                                                 ]
                              },
                            @{@"title":@"文字倾斜度", @"items":@[
                                                                    @{@"title":@"NSObliquenessAttributeName", @"describe":@"倾斜度为-2的文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是倾斜度为-2的文字" attributes:@{NSObliquenessAttributeName:@(-2)}]},
                                                                    @{@"title":@"NSObliquenessAttributeName", @"describe":@"倾斜度为2的文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是倾斜度为2的文字" attributes:@{ NSObliquenessAttributeName:@(2)}]},
                                                                    @{@"title":@"NSObliquenessAttributeName", @"describe":@"单个倾斜度随机为-2~2的文字", @"effectString":singleObliquenessColorStr}
                                                              ]
                              },
                            @{@"title":@"文字横向拉伸", @"items":@[
                                                                    @{@"title":@"NSExpansionAttributeName", @"describe":@"横向拉伸为-1的文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是横向拉伸为-1的文字" attributes:@{NSExpansionAttributeName:@(-1.0)}]},
                                                                    @{@"title":@"NSExpansionAttributeName", @"describe":@"横向拉伸为1的文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是横向拉伸为1的文字" attributes:@{ NSExpansionAttributeName:@(1.0)}]}
                                                               ]
                              },
                            @{@"title":@"文字书写方向", @"items":@[
                                                                    @{@"title":@"NSWritingDirectionAttributeName", @"describe":@"书写方向为NSWritingDirectionLeftToRight|NSWritingDirectionEmbedding的文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是书写方向为NSWritingDirectionLeftToRight|NSWritingDirectionEmbedding的文字" attributes:@{NSWritingDirectionAttributeName:@[@(NSWritingDirectionLeftToRight|NSWritingDirectionEmbedding)]}]},
                                                                    @{@"title":@"NSWritingDirectionAttributeName", @"describe":@"书写方向为NSWritingDirectionRightToLeft|NSWritingDirectionEmbedding的文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是书写方向为NSWritingDirectionRightToLeft|NSWritingDirectionEmbedding的文字" attributes:@{ NSWritingDirectionAttributeName:@[@(NSWritingDirectionRightToLeft|NSWritingDirectionEmbedding)]}]},
                                                                    @{@"title":@"NSWritingDirectionAttributeName", @"describe":@"书写方向为NSWritingDirectionLeftToRight|NSWritingDirectionOverride的文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是书写方向为NSWritingDirectionLeftToRight|NSWritingDirectionOverride的文字" attributes:@{ NSWritingDirectionAttributeName:@[@(NSWritingDirectionLeftToRight|NSWritingDirectionOverride)]}]},
                                                                    @{@"title":@"NSWritingDirectionAttributeName", @"describe":@"书写方向为NSWritingDirectionRightToLeft|NSWritingDirectionOverride的文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是书写方向为NSWritingDirectionRightToLeft|NSWritingDirectionOverride的文字" attributes:@{ NSWritingDirectionAttributeName:@[@(NSWritingDirectionRightToLeft|NSWritingDirectionOverride)]}]}
                                                              ]
                              },
                            @{@"title":@"文字排版方向", @"items":@[
                                                                    @{@"title":@"NSVerticalGlyphFormAttributeName", @"describe":@"横向排版的文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是横向排版的文字" attributes:@{NSVerticalGlyphFormAttributeName:@0}]},
                                                                    @{@"title":@"NSExpansionAttributeName", @"describe":@"纵向排版的文字（iOS端不支持纵向排版）", @"effectString":[[NSAttributedString alloc] initWithString:@"我是纵向排版的文字（iOS端不支持纵向排版）" attributes:@{ NSVerticalGlyphFormAttributeName:@1}]}
                                                                ]
                              }
                         ];
        
        NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:1];
        for (NSDictionary *dic in arr) {
            [mArr addObject:[SectionAttributedModel sectionAttributedModelWithDic:dic]];
        }
        
        _dataArr = mArr;
    }
    
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingUi];
}
- (void)settingUi
{
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SectionAttributedModel *sectionModel = self.dataArr[section];
    return sectionModel.items.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SectionAttributedModel *sectionModel = self.dataArr[section];
    return sectionModel.title;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SectionAttributedModel *sectionModel = self.dataArr[indexPath.section];
    AttributedFrameModel *frameModel = sectionModel.items[indexPath.row];
    AttributedCell *cell = [AttributedCell attributedCellWithAttributedFrameModel:frameModel andTableView:tableView];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SectionAttributedModel *sectionModel = self.dataArr[indexPath.section];
    AttributedFrameModel *frameModel = sectionModel.items[indexPath.row];
    return frameModel.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end


@interface AttributedCell ()<UITextViewDelegate>

@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UILabel *describeLabel;
@property (weak, nonatomic) UILabel *effectLabel;

@end
@implementation AttributedCell

- (void)setModel:(AttributedFrameModel *)model
{
    if (model) {
        _model = model;
        self.titleLabel.text = model.attributedModel.title;
        self.titleLabel.frame = model.titleRect;
        self.describeLabel.text = model.attributedModel.describe;
        self.describeLabel.frame = model.describeRect;
        NSRange range = NSMakeRange(0, 0);
        NSDictionary *attributes;
        BOOL linkOrAttachment = NO;
        while (range.location + range.length < model.attributedModel.effectString.length) {
            attributes = [model.attributedModel.effectString attributesAtIndex:range.location + range.length effectiveRange:&range];
            if ([attributes valueForKey:NSLinkAttributeName] || [attributes valueForKey:NSAttachmentAttributeName]) {
                linkOrAttachment = YES;
                break;
            }
        }
        
        if (linkOrAttachment) {
            self.effectTextView.attributedText = model.attributedModel.effectString;
            self.effectTextView.frame = model.effectRect;
            self.effectTextView.hidden = NO;
            self.effectLabel.hidden = YES;
        }
        else
        {
            self.effectLabel.attributedText = model.attributedModel.effectString;
            self.effectLabel.frame = model.effectRect;
            self.effectLabel.hidden = NO;
            self.effectTextView.hidden = YES;
        }
    }
}

+ (instancetype)attributedCellWithAttributedFrameModel:(AttributedFrameModel *)model andTableView:(UITableView *)tableView
{
    static NSString *identiffier = @"CellIdentifier";
    AttributedCell *cell = [tableView dequeueReusableCellWithIdentifier:identiffier];
    if (cell == nil) {
        cell = [[AttributedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identiffier];
    }
    cell.model = model;
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        UILabel *label = [[UILabel alloc] init];
        label.font = Title_Font;
        label.textColor = Title_Color;
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        self.titleLabel = label;
        
        label = [[UILabel alloc] init];
        label.font = Describe_Font;
        label.textColor = Describe_Color;
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        self.describeLabel = label;
        
        label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        self.effectLabel = label;
        
        UITextView *textView = [[UITextView alloc] init];
        textView.backgroundColor = [UIColor lightGrayColor];
        textView.scrollEnabled = NO;
        textView.delegate = self;
        textView.editable = NO;
        [self.contentView addSubview:textView];
        _effectTextView = textView;
        
        UITextField *textField = [[UITextField alloc] init];
        textField.enabled = NO;
    }
    
    return self;
}

#pragma mark - <UITextViewDelegate>代理方法
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    NSRange range = NSMakeRange(0, 0);
    NSDictionary *attributes;
    while (range.location + range.length < self.model.attributedModel.effectString.length) {
        attributes = [self.model.attributedModel.effectString attributesAtIndex:range.location + range.length effectiveRange:&range];
        if ([attributes valueForKey:NSLinkAttributeName]) {
            return YES;
        }
    }
    
    return NO;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    NSRange range = NSMakeRange(0, 0);
    NSDictionary *attributes;
    while (range.location + range.length < self.model.attributedModel.effectString.length) {
        attributes = [self.model.attributedModel.effectString attributesAtIndex:range.location + range.length effectiveRange:&range];
        if ([attributes valueForKey:NSAttachmentAttributeName]) {
            return YES;
        }
    }
    
    return NO;
}

@end
