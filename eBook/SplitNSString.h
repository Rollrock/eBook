//
//  SplitNSString.h
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/7.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SplitNSString : NSObject

+(NSArray*)getStringArray:(NSString*)origStr w:(CGFloat)w h:(CGFloat)h font:(UIFont*)font;

@end
