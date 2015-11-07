//
//  GlobalSetting.h
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/6.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define TEXT_COLOR_0          [UIColor colorWithPatternImage:[UIImage imageNamed:@"text_color_0"]]
#define TEXT_COLOR_1          [UIColor colorWithPatternImage:[UIImage imageNamed:@"text_color_1"]]
#define TEXT_COLOR_2          [UIColor colorWithPatternImage:[UIImage imageNamed:@"text_color_2"]]
#define TEXT_COLOR_3          [UIColor colorWithPatternImage:[UIImage imageNamed:@"text_color_3"]]
#define TEXT_DEFAULT_COLOR TEXT_COLOR_0


#define BG_COLOR_0          [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_color_0"]]
#define BG_COLOR_1          [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_color_1"]]
#define BG_COLOR_2          [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_color_2"]]
#define BG_COLOR_3          [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_color_3"]]


#define BG_DEFAULT_COLOR    BG_COLOR_0


#define XIAO_FONT      [UIFont systemFontOfSize:12]
#define ZHONG_FONT          [UIFont systemFontOfSize:15]
#define DA_FONT         [UIFont systemFontOfSize:18]

#define DEFAULT_FONT    ZHONG_FONT

@interface GlobalSetting : NSObject

+(UIColor*)getBgColor;
+(NSInteger)getBgColorIndex;
+(UIColor*)getBgColorOfIndex:(NSInteger)index;
+(void)setBgColorOfIndex:(NSInteger)index;


+(UIColor*)getTextColor;
+(NSInteger)getTextColorIndex;
+(UIColor*)getTextColorOfIndex:(NSInteger)index;
+(void)setTextColorOfIndex:(NSInteger)index;


+(UIFont*)getFont;
+(NSInteger)getFontIndex;
+(void)setFontOfIndex:(NSInteger)index;
+(UIFont*)getFontOfIndex:(NSInteger)index;

@end
