//
//  BookBriefViewController.m
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/6.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "BookBriefViewController.h"
#import "BookPageViewController.h"
#import "BookDetailViewController.h"

@interface BookBriefViewController ()<UITableViewDataSource,UITableViewDelegate>

- (IBAction)readClicked;


@end

@implementation BookBriefViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


- (IBAction)readClicked
{
#if 0
    BookDetailViewController * vc = [[BookDetailViewController alloc]initWithNibName:@"BookDetailViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];

#else
    
    BookPageViewController * vc = [[BookPageViewController alloc]initWithNibName:@"BookPageViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
#endif
    
}
@end
