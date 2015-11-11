//
//  BookCategoryViewController.m
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/8.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "BookCategoryViewController.h"
#import "BookListViewController.h"
#import "UIScrollView+UITouch.h"
#import "CommData.h"

@interface BookCategoryViewController ()


@property (weak, nonatomic) IBOutlet UILabel *cateLab1;
@property (weak, nonatomic) IBOutlet UILabel *cateLab2;
@property (weak, nonatomic) IBOutlet UILabel *cateLab3;
@property (weak, nonatomic) IBOutlet UILabel *cateLab4;
@property (weak, nonatomic) IBOutlet UILabel *cateLab5;
@property (weak, nonatomic) IBOutlet UILabel *cateLab6;



@end

@implementation BookCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"所有书籍";
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(layoutAdv) userInfo:nil repeats:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * t = [touches anyObject];
    CGPoint pt;
    
    NSString * cateName = nil;
    
    pt = [t locationInView:_cateLab1];
    if( CGRectContainsPoint(_cateLab1.bounds, pt))
    {
        NSLog(@"现代言情");
        
        cateName = @"现代言情";
    }
    
    
    pt = [t locationInView:_cateLab2];
    if( CGRectContainsPoint(_cateLab2.bounds, pt))
    {
        NSLog(@"古言穿越");
        
        cateName = @"古言穿越";
    }
    
    
    if( cateName )
    {
        BookListViewController * vc = [[BookListViewController alloc]initWithNibName:@"BookListViewController" bundle:nil];
        vc.cateName = cateName;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma ADV
-(void)layoutAdv
{
    BaiduMobAdView * _baiduView = [[BaiduMobAdView alloc]init];
    _baiduView.AdUnitTag = BAIDU_ADV_ID;
    _baiduView.AdType = BaiduMobAdViewTypeBanner;
    _baiduView.frame = CGRectMake(0, 53, [UIScreen mainScreen].bounds.size.width, kBaiduAdViewBanner468x60.height);
    _baiduView.delegate = self;
    [self.view addSubview:_baiduView];
    
    [_baiduView start];
}

- (NSString *)publisherId
{
    return  BAIDU_APP_ID;//@"c5477a92";//;
}


@end
