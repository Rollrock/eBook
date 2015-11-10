//
//  BookListViewController.m
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/8.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "BookListViewController.h"
#import "BookListTableViewCell.h"
#import "CommData.h"
#import "FileManager.h"
#import "SVProgressHUD.h"
#import "DownManager.h"
#import "CommData.h"
#import "BookBriefViewController.h"


@interface BookListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray * listArray;


@end

@implementation BookListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 100;
    
     self.title = self.cateName;
    
    if( ![self getBookList] )
    {
        //下载
       [SVProgressHUD showWithStatus:@"下载中..."];
            
        __weak typeof(self) weakSelf = self;
        
        NSString * str = [NSString stringWithFormat:@"%@%@/目录.txt",BASE_URL,self.cateName];
        str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
            [[DownManager share]startDownLoad:str succ:^(NSData *data) {
                
                [FileManager writeDataToFile:data dir:self.cateName name:@"目录.txt"];
                
                __strong typeof(self) strongSelf = weakSelf;
                
                if( [strongSelf getBookList] )
                {
                    [strongSelf.tableView reloadData];
                }
                
                [SVProgressHUD showSuccessWithStatus:@"下载完成"];
                
            }failed:^{
                
                [SVProgressHUD showErrorWithStatus:@"下载失败，请稍后重试！"];
                
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"BookListTableViewCell";
    
    BookListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if( !cell )
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:cellId owner:self options:nil]lastObject];
    }
    
    [cell refreshCell:self.listArray[indexPath.row] cate:self.cateName];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookBriefViewController * vc = [[BookBriefViewController alloc]initWithNibName:@"BookBriefViewController" bundle:nil];
    vc.dir = self.cateName;
    vc.bookName = ((BookSimpleInfo*)(self.listArray[indexPath.row])).name;
    vc.bookDesc = ((BookSimpleInfo*)(self.listArray[indexPath.row])).desc;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma DownLoad
-(BOOL)getBookList
{
    NSData * data = [FileManager getFileData:[NSString stringWithFormat:@"%@",self.cateName] name:@"目录.txt"];
    NSDictionary * dict = [data objectFromJSONData];
    if( dict )
    {
        NSArray * array = dict[@"list"];
        for(NSDictionary * d in array )
        {
            BookSimpleInfo * info = [BookSimpleInfo new];
            [info fromDict:d];
            [self.listArray addObject:info];
        }
        
        return YES;
    }
    
    return NO;
}



#pragma Init
-(NSMutableArray*)listArray
{
    if( !_listArray )
    {
        _listArray = [NSMutableArray new];
    }
    
    return _listArray;
}


@end
