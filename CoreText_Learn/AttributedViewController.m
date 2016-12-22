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
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 20;
        NSArray *arr = @[@{@"title":@"NSFontAttributeName", @"describe":@"文字字体", @"effectString":[[NSAttributedString alloc] initWithString:@"30号系统字体" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30]}]},
                         @{@"title":@"NSForegroundColorAttributeName", @"describe":@"文字颜色", @"effectString":[[NSAttributedString alloc] initWithString:@"随机颜色" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1]}]},
                         @{@"title":@"NSParagraphStyleAttributeName", @"describe":@"文字段落风格", @"effectString":[[NSAttributedString alloc] initWithString:@"30号系统字体，20个单位的行距" attributes:@{NSParagraphStyleAttributeName:paragraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:30]}]}
                         ];
        
        
        NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:1];
        for (NSDictionary *dic in arr) {
            [mArr addObject:[AttributedFrameModel attributedFrameModelWithDic:dic]];
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
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AttributedCell *cell = [AttributedCell attributedCellWithAttributedFrameModel:self.dataArr[indexPath.row] andTableView:tableView];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AttributedFrameModel *model = self.dataArr[indexPath.row];
    return model.cellHeight;
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
        cell.model = model;
    }
    
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
