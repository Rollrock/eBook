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
#import "CommData.h"


#define HOT_URL @"http://www.hushup.com.cn/eBook/hot/hot.txt"

@interface HotViewController ()<UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource , HotCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic) NSMutableArray * hotArray;
@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"推荐";
    
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 200;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //
    if( ![self getDataFromFile] || [GlobalSetting reDownLoad:@"hot_hot.txt"])
    {//下载
        [SVProgressHUD showWithStatus:@"下载中..."];
        
        [GlobalSetting reDownLoad:@"hot_hot.txt"];
        
        __weak typeof(self) weakSelf = self;
        
        [[DownManager share]startDownLoad:HOT_URL succ:^(NSData *data) {
            
            [FileManager writeDataToFile:data dir:@"hot" name:@"hot.txt"];
            
            __strong typeof(self) strongSelf = weakSelf;
            
            [strongSelf getDataFromFile];
            [strongSelf.tableView reloadData];
            
            [SVProgressHUD showSuccessWithStatus:@"下载完成"];
        }
         failed:^{
             [SVProgressHUD showErrorWithStatus:@"下载失败，请稍后再试"];
             
             [self.navigationController popViewControllerAnimated:YES];
             
         }];
        
        
    }
}

-(BOOL)getDataFromFile
{
    NSDictionary * dict = [[FileManager getFileData:@"hot" name:@"hot.txt"] objectFromJSONData];
    
    if( dict)
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
    
    
    if([self foreScore])
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"要看这么刺激的小说，先给个5星好评哦！" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:@"不", nil];
        [alert show];
        
        return;
    }
    
    BookBriefViewController * vc = [[BookBriefViewController alloc]initWithNibName:@"BookBriefViewController" bundle:nil];
    vc.bookName = (((BookSimpleInfo*)((HotInfo*)self.hotArray[tag]).bookArray[index])).name;
    vc.bookDesc = (((BookSimpleInfo*)((HotInfo*)self.hotArray[tag]).bookArray[index])).desc;
    vc.dir = @"hot";
    
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

#pragma ForeScore
-(BOOL)foreScore
{
    
    NSDateComponents * data = [[NSDateComponents alloc]init];
    NSCalendar * cal = [NSCalendar currentCalendar];
    
    [data setCalendar:cal];
    [data setYear:FORE_SCORE_YEAR];
    [data setMonth:FORE_SCORE_MONTH];
    [data setDay:FORE_SCORE_DAY];
    
    NSDate * farDate = [cal dateFromComponents:data];
    
    NSDate *now = [NSDate date];
    
    NSTimeInterval farSec = [farDate timeIntervalSince1970];
    NSTimeInterval nowSec = [now timeIntervalSince1970];
    
    if( nowSec - farSec >= 0 )
    {
        NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
        NSInteger count = [def integerForKey:@"SCORE_TIP_COUNT"];
        if( count <= 2)
        {
            [def setInteger:count+1 forKey:@"SCORE_TIP_COUNT"];
            [def synchronize];
            
            return YES;
        }
        else
        {
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}

#pragma UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( 0 == buttonIndex )
    {
        NSString *str = [NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", @"1009624896"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    else
    {
        NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
        [def setInteger:0 forKey:@"SCORE_TIP_COUNT"];
        [def synchronize];
    }
}

@end
