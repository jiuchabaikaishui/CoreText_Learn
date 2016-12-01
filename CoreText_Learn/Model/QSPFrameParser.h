//
//  QSPFrameParser.h
//  CoreText_Learn
//
//  Created by 綦 on 16/12/1.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoretextData.h"
#import "QSPFrameParserConfig.h"

@interface QSPFrameParser : NSObject

+ (CoretextData *)parseContent:(NSString *)content config:(QSPFrameParserConfig *)config;

@end
