//
//  AttributeViewController.h
//  CoreText_Learn
//
//  Created by 綦 on 16/12/22.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SectionAttributedModel.h"

@interface AttributedViewController : UIViewController

@end


@interface AttributedCell : UITableViewCell

@property (strong, nonatomic) AttributedFrameModel *model;

+ (instancetype)attributedCellWithAttributedFrameModel:(AttributedFrameModel *)model andTableView:(UITableView *)tableView;

@end
