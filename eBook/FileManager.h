//
//  FileManager.h
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/8.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

+(void)writeDataToFile:(NSData*)data dir:(NSString*)dir name:(NSString*)name;
+(NSData*)getFileData:(NSString*)dir name:(NSString*)name;
+(NSString*)getFileString:(NSString*)dir name:(NSString*)name;

@end
