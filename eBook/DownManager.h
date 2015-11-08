//
//  DownManager.h
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/8.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownManager : NSObject

+(DownManager*)share;
-(void)startDownLoad:(NSString*)strUrl;

@end
