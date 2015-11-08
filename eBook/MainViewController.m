//
//  MainViewController.m
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/6.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "MainViewController.h"
#import "BookView.h"
#import "BookBriefViewController.h"
#import "HotViewController.h"
#import "SettingViewController.h"
#import "BookCategoryViewController.h"


#define SHELF_BOOK_WIDTH 100 //书架一本书宽度
#define SHELF_BOOK_HEIGHT 160 //书架一本书宽度
#define SHELF_BOOK_DIS 10 //每本书之间的间隙


#define HOT_VIEW_TAG  1001
#define SEARCH_VIEW_TAG 1002
#define SETTING_VIEW_TAG  1003


@interface MainViewController ()<ClickDelegate>

@property(strong,nonatomic) UIScrollView * bookScroll;

//
@property (weak, nonatomic) IBOutlet UIView *bookScrollBgView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_bookScrollBgView addSubview:self.bookScroll];
    
    [self refreshBookView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma InitView
-(UIScrollView*)bookScroll
{
    if( !_bookScroll )
    {
        _bookScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width,_bookScrollBgView.frame.size.height)];
        _bookScroll.backgroundColor = [UIColor blackColor];
    }
    
    return _bookScroll;
}

-(void)refreshBookView
{
    for( UIView * view in _bookScroll.subviews)
    {
        [view removeFromSuperview];
    }
    
    //
    for( int i = 0; i < 10; ++ i )
    {
        CGRect frame = CGRectMake(SHELF_BOOK_DIS+i*(SHELF_BOOK_WIDTH+SHELF_BOOK_DIS), SHELF_BOOK_DIS, SHELF_BOOK_WIDTH, SHELF_BOOK_HEIGHT);
        BookView * view = [[BookView alloc]initWithFrame:frame imgName:@"book"];
        view.clickDelegate = self;
        [_bookScroll addSubview:view];
        
        _bookScroll.contentSize = CGSizeMake(frame.size.width + frame.origin.x + SHELF_BOOK_DIS , _bookScroll.frame.size.height);
    }
}

#pragma UI Event
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * t = [touches anyObject];
    
    CGPoint pt;
    
    //推荐
    pt = [t locationInView:[self.view viewWithTag:HOT_VIEW_TAG]];
    if( CGRectContainsPoint([self.view viewWithTag:HOT_VIEW_TAG].bounds,pt))
    {
        HotViewController * vc = [[HotViewController alloc]initWithNibName:@"HotViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
    //搜索
    pt = [t locationInView:[self.view viewWithTag:SEARCH_VIEW_TAG]];
    if( CGRectContainsPoint([self.view viewWithTag:SEARCH_VIEW_TAG].bounds,pt))
    {
        BookCategoryViewController * vc = [[BookCategoryViewController alloc]initWithNibName:@"BookCategoryViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
    //设置
    pt = [t locationInView:[self.view viewWithTag:SETTING_VIEW_TAG]];
    if( CGRectContainsPoint([self.view viewWithTag:SETTING_VIEW_TAG].bounds,pt))
    {
        SettingViewController * vc = [[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
}

#pragma BookViewDelegate
-(void)tapClicked
{
    NSLog(@"tapClicked");
    
    BookBriefViewController * vc = [[BookBriefViewController alloc]initWithNibName:@"BookBriefViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)longPress
{
    NSLog(@"longPress");
}

-(void)delClicked:(NSInteger)tag
{
    NSLog(@"delClicked tag:%ld",tag);
}



@end
