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
        
        NSMutableAttributedString *singleColorStr = [[NSMutableAttributedString alloc] initWithString:@"我是单个字符10-20号随机系统字体"];
        for (int index = 0; index < singleColorStr.length; index++) {
            UIColor *randomColor = [UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1];
            [singleColorStr addAttributes:@{NSForegroundColorAttributeName:randomColor} range:NSMakeRange(index, 1)];
        }
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 20;
        NSArray *arr = @[
                            @{@"title":@"文字字体", @"items":@[
                                                                @{@"title":@"NSFontAttributeName", @"describe":@"14号系统字体", @"effectString":[[NSAttributedString alloc] initWithString:@"我是14号系统字体" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}]},
                                                                @{@"title":@"NSFontAttributeName", @"describe":@"20号系统字体", @"effectString":[[NSAttributedString alloc] initWithString:@"我是20号系统字体" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}]},
                                                                @{@"title":@"NSFontAttributeName", @"describe":@"10-20号随机系统字体", @"effectString":[[NSAttributedString alloc] initWithString:@"我是8-12号随机系统字体" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:arc4random()%11 + 10]}]},
                                                                @{@"title":@"NSFontAttributeName", @"describe":@"单个字符10-20号随机系统字体", @"effectString":singleFontStr}
                                                            ]
                              },
                            @{@"title":@"文字颜色", @"items":@[
                                                                @{@"title":@"NSForegroundColorAttributeName", @"describe":@"红色文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是红色文字" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}]},
                                                                @{@"title":@"NSForegroundColorAttributeName", @"describe":@"青色文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是青色文字" attributes:@{NSForegroundColorAttributeName:[UIColor cyanColor]}]},
                                                                @{@"title":@"NSForegroundColorAttributeName", @"describe":@"随机颜色文字", @"effectString":[[NSAttributedString alloc] initWithString:@"我是随机颜色文字" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1]}]},
                                                                @{@"title":@"NSForegroundColorAttributeName", @"describe":@"单个随机颜色文字", @"effectString":singleColorStr}
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
    self.title = @"NSAttributedString富文本";
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
