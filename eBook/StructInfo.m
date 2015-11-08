//
//  StructInfo.m
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/8.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "StructInfo.h"


@implementation BookInfo

-(void)fromDict:(NSDictionary*)dict
{
    self.name = dict[@"name"];
    self.face = dict[@"face"];
    self.desc = dict[@"desc"];
    
}

@end


//
@implementation HotInfo

-(void)fromDict:(NSDictionary*)dict
{
    
    self.type = dict[@"type"];
    
    NSArray * array = dict[@"book"];
    for( NSDictionary * sd in array )
    {
        BookInfo * info = [BookInfo new];
        [info fromDict:sd];
        
        [self.bookArray addObject:info];
    }
}

-(NSMutableArray*)bookArray
{
    if( !_bookArray )
    {
        _bookArray = [NSMutableArray new];
    }
    return _bookArray;
}

@end





@implementation StructInfo

@end
