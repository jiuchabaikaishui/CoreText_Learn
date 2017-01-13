//
//  CoreTextViewController.m
//  CoreText_Learn
//
//  Created by 綦 on 17/1/13.
//  Copyright © 2017年 PowesunHolding. All rights reserved.
//

#import "CoreTextViewController.h"
#import "QSPDisplayView.h"
#import "QSPFrameParser.h"

@interface CoreTextViewController ()

@end

@implementation CoreTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingUi];
}

- (void)settingUi
{
    QSPDisplayView *view = [[QSPDisplayView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64 - 49)];
    view.backgroundColor = [UIColor lightGrayColor];
    QSPFrameParserConfig *config = [[QSPFrameParserConfig alloc] init];
    config.width = view.frameWidth;
    config.textColor = [UIColor orangeColor];
    config.fontSize = 16;
    config.lineSpace = 100;
    view.coretextData = [QSPFrameParser parseContent:@"你好啊，真的吗？是否就很顺利的回复收到货第三方收到回复楼上的回复了不少交电话费收到回复收到货方式开会的拉动收到货撒谎的反馈是大家还非得说发货单上解放和手机端看回复你的海景房时间段和服务IE很谨慎的合法的好发生的机房环境是发货方式电话费呼和手机端开会方式地方我打电话副书记和覅" config:config];
    [self.view addSubview:view];
}

@end
