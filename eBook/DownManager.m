//
//  DownManager.m
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/8.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "DownManager.h"
#import "FileManager.h"
#import <UIKit/UIKit.h>

#define RETRY_DELAY   2
#define RETRY_COUNT   2

@interface DownManager()<NSURLConnectionDelegate>
{
    NSURLRequest * request;
    NSURLConnection * conn;
    NSMutableData * bookData;
    
    NSTimer * reTryTimer;
    NSInteger retryCount;//
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

-(void)startDownLoad:(NSString*)strUrl succ:(DownLoadComplete)succ failed:(DownLoadFailed)failed
{
    [bookData setLength:0];
    bookData = nil;
    bookData = [NSMutableData new];
    //
    request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:strUrl]];
    conn = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    
    //
    self.downComplete = succ;
    self.downFailed = failed;
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
    
    reTryTimer = [NSTimer scheduledTimerWithTimeInterval:RETRY_DELAY target:self selector:@selector(retryDownLoad) userInfo:nil repeats:NO];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");
    
    if( bookData && self.downComplete )
    {
        self.downComplete(bookData);
    }
    else
    {
        if( self.downFailed)
        {
            self.downFailed();
        }
    }
    
    //
    [self resetDelay];
}

-(void)resetDelay
{
    retryCount = 0;
    [reTryTimer invalidate];
    reTryTimer = nil;
}

-(void)retryDownLoad
{
    if( retryCount >= RETRY_COUNT )
    {
        [self resetDelay];
        
        if( self.downFailed)
        {
            self.downFailed();
        }
        
        return;
    }
    
    NSLog(@"retryDownLoad times:%ld",retryCount);
    
    ++ retryCount;
    
    [bookData setLength:0];
    conn = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
}

@end
