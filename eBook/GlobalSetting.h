//
//  GlobalSetting.h
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/6.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CommData.h"

#define TEXT_COLOR_ARRAY   (@[ [UIColor whiteColor],[UIColor blackColor],[UIColor whiteColor],[UIColor blackColor],[UIColor whiteColor],[UIColor blackColor] ,[UIColor blackColor]  ])

#define BG_COLOR_ARRAY  (@[[UIImage imageNamed:@"text_bg_1"],[UIImage imageNamed:@"text_bg_2"],[UIImage imageNamed:@"text_bg_3"],[UIImage imageNamed:@"text_bg_4"],[UIImage imageNamed:@"text_bg_5"],[UIImage imageNamed:@"text_bg_6"],[UIImage imageNamed:@"text_bg_7"] ])


#define NIGHT_TEXT_COLOR  [UIColor whiteColor]
#define NIGHT_BG_COLOR [UIImage imageNamed:@"text_bg_5"]


#define XIAO_FONT           [UIFont systemFontOfSize:16]
#define ZHONG_FONT          [UIFont systemFontOfSize:18]
#define DA_FONT             [UIFont systemFontOfSize:20]
#define TE_FONT             [UIFont systemFontOfSize:22]

#define DEFAULT_FONT    ZHONG_FONT

@interface GlobalSetting : NSObject


+(NSArray*)getBookShelfInfo;
+(void)addBookShelfInfo:(BookShelfInfo*)info;
+(void)setBookShelfInfo:(NSArray*)array;

+(void)setReadInfo:(ReadInfo*)info;
+(ReadInfo*)getReadInfo:(ReadInfo*)info;


+(NSInteger)getDayNightIndex;
+(void)setDayNightIndex:(NSInteger)index;


+(NSArray*)getColor;
+(NSInteger)getColorIndex;
+(NSArray*)getColorOfIndex:(NSInteger)index;
+(void)setColorOfIndex:(NSInteger)index;


+(UIFont*)getFont;
+(NSInteger)getFontIndex;
+(void)setFontOfIndex:(NSInteger)index;
+(UIFont*)getFontOfIndex:(NSInteger)index;

@end
