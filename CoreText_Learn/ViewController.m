//
//  ViewController.m
//  CoreText_Learn
//
//  Created by 綦 on 16/11/28.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "ViewController.h"
#import "QSPDisplayView.h"
#import "QSPFrameParser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    QSPDisplayView *view = [[QSPDisplayView alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height)];
    view.backgroundColor = [UIColor lightGrayColor];
    QSPFrameParserConfig *config = [[QSPFrameParserConfig alloc] init];
    config.width = view.frameWidth;
    config.textColor = [UIColor orangeColor];
    config.fontSize = 16;
    config.lineSpace = 12;
    view.coretextData = [QSPFrameParser parseContent:@"你好啊，真的吗？" config:config];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
