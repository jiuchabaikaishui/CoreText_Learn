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
    view.coretextData = [QSPFrameParser parseAttributedTemplateFile:[[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"] andWith:view.frameWidth];
    [self.view addSubview:view];
}

@end
