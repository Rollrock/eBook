//
//  GlobalSetting.m
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/6.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "GlobalSetting.h"

#define STORE_FONT          @"STORE_FONT"
#define STORE_TEXT_COLOR    @"STORE_TEXT_COLOR"
#define STORE_BG_COLOR      @"STORE_BG_COLOR"
#define STORE_NIGHT_STYLE   @"STORE_NIGHT_STYLE"

@implementation GlobalSetting


+(UIColor*)getBgColor
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSInteger index = [def integerForKey:STORE_BG_COLOR];
    
    return [self getBgColorOfIndex:index];
}

+(NSInteger)getBgColorIndex
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];

    return  [def integerForKey:STORE_BG_COLOR];
}

+(UIColor*)getBgColorOfIndex:(NSInteger)index
{
    if( 0 == index )
    {
        return BG_COLOR_0;
    }
    else if( 1 == index )
    {
        return  BG_COLOR_1;
    }
    else if( 2 == index )
    {
        return BG_COLOR_2;
    }
    else if( 3 == index )
    {
        return BG_COLOR_3;
    }
    else
    {
        return BG_COLOR_0;
    }
}

+(void)setBgColorOfIndex:(NSInteger)index
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    [def setInteger:index forKey:STORE_BG_COLOR];
    
    [def synchronize];
}

//
+(UIColor*)getTextColor
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSInteger index = [def integerForKey:STORE_TEXT_COLOR];
    
    return [self getTextColorOfIndex:index];
}

+(NSInteger)getTextColorIndex
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    return  [def integerForKey:STORE_TEXT_COLOR];
}

+(UIColor*)getTextColorOfIndex:(NSInteger)index
{
    if( 0 == index )
    {
        return TEXT_COLOR_0;
    }
    else if( 1 == index )
    {
        return  TEXT_COLOR_1;
    }
    else if( 2 == index )
    {
        return TEXT_COLOR_1;
    }
    else
    {
        return TEXT_COLOR_0;
    }
}

+(void)setTextColorOfIndex:(NSInteger)index
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    [def setInteger:index forKey:STORE_TEXT_COLOR];
    
    [def synchronize];
}

/////
+(UIFont*)getFont
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSInteger index = [def integerForKey:STORE_FONT];
    
    return [self getFontOfIndex:index];
}

+(NSInteger)getFontIndex
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    return  [def integerForKey:STORE_FONT];
}

+(UIFont*)getFontOfIndex:(NSInteger)index
{
    if( 0 == index )
    {
        return XIAO_FONT;
    }
    else if( 1 == index )
    {
        return  ZHONG_FONT;
    }
    else if( 2 == index )
    {
        return DA_FONT;
    }
    else
    {
        return ZHONG_FONT;
    }
}



+(void)setFontOfIndex:(NSInteger)index
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    [def setInteger:index forKey:STORE_FONT];
    
    [def synchronize];
}


@end
