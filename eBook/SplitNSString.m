//
//  SplitNSString.m
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/7.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "SplitNSString.h"


#define ONE_LOAD_LEN   50 //一次加载长度
#define MIN(a,b) (a>b?b:a)

UIFont * FONT;
CGFloat MAX_LAB_HEIGHT;
CGFloat MAX_LAB_WIDTH;

@interface SplitNSString()
{
    
}
@end

@implementation SplitNSString


+(NSString*)splitString:(NSString*)origStr index:(int*)index
{
    int equalCount = 0;
    CGFloat hTemp = 0;
    
    for( int i = 1; i < 100; ++ i )
    {
        NSString * subStr = [origStr substringToIndex:MIN(origStr.length,(i*ONE_LOAD_LEN))];
        CGFloat h = [self findHeightForText:subStr];
        
        NSLog(@"h:%f",h);
        
        if( h > MAX_LAB_HEIGHT )
        {
            for( int j = 0; j < ONE_LOAD_LEN; ++ j )
            {
                subStr = [origStr substringToIndex:MIN(origStr.length, (i-1)*ONE_LOAD_LEN+j) ];
                h = [self findHeightForText:subStr];
                if( h > MAX_LAB_WIDTH )
                {
                    //中标
                    subStr = [origStr substringToIndex:MIN(origStr.length, (i-1)*ONE_LOAD_LEN+j-1)];
                    (*index) = (i-1)*ONE_LOAD_LEN+j-1;
                    
                    return subStr;
                }
            }
        }
        else
        {
            //说明提供的文字不足以填满一个屏幕
            if( h == hTemp )
            {
                equalCount ++;
                if( equalCount >= 3 )
                {
                    (*index) = -1;
                    
                    return origStr;
                }
            }
            else
            {
                hTemp = h;
                equalCount = 0;
            }
        }
    }
    
    return nil;
}


+(NSArray*)getStringArray:(NSString*)origStr w:(CGFloat)w h:(CGFloat)h font:(UIFont*)font
{
    NSMutableArray * array = [NSMutableArray new];
    FONT = font;
    MAX_LAB_WIDTH = w;
    MAX_LAB_HEIGHT = h;
    
    int curIndex = 0;
    
    for( ;; )
    {
        int index = 0;
        
        NSString * str = [self splitString:[origStr substringFromIndex:curIndex] index:&index];
        
        curIndex += index;
        
        [array addObject:str];
        
        if( (index == -1)  || (index == 0) )
        {
            return [array copy];
        }
    }
    
    
    return array;
}



+ (CGFloat)findHeightForText:(NSString *)text
{
    /*
    CGFloat result = FONT.pointSize + 4;
    
    if (text)
    {
        CGSize textSize = { MAX_LAB_WIDTH, CGFLOAT_MAX };       //Width and height of text area
        CGSize size;
       
       CGRect frame = [text boundingRectWithSize:textSize
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{ NSFontAttributeName:FONT }
                                          context:nil];
    
        size = CGSizeMake(frame.size.width, frame.size.height+1);
        
        result = MAX(size.height, result);
    }
    
    return result;
     */
    
    CGSize size = CGSizeZero;
    
    if (text)
    {
        //iOS 7
        CGRect frame = [text boundingRectWithSize:CGSizeMake(MAX_LAB_WIDTH, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:FONT } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    
    return size.height;
}


@end
