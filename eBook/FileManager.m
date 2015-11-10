//
//  FileManager.m
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/8.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "FileManager.h"
#import "SSZipArchive.h"

@implementation FileManager

+(void)createDir:(NSString*)dir
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSMutableString * path = [[NSMutableString alloc]initWithString:documentsDirectory];
    [path appendString:[NSString stringWithFormat:@"/%@/",dir]];
    
    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    NSAssert(bo,@"创建目录失败");
}

+(void)writeDataToFile:(NSData*)data dir:(NSString*)dir name:(NSString*)name
{
   // dispatch_sync(dispatch_get_global_queue(0, 0), ^(void){
        
        // 获取程序Documents目录路径
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSMutableString * path = [[NSMutableString alloc]initWithString:documentsDirectory];
        [path appendString:[NSString stringWithFormat:@"/%@/%@",dir,name]];
        
        [self createDir:dir];
        
        BOOL ret = [data writeToFile:path atomically:YES];
        NSLog(@"writeDataToFile ret:%d",ret);
        
    //});

}

+(NSData*)getFileData:(NSString*)dir name:(NSString*)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSMutableString * path = [[NSMutableString alloc]initWithString:documentsDirectory];
    [path appendString:[NSString stringWithFormat:@"/%@/%@",dir,name]];
    
    NSLog(@"getFileData path:%@",path);
    
    NSData* fileData = [NSData dataWithContentsOfFile:path];
    
    if( !fileData )
    {
        NSLog(@"fileData is nil");
    }
    
    return fileData;
}

+(NSString*)getFileString:(NSString*)dir name:(NSString*)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSMutableString * path = [[NSMutableString alloc]initWithString:documentsDirectory];
    [path appendString:[NSString stringWithFormat:@"/%@/%@",dir,name]];
    
    NSLog(@"getFileString path:%@",path);
    
    NSString* str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    if( !str )
    {
        NSLog(@"fileString is nil");
    }
    
    return str;
}


+(void)unZipFile:(NSString*)dir name:(NSString*)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSMutableString * path = [[NSMutableString alloc]initWithString:documentsDirectory];
    NSString * zipPath = [NSString stringWithFormat:@"%@/%@/%@.zip",path,dir,name];
    NSString * destPath = [NSString stringWithFormat:@"%@/%@",path,dir];
    
    BOOL bRet = [SSZipArchive unzipFileAtPath:zipPath toDestination:destPath];
    
    NSLog(@"unzip:%d",bRet);
    
    if( bRet )
    {
        [self removeZipFile:zipPath];
    }
    
}

+(void)removeZipFile:(NSString*)path
{
    NSFileManager *defaultManager;
    defaultManager = [NSFileManager defaultManager];
    
    [defaultManager removeItemAtPath:path error:nil];
}
@end
