//
//  HotViewController.m
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/6.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "HotViewController.h"
#import "HotTableViewCell.h"
#import "DownManager.h"
#import "FileManager.h"
#import "JSONKit.h"
#import "StructInfo.h"
#import "BookBriefViewController.h"
#import "SVProgressHUD.h"


#define HOT_URL @"http://www.hushup.com.cn/eBook/hot/hot.txt"

@interface HotViewController ()<UITableViewDelegate,UITableViewDataSource , HotCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic) NSMutableArray * hotArray;
@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 200;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    //
    if( ![self getDataFromFile] )
        //下载
    {
        [SVProgressHUD showWithStatus:@"下载中..."];
        
        __weak typeof(self) weakSelf = self;
        
        [[DownManager share]startDownLoad:HOT_URL succ:^(NSData *data) {
            
            [FileManager writeDataToFile:data dir:@"hot" name:@"hot.txt"];
            
            __strong typeof(self) strongSelf = weakSelf;
            
            [strongSelf getDataFromFile];
            [strongSelf.tableView reloadData];
            
        }];
        
        [SVProgressHUD showSuccessWithStatus:@"下载完成"];
    }
}

-(BOOL)getDataFromFile
{
    NSDictionary * dict = [[FileManager getFileData:@"hot" name:@"hot.txt"] objectFromJSONData];
    
    if( dict )
    {
        NSArray * arr = dict[@"info"];
        for( NSDictionary*d in arr)
        {
            HotInfo * info = [HotInfo new];
            [info fromDict:d];
            [self.hotArray addObject:info];
        }
        
        return YES;
    }
    
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.hotArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"HotTableViewCell";
    
    HotTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if( !cell )
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:cellId owner:self options:nil]lastObject];
    }
    
    cell.tag = indexPath.row;
    cell.cellDelegate = self;
    
    [cell refreshCell:self.hotArray[indexPath.row]];
    
    return cell;
}

#pragma HotCellDelegate
-(void)hotCellClicked:(int)index tag:(int)tag
{
    NSLog(@"hotCellClicked:%d",index);
    
    BookBriefViewController * vc = [[BookBriefViewController alloc]initWithNibName:@"BookBriefViewController" bundle:nil];
    vc.bookName = (((BookSimpleInfo*)((HotInfo*)self.hotArray[tag]).bookArray[index])).name;
    vc.bookDesc = (((BookSimpleInfo*)((HotInfo*)self.hotArray[tag]).bookArray[index])).desc;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma InitData
-(NSMutableArray*)hotArray
{
    if( !_hotArray )
    {
        _hotArray = [NSMutableArray new];
    }
    
    return _hotArray;
}
@end
