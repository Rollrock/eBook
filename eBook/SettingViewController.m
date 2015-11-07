//
//  SettingViewController.m
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/6.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "SettingViewController.h"
#import "GlobalSetting.h"
#import "RadioGroup.h"

@interface SettingViewController ()

@property (weak, nonatomic) IBOutlet UILabel *styleLab;

@property (weak, nonatomic) IBOutlet UIImageView *xiaoFontView;
@property (weak, nonatomic) IBOutlet UIImageView *zhongFontView;
@property (weak, nonatomic) IBOutlet UIImageView *daFontView;


@property (weak, nonatomic) IBOutlet UIImageView *bgColorView0;
@property (weak, nonatomic) IBOutlet UIImageView *bgColorView1;
@property (weak, nonatomic) IBOutlet UIImageView *bgColorView2;
@property (weak, nonatomic) IBOutlet UIImageView *bgColorView3;



@property (weak, nonatomic) IBOutlet UIImageView *textColorView0;
@property (weak, nonatomic) IBOutlet UIImageView *textColorView1;
@property (weak, nonatomic) IBOutlet UIImageView *textColorView2;
@property (weak, nonatomic) IBOutlet UIImageView *textColorView3;

@property (weak, nonatomic) IBOutlet UIImageView *dayView;
@property (weak, nonatomic) IBOutlet UIImageView *nightView;




@property(strong,nonatomic) RadioGroup * fontGroup;
@property(strong,nonatomic) RadioGroup * bgColorGroup;
@property(strong,nonatomic) RadioGroup * textColorGroup;
@property(strong,nonatomic) RadioGroup * dayNightGroup;


@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _styleLab.textColor = [GlobalSetting getTextColor];
    _styleLab.backgroundColor = [GlobalSetting getBgColor];
    _styleLab.font = [GlobalSetting getFont];
    
    
    __weak typeof (self) weakSelf = self;
    
    [self.fontGroup setGroup:@[_xiaoFontView,_zhongFontView,_daFontView] selectedIndex:[GlobalSetting getFontIndex] block:^(NSInteger index){
        
        __strong typeof (self) strongSelf = weakSelf;
        
        strongSelf.styleLab.font = [GlobalSetting getFontOfIndex:index];
        [GlobalSetting setFontOfIndex:index];
    }];
     
    

    [self.bgColorGroup setGroup:@[_bgColorView0,_bgColorView1,_bgColorView2,_bgColorView3] selectedIndex:[GlobalSetting getBgColorIndex] block:^(NSInteger index){
        
        __strong typeof (self) strongSelf = weakSelf;
        strongSelf.styleLab.backgroundColor = [GlobalSetting getBgColorOfIndex:index];
        [GlobalSetting setBgColorOfIndex:index];
        
    }];

    
    [self.textColorGroup setGroup:@[_textColorView0,_textColorView1,_textColorView2,_textColorView3] selectedIndex:[GlobalSetting getTextColorIndex] block:^(NSInteger index){
        
        __strong typeof (self) strongSelf = weakSelf;
        strongSelf.styleLab.textColor = [GlobalSetting getTextColorOfIndex:index];
        [GlobalSetting setTextColorOfIndex:index];
        
    }];
    
    [self.dayNightGroup setGroup:@[_dayView,_nightView] selectedIndex:[GlobalSetting getTextColorIndex] block:^(NSInteger index){
        
        /*
        __strong typeof (self) strongSelf = weakSelf;
        strongSelf.styleLab.textColor = [GlobalSetting getTextColorOfIndex:index];
        [GlobalSetting setTextColorOfIndex:index];
         */
        
    }];
}



#pragma InitView
-(RadioGroup*)fontGroup
{
    if( !_fontGroup )
    {
        _fontGroup = [[RadioGroup alloc] init];
    }
    return _fontGroup;
}

-(RadioGroup*)bgColorGroup
{
    if( !_bgColorGroup )
    {
        _bgColorGroup = [[RadioGroup alloc] init];
    }
    return _bgColorGroup;
}

-(RadioGroup*)textColorGroup
{
    if( !_textColorGroup )
    {
        _textColorGroup = [[RadioGroup alloc] init];
    }
    return _textColorGroup;
}

-(RadioGroup*)dayNightGroup
{
    if( !_dayNightGroup )
    {
        _dayNightGroup = [[RadioGroup alloc]init];
    }
    
    return _dayNightGroup;
}

#pragma System
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
