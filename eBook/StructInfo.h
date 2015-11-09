//
//  StructInfo.h
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/8.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookSimpleInfo : NSObject
@property(strong,nonatomic) NSString * name;//名字
@property(strong,nonatomic) NSString * face;//封面
@property(strong,nonatomic) NSString * desc;//简介
-(void)fromDict:(NSDictionary*)dict;
@end

//////////////////////////////////////////////////////////////////
@interface UnitInfo : NSObject
@property(strong,nonatomic) NSString * uintKey;
@property(strong,nonatomic) NSString * uintName;
@end

@interface BookDetailInfo : NSObject
@property(strong,nonatomic) BookSimpleInfo * simpleInfo;
@property(strong,nonatomic) NSMutableArray * uintArray;
-(void)fromDict:(NSDictionary*)dict;
@end


//
@interface HotInfo : NSObject
@property(strong,nonatomic) NSString * type;
@property(strong,nonatomic) NSMutableArray * bookArray;//BookSimpleInfo Array
-(void)fromDict:(NSDictionary*)dict;
@end




@interface StructInfo : NSObject

@end
