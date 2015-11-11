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
#import "GlobalSetting.h"
#import "BookCategoryViewController.h"
#import "OtherViewController.h"

#define SHELF_BOOK_WIDTH 110 //书架一本书宽度
#define SHELF_BOOK_HEIGHT 160 //书架一本书宽度
#define SHELF_BOOK_DIS 10 //每本书之间的间隙


#define HOT_VIEW_TAG  1001
#define SEARCH_VIEW_TAG 1002
#define SETTING_VIEW_TAG  1003
#define OTHER_VIEW_TAG  1004


@interface MainViewController ()<ClickDelegate>

@property(strong,nonatomic) UIScrollView * bookScroll;

//
@property (strong,nonatomic) NSMutableArray * bookShelfArray;
@property (weak, nonatomic) IBOutlet UIView *bookScrollBgView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //
    
    
    [_bookScrollBgView addSubview:self.bookScroll];
    
    [self refreshBookView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshBookView) name:NOTI_REFRESH_BOOK_SHELF object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Init
-(NSMutableArray*)bookShelfArray
{
    if( !_bookShelfArray )
    {
        _bookShelfArray = [[GlobalSetting getBookShelfInfo] mutableCopy];
    }
    
    return _bookShelfArray;
}

-(UIScrollView*)bookScroll
{
    if( !_bookScroll )
    {
        _bookScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width-20,_bookScrollBgView.frame.size.height)];
        _bookScroll.showsHorizontalScrollIndicator = NO;
        _bookScroll.showsVerticalScrollIndicator = NO;
        _bookScroll.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];//[UIColor lightGrayColor];
    }
    
    return _bookScroll;
}

-(UIImage*)getBookImg:(NSString*)dir name:(NSString*)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSMutableString * path = [[NSMutableString alloc]initWithString:documentsDirectory];
    [path appendString:[NSString stringWithFormat:@"/%@/%@/%@.png",dir,name,name]];
    
    UIImage * img = [UIImage imageWithContentsOfFile:path];
    
    return img;
}

-(void)refreshBookView
{
    for( UIView * view in _bookScroll.subviews)
    {
        [view removeFromSuperview];
    }
    
    //
    self.bookShelfArray = nil;
    
    for( int i = 0; i < self.bookShelfArray.count; ++ i )
    {
        BookShelfInfo * info = self.bookShelfArray[i];
        
        CGRect frame = CGRectMake(SHELF_BOOK_DIS+i*(SHELF_BOOK_WIDTH+SHELF_BOOK_DIS), SHELF_BOOK_DIS, SHELF_BOOK_WIDTH, SHELF_BOOK_HEIGHT);
        BookView * view = [[BookView alloc]initWithFrame:frame  img:[self getBookImg:info.bookDir name:info.bookName]];
        view.tag = i;
        view.clickDelegate = self;
        [_bookScroll addSubview:view];
        
        _bookScroll.contentSize = CGSizeMake(frame.size.width + frame.origin.x + SHELF_BOOK_DIS , _bookScroll.frame.size.height);
    }
    
    if( self.bookShelfArray.count == 0 )
    {
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(SHELF_BOOK_DIS, SHELF_BOOK_DIS, SHELF_BOOK_WIDTH, SHELF_BOOK_HEIGHT)];
        imgView.image = [UIImage imageNamed:@"book"];
        [_bookScroll addSubview:imgView];
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
    
    pt = [t locationInView:[self.view viewWithTag:OTHER_VIEW_TAG]];
    if( CGRectContainsPoint([self.view viewWithTag:OTHER_VIEW_TAG].bounds,pt))
    {
        OtherViewController * vc = [[OtherViewController alloc]initWithNibName:@"OtherViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }

}

#pragma BookViewDelegate
-(void)tapClicked:(NSInteger)tag
{
    NSLog(@"tapClicked");
    
    BookShelfInfo * info = self.bookShelfArray[tag];
    
    BookBriefViewController * vc = [[BookBriefViewController alloc]initWithNibName:@"BookBriefViewController" bundle:nil];
    vc.bookName = info.bookName;
    vc.dir = info.bookDir;
    vc.bookDesc = info.bookDesc;
    
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)longPress
{
    NSLog(@"longPress");
}

-(void)delClicked:(NSInteger)tag
{
    NSLog(@"delClicked tag:%ld",tag);
    
    [self.bookShelfArray removeObjectAtIndex:tag];
    [GlobalSetting setBookShelfInfo:self.bookShelfArray];
    [self refreshBookView];
}



@end
