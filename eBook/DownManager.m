//
//  DownManager.m
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/8.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "DownManager.h"
#import "FileManager.h"

@interface DownManager()<NSURLConnectionDelegate>
{
    NSURLRequest * request;
    NSURLConnection * conn;
    NSMutableData * bookData;
}
@end

@implementation DownManager

+(DownManager*)share
{
    static DownManager * manager = nil;
    static dispatch_once_t one;
    
    dispatch_once(&one,^(void){
        
        manager = [DownManager new];
    });
    
    return manager;
}

-(void)startDownLoad:(NSString*)strUrl
{
    bookData = nil;
    bookData = [NSMutableData new];
    
    //
    request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:strUrl]];
    conn = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    
}

#pragma 

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"didReceiveData");
    
    [bookData appendData:data];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError:%@-%@",error,error.description);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");
    
    [FileManager writeDataToFile:bookData dir:@"hot" name:@"hot.txt"];
}


@end
