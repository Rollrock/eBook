//
//  BookPageViewController.m
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/7.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "BookPageViewController.h"
#import "BookDetailViewController.h"
#import "SplitNSString.h"
#import "GlobalSetting.h"

@interface BookPageViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
{
    int curIndex;
}
@property(strong,nonatomic) BookDetailViewController * curBookVC;
@property(strong,nonatomic) UIPageViewController * pageViewController;
@property(strong,nonatomic) UIView * buttomView;

@property(strong,nonatomic) NSMutableArray * dataArray;
@end

@implementation BookPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.pageViewController.view];
    
    [self addGesture];
    
    [self customView];
    
    [self.view addSubview:self.buttomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma UIPageViewController
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    [self hideCustomView];
    
    return  [[BookDetailViewController alloc]initWithNibName:@"BookDetailViewController" bundle:nil];;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    [self hideCustomView];
    
    BookDetailViewController * vc = [[BookDetailViewController alloc]initWithNibName:@"BookDetailViewController" bundle:nil];
    vc.textStr = self.dataArray[++curIndex];
    
    return vc;
}

-(UIPageViewController*)pageViewController
{
    if(!_pageViewController)
    {
        NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                                           forKey: UIPageViewControllerOptionSpineLocationKey];
        
        _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        
        [_pageViewController setViewControllers:@[self.curBookVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        
        _pageViewController.view.frame = self.view.frame;
    }
    
    return _pageViewController;
}

#pragma BookDetailVC
-(BookDetailViewController*)curBookVC
{
    if( !_curBookVC)
    {
        _curBookVC = [[BookDetailViewController alloc]initWithNibName:@"BookDetailViewController" bundle:nil];
        _curBookVC.textStr = self.dataArray[0];
        curIndex = 0;
    }
    
    return _curBookVC;
}

#pragma Data
-(NSMutableArray*)dataArray
{
    if(!_dataArray)
    {
        NSLog(@"%f",[[NSDate date] timeIntervalSince1970]);
        
        NSString * txtPath = [[NSBundle mainBundle] pathForResource:@"info" ofType:@"txt"];
        NSString * strBody = [NSString stringWithContentsOfFile:txtPath encoding:NSUTF8StringEncoding error:nil];
        
        _dataArray = [[SplitNSString getStringArray:strBody w:[UIScreen mainScreen].bounds.size.width  h:[UIScreen mainScreen].bounds.size.height-65-10 font:[GlobalSetting getFont]] mutableCopy];
        
        NSLog(@"%f",[[NSDate date] timeIntervalSince1970]);
    }
    
    return _dataArray;
}

#pragma Gesture
-(void)addGesture
{
    UITapGestureRecognizer * g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [self.view addGestureRecognizer:g];
}

-(void)tapClick
{
    NSLog(@"tapClick");
    
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
    [self buttomViewShow];
    
}


#pragma Super
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self buttomViewShow];
    
    [super viewWillAppear:animated];
}


#pragma Other

-(void)dayNightClicked
{
    NSLog(@"dayNightClicked");
}

-(UIView*)buttomView
{
    if(!_buttomView)
    {
        _buttomView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-60, [UIScreen mainScreen].bounds.size.width,60)];
        _buttomView.backgroundColor = [UIColor orangeColor];
        
        //
        UIButton * dayBtn = [[UIButton alloc]initWithFrame:CGRectMake(_buttomView.frame.size.width - 50, 10, 30, 30)];
        [dayBtn setBackgroundImage:[UIImage imageNamed:@"dayNight"] forState:UIControlStateNormal];
        [dayBtn addTarget:self action:@selector(dayNightClicked) forControlEvents:UIControlEventTouchUpInside];
        [_buttomView addSubview:dayBtn];
        
    }
    
    return _buttomView;
}

-(void)buttomViewShow
{
    [UIView animateWithDuration:0.3 animations:^(void){
        
        if( _buttomView.center.y > [UIScreen mainScreen].bounds.size.height )
        {
            _buttomView.center = CGPointMake(_buttomView.center.x, [UIScreen mainScreen].bounds.size.height-30);
        }
        else
        {
            _buttomView.center = CGPointMake(_buttomView.center.x, [UIScreen mainScreen].bounds.size.height+30);
        }
        
    }completion:^(BOOL finished) {
        
    }];
    
}

-(void)hideCustomView
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [UIView animateWithDuration:0.3 animations:^(void){
        
    if( _buttomView.center.y < [UIScreen mainScreen].bounds.size.height )
    {
        _buttomView.center = CGPointMake(_buttomView.center.x, [UIScreen mainScreen].bounds.size.height+30);
    }
        
    }completion:^(BOOL finished) {
        
    }];

}

-(void)customView
{
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClicked)];
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    
    self.title = @"金瓶梅";
    

}

-(void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
