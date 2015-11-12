//
//  OtherViewController.m
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/11.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "OtherViewController.h"
#import "CommData.h"

@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * t =[touches anyObject];
    CGPoint pt;
    
    //1000  打分
    UIView * v = [self.view viewWithTag:1000];
    pt = [t locationInView:v];
    if( CGRectContainsPoint(v.bounds, pt))
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:SHARE_URL]];
        return;
    }
    
    //1001  清空
    v = [self.view viewWithTag:1001];
    pt = [t locationInView:v];
    if( CGRectContainsPoint(v.bounds, pt))
    {
        
        return;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
