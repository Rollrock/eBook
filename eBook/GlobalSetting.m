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
#define STORE_COLOR      @"STORE_COLOR"
#define STORE_DAY_NIGHT   @"STORE_DAY_NIGHT"

#define STORE_READ_INFO  @"STORE_READ_INFO"
#define STORE_BOOKSHELF_INFO @"STORE_BOOKSHELF_INFo"

//
@implementation GlobalSetting


+(BOOL)reDownLoad:(NSString*)key
{
    #define REDOWN_TIME_INTERVAL  (7*24*3600)  //7天更新一次
    
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSTimeInterval t = [def doubleForKey:key];
    NSLog(@"%f-%f",t,[[NSDate date]timeIntervalSince1970]);
    if( t == 0 )//第一次存储
    {
        [def setFloat:[[NSDate date] timeIntervalSince1970] forKey:key];
        [def synchronize];
        
        return YES;
    }
    
    
    //超过时间
    if( [[NSDate date] timeIntervalSince1970] - t > REDOWN_TIME_INTERVAL )
    {
        [def setDouble:[[NSDate date] timeIntervalSince1970] forKey:key];
        [def synchronize];
        
        return YES;
    }
    
    return NO;
}

+(void)addBookShelfInfo:(BookShelfInfo*)info
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

+(void)setBookShelfInfo:(NSArray*)array
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:array];
    
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


+(NSInteger)getDayNightIndex
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSInteger b = [def boolForKey:STORE_DAY_NIGHT];
    return b;
}

+(void)setDayNightIndex:(NSInteger)index
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    [def setBool:index forKey:STORE_DAY_NIGHT];
    [def synchronize];
}

////////////////////////////////////////////////////////////////////////////

+(NSArray*)getColor
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSInteger index = [def integerForKey:STORE_COLOR];
    
    return [self getColorOfIndex:index];
}

+(NSInteger)getColorIndex
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];

    return  [def integerForKey:STORE_COLOR];
}

+(NSArray*)getColorOfIndex:(NSInteger)index
{
    if( ![self getDayNightIndex] )
    {
        NSArray * array = @[TEXT_COLOR_ARRAY[index],BG_COLOR_ARRAY[index]];
        return array;
    }
    else
    {
        return @[NIGHT_TEXT_COLOR,NIGHT_BG_COLOR];
    }
}

+(void)setColorOfIndex:(NSInteger)index
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    [def setInteger:index forKey:STORE_COLOR];
    
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
    else if( 3 == index )
    {
        return TE_FONT;
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
