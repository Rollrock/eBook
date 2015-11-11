//
//  BookDetailViewController.m
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/7.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "BookDetailViewController.h"
#import "SplitNSString.h"
#import "GlobalSetting.h"

@interface BookDetailViewController ()
{
}

@property(strong,nonatomic) UILabel * textLab;
@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view addSubview:self.textLab];
    self.textLab.text = _textStr;
    
    [self.textLab sizeToFit];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshColor) name:NOTI_REFRESH_BOOK_DETAIL_COLOR object:nil];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma InitView
-(UILabel*)textLab
{
    if( !_textLab )
    {
        _textLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 65 - 20)];
        _textLab.textAlignment = NSTextAlignmentLeft;
        _textLab.numberOfLines = 0;
        _textLab.font = [GlobalSetting getFont];
        
        _textLab.textColor = [GlobalSetting getColor][0];
        _textLab.backgroundColor = [UIColor clearColor];
        self.view.layer.contents = (id)((UIImage*)[GlobalSetting getColor][1]).CGImage;
    }
    
    return _textLab;
}

#pragma Event
-(void)refreshColor
{
    _textLab.textColor = [GlobalSetting getColor][0];
    self.view.layer.contents = (id)((UIImage*)[GlobalSetting getColor][1]).CGImage;
}

-(void)refreshFont
{
    _textLab.font = [GlobalSetting getFont];
    _textLab.text = _textStr;
    [self.textLab sizeToFit];
}
@end
