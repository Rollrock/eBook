//
//  GlobalSetting.m
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/6.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "GlobalSetting.h"
#import "StructInfo.h"

#define STORE_FONT          @"STORE_FONT"
#define STORE_TEXT_COLOR    @"STORE_TEXT_COLOR"
#define STORE_BG_COLOR      @"STORE_BG_COLOR"
#define STORE_NIGHT_STYLE   @"STORE_NIGHT_STYLE"

#define STORE_READ_INFO  @"STORE_READ_INFO"
#define STORE_BOOKSHELF_INFO @"STORE_BOOKSHELF_INFo"

//
@implementation GlobalSetting

+(void)setBookShelfInfo:(BookShelfInfo*)info
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSData * data = [def objectForKey:STORE_BOOKSHELF_INFO];
    NSMutableArray * array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if( !array )
    {
        array = [NSMutableArray array];
    }
    
    //
    int i =0;
    for( i = 0; i < array.count; ++ i )
    {
        BookShelfInfo * f = array[i];
        
        if( [f.bookName isEqualToString:info.bookName] && [f.bookDir isEqualToString:info.bookDir] )
        {
            return;
        }
    }
    
    if( i == array.count )
    {
        [array addObject:info];
    }
    
    
    data = [NSKeyedArchiver archivedDataWithRootObject:array];
    [def setObject:data forKey:STORE_BOOKSHELF_INFO];
    
    [def synchronize];
}

+(NSArray*)getBookShelfInfo
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSData * data = [def objectForKey:STORE_BOOKSHELF_INFO];
    NSArray * array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return array;
}


//
+(void)setReadInfo:(ReadInfo*)info
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSData * data = [def objectForKey:STORE_READ_INFO];
    NSMutableArray * array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if( !array )
    {
        array = [NSMutableArray array];
    }
    
    //
    int i =0;
    for( i = 0; i < array.count; ++ i )
    {
        ReadInfo * f = array[i];
        
        if( [f.bookName isEqualToString:info.bookName] && [f.dirName isEqualToString:info.dirName] )
        {
            [array replaceObjectAtIndex:i withObject:info];
            break;
        }
    }
    
    if( i == array.count )
    {
        [array addObject:info];
    }
    
    
    data = [NSKeyedArchiver archivedDataWithRootObject:array];
    [def setObject:data forKey:STORE_READ_INFO];
    
    [def synchronize];
}

+(ReadInfo*)getReadInfo:(ReadInfo*)info
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSData * data = [def objectForKey:STORE_READ_INFO];
    NSMutableArray * array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    
    ReadInfo * retInfo = [ReadInfo new];
    
    int i =0;
    for( i = 0; i < array.count; ++ i )
    {
        ReadInfo * f = array[i];
        
        if( [f.bookName isEqualToString:info.bookName] && [f.dirName isEqualToString:info.dirName] )
        {
            return f;
        }
    }

    return retInfo;
}


////////////////////////////////////////////////////////////////////////////

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
