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
@property (weak, nonatomic) IBOutlet UIImageView *teFontView;


@property (weak, nonatomic) IBOutlet UIImageView *bgColorView0;
@property (weak, nonatomic) IBOutlet UIImageView *bgColorView1;
@property (weak, nonatomic) IBOutlet UIImageView *bgColorView2;
@property (weak, nonatomic) IBOutlet UIImageView *bgColorView3;


@property (weak, nonatomic) IBOutlet UIImageView *dayView;
@property (weak, nonatomic) IBOutlet UIImageView *nightView;


//
@property (weak, nonatomic) IBOutlet UIImageView *colorView1;
@property (weak, nonatomic) IBOutlet UIImageView *colorView2;
@property (weak, nonatomic) IBOutlet UIImageView *colorView3;
@property (weak, nonatomic) IBOutlet UIImageView *colorView4;
@property (weak, nonatomic) IBOutlet UIImageView *colorView5;
@property (weak, nonatomic) IBOutlet UIImageView *colorView6;
@property (weak, nonatomic) IBOutlet UIImageView *colorView7;


@property(strong,nonatomic) NSArray * colorArray;

@property(strong,nonatomic) RadioGroup * fontGroup;
@property(strong,nonatomic) RadioGroup * bgColorGroup;
@property(strong,nonatomic) RadioGroup * textColorGroup;
@property(strong,nonatomic) RadioGroup * dayNightGroup;


@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _styleLab.textColor = [GlobalSetting getColor][0];
    _styleLab.backgroundColor = [UIColor colorWithPatternImage:[GlobalSetting getColor][1]];
    _styleLab.font = [GlobalSetting getFont];
    
    self.title = @"设置";
    
    
    for( UIView * view in self.colorArray )
    {
        view.userInteractionEnabled = ![GlobalSetting getDayNightIndex];
    }
    
    //
    __weak typeof (self) weakSelf = self;
    
    [self.fontGroup setGroup:@[_xiaoFontView,_zhongFontView,_daFontView,_teFontView] selectedIndex:[GlobalSetting getFontIndex] block:^(NSInteger index){
        
        __strong typeof (self) strongSelf = weakSelf;
        
        strongSelf.styleLab.font = [GlobalSetting getFontOfIndex:index];
        [GlobalSetting setFontOfIndex:index];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_REFRESH_BOOK_DETAIL_FONT object:nil];
    }];
    
    
    [self.bgColorGroup setGroup:self.colorArray selectedIndex:[GlobalSetting getColorIndex] block:^(NSInteger index){
        
        __strong typeof (self) strongSelf = weakSelf;
        
        [GlobalSetting setColorOfIndex:index];
        
        strongSelf.styleLab.textColor = [GlobalSetting getColor][0];
        strongSelf.styleLab.backgroundColor = [UIColor colorWithPatternImage:[GlobalSetting getColor][1]];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_REFRESH_BOOK_DETAIL_COLOR object:nil];
        
    }];
 
    [self.dayNightGroup setGroup:@[_dayView,_nightView] selectedIndex:[GlobalSetting getDayNightIndex] block:^(NSInteger index){
    
        __strong typeof (self) strongSelf = weakSelf;
        
        [GlobalSetting setDayNightIndex:index];
        
        //night
        if( index == 1 )
        {
            for( UIView * view in strongSelf.colorArray )
            {
                view.userInteractionEnabled = NO;
            }
        }
        else
        {
            for( UIView * view in strongSelf.colorArray )
            {
                view.userInteractionEnabled = YES;
            }
        }
        
        strongSelf.styleLab.textColor = [GlobalSetting getColor][0];
        strongSelf.styleLab.backgroundColor = [UIColor colorWithPatternImage:[GlobalSetting getColor][1]];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_REFRESH_BOOK_DETAIL_COLOR object:nil];

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


#pragma Other

-(NSArray*)colorArray
{
    if( !_colorArray )
    {
        _colorArray =  @[_colorView1,_colorView2,_colorView3,_colorView4,_colorView5,_colorView6,_colorView7];
    }
    
    return _colorArray;
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
