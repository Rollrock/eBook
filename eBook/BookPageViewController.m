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

@property(strong,nonatomic) NSMutableArray * dataArray;
@end

@implementation BookPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //[self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    [self addGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma UIPageViewController
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    return  [[BookDetailViewController alloc]initWithNibName:@"BookDetailViewController" bundle:nil];;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
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
    
    
}


#pragma Super
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [super viewWillAppear:animated];
}

@end
