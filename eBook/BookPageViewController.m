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
#import "FileManager.h"
#import "CommData.h"
#import "StructInfo.h"
#import "SVProgressHUD.h"

@interface BookPageViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
{
    
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
    
    BookDetailViewController * vc = [[BookDetailViewController alloc]initWithNibName:@"BookDetailViewController" bundle:nil];
    vc.textStr = [self getPrePageData];
    
    return vc.textStr? vc:nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    [self hideCustomView];
    
    BookDetailViewController * vc = [[BookDetailViewController alloc]initWithNibName:@"BookDetailViewController" bundle:nil];
    vc.textStr = [self getNextPageData];
    
    return vc.textStr? vc:nil;
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
        _curBookVC.textStr = [self getCurPageData];
    }
    
    return _curBookVC;
}

#pragma Data
-(NSMutableArray*)dataArray
{
    if(!_dataArray)
    {
        
        NSString * origStr = [FileManager getFileString:[NSString stringWithFormat:@"%@/%@",self.bookDir,self.bookName] name:[NSString stringWithFormat:@"%@.txt",((UnitInfo*)(self.listArray[self.curUint])).uintKey]];
        
        self.dataArray = [[SplitNSString getStringArray:origStr w:[UIScreen mainScreen].bounds.size.width  h:[UIScreen mainScreen].bounds.size.height-65-10 font:[GlobalSetting getFont]] mutableCopy];
    }
    
    return _dataArray;
}

//得到下一页的数据
-(NSString*)getNextPageData
{
    ++self.curPage;
    
    //这一章完了
    if( self.curPage >= self.dataArray.count )
    {
        [self.dataArray removeAllObjects];
        self.dataArray = nil;
        
        self.curUint ++;
        
        //NSLog(@"unitIndex:%d unitCount:%d",self.curUint,self.listArray.count);
        
        if( self.curUint >= self.listArray.count)
        {
            self.curUint = self.listArray.count-1;
            self.curPage = self.dataArray.count-1;
            
            [SVProgressHUD showInfoWithStatus:@"后面没有了！"];
            
            return nil;
        }
        
        //
        NSString * origStr = [FileManager getFileString:[NSString stringWithFormat:@"%@/%@",self.bookDir,self.bookName] name:[NSString stringWithFormat:@"%@.txt",((UnitInfo*)(self.listArray[self.curUint])).uintKey]];

        
        self.dataArray = [[SplitNSString getStringArray:origStr w:[UIScreen mainScreen].bounds.size.width  h:[UIScreen mainScreen].bounds.size.height-65-10 font:[GlobalSetting getFont]] mutableCopy];
        
        self.curPage = 0;
    }
    
    [self storeReadInfo];
    
    return self.dataArray[self.curPage];
}


//得到上一页的数据
-(NSString*)getPrePageData
{
    --self.curPage;
    
    //这一章完了
    if( self.curPage < 0 )
    {
        [self.dataArray removeAllObjects];
        self.dataArray = nil;
        
        self.curUint --;
        
        if( self.curUint < 0 )
        {
            self.curUint = 0;
            self.curPage = 0;
            
            [SVProgressHUD showInfoWithStatus:@"前面没有了！"];
            
            return nil;
        }
        
        //
        NSString * origStr = [FileManager getFileString:[NSString stringWithFormat:@"%@/%@",self.bookDir,self.bookName] name:[NSString stringWithFormat:@"%@.txt",((UnitInfo*)(self.listArray[self.curUint])).uintKey]];
        
        
        self.dataArray = [[SplitNSString getStringArray:origStr w:[UIScreen mainScreen].bounds.size.width  h:[UIScreen mainScreen].bounds.size.height-65-10 font:[GlobalSetting getFont]] mutableCopy];
        
        self.curPage = self.dataArray.count-1;
    }
    
    [self storeReadInfo];
    
    return self.dataArray[self.curPage];
}

-(NSString*)getCurPageData
{
    return self.dataArray[self.curPage>=self.dataArray.count?0:self.curPage];
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

-(void)storeReadInfo
{
    ReadInfo * info = [ReadInfo new];
    info.bookName = self.bookName;
    info.dirName = self.bookDir;
    info.lastPage = [NSNumber numberWithInteger:self.curPage];
    info.lastUint = [NSNumber numberWithInteger:self.curUint];
    
    
    NSLog(@"存储 unit:%ld page:%ld",self.curUint,self.curPage);
    
    [GlobalSetting setReadInfo:info];
}

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
    leftBtn.tintColor = COMMON_BG_COLOR;
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    
    self.title = self.bookName;
}

-(void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
