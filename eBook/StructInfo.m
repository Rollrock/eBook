//
//  StructInfo.m
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/8.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "StructInfo.h"


@implementation BookSimpleInfo

-(void)fromDict:(NSDictionary*)dict
{
    self.name = dict[@"name"];
    self.face = dict[@"face"];
    self.desc = dict[@"desc"];
    
}

@end


////////
@implementation UnitInfo
-(void)fromDict:(NSDictionary*)dict
{
    self.uintKey = dict[@"key"];
    self.uintName = dict[@"name"];
}
@end

@implementation BookDetailInfo

-(void)fromDict:(NSDictionary*)dict
{
    [self.simpleInfo fromDict:dict];
    NSArray * arr = dict[@"zhang"];
    
    for( NSDictionary* d in arr )
    {
        UnitInfo * info = [UnitInfo new];
        [info fromDict:d];
        
        [self.uintArray addObject:info];
    }
}

-(NSMutableArray*)uintArray
{
    if(!_uintArray)
    {
        _uintArray = [NSMutableArray new];
    }
    
    return _uintArray;
}

-(BookSimpleInfo*)simpleInfo
{
    if( !_simpleInfo )
    {
        _simpleInfo = [BookSimpleInfo new];
    }
    
    return _simpleInfo;
}

@end


//
@implementation HotInfo

-(void)fromDict:(NSDictionary*)dict
{
    self.type = dict[@"type"];
    
    //
    NSArray * array = dict[@"book"];
    for( NSDictionary * sd in array )
    {
        BookSimpleInfo * info = [BookSimpleInfo new];
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
