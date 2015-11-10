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
@property (weak, nonatomic) IBOutlet UIButton *addToShelfBtn;

- (IBAction)readClicked;
- (IBAction)addToShelf;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation BookBriefViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initData];
    
    [self customView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma InitData

-(void)customView
{
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClicked)];
    leftBtn.tintColor = COMMON_BG_COLOR;
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    
    //self.title = @"金瓶梅";
}

-(void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}


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
    NSString * url = [NSString stringWithFormat:@"%@%@/封面/%@.PNG",BASE_URL,self.dir, self.bookName];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self.faceImgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"book"]];
    
    _descTextView.text = self.bookDesc;
    
    [self getBookList];
}

-(void)getBookList
{
    NSData * data = [FileManager getFileData:[NSString stringWithFormat:@"%@/%@",self.dir, self.bookName] name:@"介绍.txt"];
    NSDictionary * dict = [data objectFromJSONData];
    if( dict )
    {
        _addToShelfBtn.enabled = NO;
        [_addToShelfBtn setTitle:@"已在书架" forState:UIControlStateNormal];
        
        //
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
    vc.bookDir = self.dir;
    vc.curPage = 0;
    
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma Custom Event

- (IBAction)readClicked
{
    ReadInfo * info = [ReadInfo new];
    info.bookName = self.bookName;
    info.dirName = self.dir;
    info = [GlobalSetting getReadInfo:info];
    
    BookPageViewController * vc = [[BookPageViewController alloc]initWithNibName:@"BookPageViewController" bundle:nil];
    vc.listArray = self.bookInfo.uintArray;
    vc.curUint = [info.lastUint integerValue];
    vc.curPage = [info.lastPage integerValue];
    vc.bookName = self.bookName;
    vc.bookDir = self.dir;
    
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)addToShelf
{
    [SVProgressHUD showWithStatus:@"下载中..."];
    
    NSString * url = [NSString stringWithFormat:@"%@%@/%@.zip",BASE_URL,self.dir, self.bookName];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    __weak typeof(self) weakSelf = self;
    
    [[DownManager share]startDownLoad:url succ:^(NSData *data) {
        
        [FileManager writeDataToFile:data dir:self.dir name:[NSString stringWithFormat:@"%@.zip",self.bookName]];
        
        __strong typeof(self) strongSelf = weakSelf;
        
        [FileManager unZipFile:self.dir name:self.bookName];
        
        [strongSelf getBookList];
        
        
    }];
    
    [SVProgressHUD showSuccessWithStatus:@"下载完成"];

}
@end
