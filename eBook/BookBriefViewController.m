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
#import "SVProgressHUD.h"
#import "DownManager.h"
#import "FileManager.h"
#import "CommData.h"
#import "SSZipArchive.h"
#import "UIImageView+WebCache.h"

@interface BookBriefViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic) BookDetailInfo * bookInfo;
@property (weak, nonatomic) IBOutlet UIImageView *faceImgView;
@property (weak, nonatomic) IBOutlet UITextView *descTextView;

- (IBAction)readClicked;
- (IBAction)addToShelf;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation BookBriefViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initData];
    
    /*
    //
       */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma InitData
-(BookDetailInfo*)bookInfo
{
    if( !_bookInfo )
    {
        _bookInfo = [BookDetailInfo new];
    }
    
    return _bookInfo;
}

-(void)initData
{
    NSString * url = [NSString stringWithFormat:@"%@hot/封面/%@.PNG",BASE_URL,self.bookName];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self.faceImgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"book"]];
    
    _descTextView.text = self.bookDesc;
    
    [self getBookList];
}

-(void)getBookList
{
    NSData * data = [FileManager getFileData:[NSString stringWithFormat:@"hot/%@",self.bookName] name:@"介绍.txt"];
    NSDictionary * dict = [data objectFromJSONData];
    if( dict )
    {
        self.bookInfo = nil;
        
        [self.bookInfo fromDict:dict];
        [self.tableView reloadData];
    }
}

#pragma UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bookInfo.uintArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * strId = @"cellId";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strId];
    
    if( !cell )
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strId];
    }
    
    cell.textLabel.text = ((UnitInfo*)(self.bookInfo.uintArray[indexPath.row])).uintKey;
    cell.detailTextLabel.text = ((UnitInfo*)(self.bookInfo.uintArray[indexPath.row])).uintName;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookPageViewController * vc = [[BookPageViewController alloc]initWithNibName:@"BookPageViewController" bundle:nil];
    vc.listArray = self.bookInfo.uintArray;
    vc.curUint = indexPath.row;
    vc.bookName = self.bookName;
    vc.bookDir = @"hot";
    
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma Custom Event

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

- (IBAction)addToShelf
{
    [SVProgressHUD showWithStatus:@"下载中..."];
    
    NSString * url = [NSString stringWithFormat:@"%@hot/%@.zip",BASE_URL,self.bookName];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    __weak typeof(self) weakSelf = self;
    
    [[DownManager share]startDownLoad:url succ:^(NSData *data) {
        
        [FileManager writeDataToFile:data dir:@"hot" name:[NSString stringWithFormat:@"%@.zip",self.bookName]];
        
        __strong typeof(self) strongSelf = weakSelf;
        
        [FileManager unZipFile:@"hot" name:self.bookName];
        
        [strongSelf getBookList];
        
        
    }];
    
    [SVProgressHUD showSuccessWithStatus:@"下载完成"];

}
@end
