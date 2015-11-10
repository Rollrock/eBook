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
    
    [self customView];
}


-(void)customView
{
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClicked)];
    leftBtn.tintColor = COMMON_BG_COLOR;
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    
    self.title = @"所有书籍";
}

-(void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
