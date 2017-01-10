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
         NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
         paragraphStyle.lineSpacing = 10;// 字体的行间距
         paragraphStyle.firstLineHeadIndent = 20.0f;//首行缩进
         paragraphStyle.alignment = NSTextAlignmentJustified;//（两端对齐的）文本对齐方式：（左，中，右，两端对齐，自然）
         paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;//结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
         paragraphStyle.headIndent = 20;//整体缩进(首行除外)
         paragraphStyle.tailIndent = 20;//
         paragraphStyle.minimumLineHeight = 10;//最低行高
         paragraphStyle.maximumLineHeight = 20;//最大行高
         paragraphStyle.paragraphSpacing = 15;//段与段之间的间距
         paragraphStyle.paragraphSpacingBefore = 22.0f;//段首行空白空间Distance between the bottom of the previous paragraph (or the end of its paragraphSpacing, if any) and the top of this paragraph.
         paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;//从左到右的书写方向（一共三种）
         paragraphStyle.lineHeightMultiple = 15; Natural line height is multiplied by this factor (if positive) before being constrained by minimum and maximum line height.
         paragraphStyle.hyphenationFactor = 1;//连字属性 在iOS，唯一支持的值分别为0和1
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
        
        NSMutableAttributedString *singleObliquenessColorStr = [[NSMutableAttributedString alloc] initWithString:@"我是单个倾斜度在-2~2的文字"];
        for (int index = 0; index < singleObliquenessColorStr.length; index++) {
            NSNumber *randomNuber = @(arc4random()%5-2);
            [singleObliquenessColorStr addAttributes:@{NSObliquenessAttributeName:randomNuber} range:NSMakeRange(index, 1)];
        }
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 20;
        NSArray *arr = @[
                            @{@"title":@"文字字体", @"items":@[
                                                                @{@"title":@"NSFontAttributeName", @"describe":@"14号系统字体", @"effectString":[[NSAttributedString alloc] initWithString:@"我是14号系统字体" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}]},
                                                                @{@"title":@"NSFontAttributeName", @"describe":@"20号系统字体", @"effectString":[[NSAttributedString alloc] initWithString:@"我是20号系统字体" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}]},
                                                                @{@"title":@"NSFontAttributeName", @"describe":@"单个字符10-20号随机系统字体", @"effectString":singleFontStr}
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
                                                                @{@"title":@"NSBackgroundColorAttributeName", @"describe":@"单个随机背景颜色文字", @"effectString":singleBackColorStr}
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
                                                                @{@"title":@"NSKernAttributeName", @"describe":@"单个随机间距10~20文字", @"effectString":singleKernColorStr}
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
                                                                @{@"title":@"NSAttachmentAttributeName", @"describe":@"带链接的文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是带链接的文字" attributes:@{NSLinkAttributeName:@"www.baidu.com"}]}
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
                                                                    @{@"title":@"NSObliquenessAttributeName", @"describe":@"单个倾斜度为-2~2的文字", @"effectString":singleObliquenessColorStr}
                                                                 ]
                              },
                            @{@"title":@"文字段落风格", @"items":@[
                                                                @{@"title":@"NSParagraphStyleAttributeName", @"describe":@"文字段落风格", @"effectString":[[NSAttributedString alloc] initWithString:@"30号系统字体，20个单位的行距" attributes:@{NSParagraphStyleAttributeName:paragraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:30]}]}
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
    self.title = @"富文本";
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

@end


@interface AttributedCell ()

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
        self.effectLabel.attributedText = model.attributedModel.effectString;
        self.effectLabel.frame = model.effectRect;
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
    }
    
    return self;
}

@end
