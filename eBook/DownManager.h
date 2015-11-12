//
//  DownManager.h
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/8.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^DownLoadComplete) (NSData*data);
typedef void(^DownLoadFailed)();

@interface DownManager : NSObject

+(DownManager*)share;
-(void)startDownLoad:(NSString*)strUrl succ:(DownLoadComplete)succ failed:(DownLoadFailed)failed;

@property(copy,nonatomic) DownLoadComplete downComplete;
@property(copy,nonatomic) DownLoadFailed downFailed;

@end
