//
//  BookView.m
//  TestApp
//
//  Created by zhuang chaoxiao on 15/11/6.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "BookView.h"

@interface BookView()
{
    UIImage * image;
}

@property(strong,nonatomic) UIImageView * imgView;
@property(strong,nonatomic) UIButton * delBtn;
@property(strong,nonatomic) UIImageView * bgView;
@end


@implementation BookView

-(id)initWithFrame:(CGRect)frame img:(UIImage*)img
{
    self = [super initWithFrame:frame];
    
    if( self )
    {
        image = img;
        
        //self.layer.shadowColor = [UIColor lightGrayColor].CGColor;  //[UIColor colorWithRed:1 green:255/255 blue:255/255 alpha:1].CGColor; //[UIColor blackColor].CGColor;
        //self.layer.shadowOffset = CGSizeMake(5, 5);
        //self.layer.shadowOpacity = 0.7;
        
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;

        [self addSubview:self.bgView];
        [self addSubview:self.imgView];
        [self addSubview:self.delBtn];
        
        [self addGesture];
    }
    
    return  self;
}


#pragma Init

-(UIButton*)delBtn
{
    if( !_delBtn )
    {
        _delBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        _delBtn.hidden = YES;
        [_delBtn setBackgroundImage:[UIImage imageNamed:@"del"] forState:UIControlStateNormal];
        
        [_delBtn addTarget:self action:@selector(delClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _delBtn;
}

-(UIImageView*)imgView
{
    if( !_imgView )
    {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width-6, self.bounds.size.height-8)];
        _imgView.image = image?image:[UIImage imageNamed:@"book"];
    }
    
    return  _imgView;
}

-(UIImageView*)bgView
{
    if( !_bgView )
    {
        _bgView = [[UIImageView alloc]initWithFrame:self.bounds];
        _bgView.image = [UIImage imageNamed:@"book_bg_1"];
    }
    
    return _bgView;
}

#pragma Gesture

-(void)addGesture
{
    UITapGestureRecognizer * tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClicked)];
    [self addGestureRecognizer:tapG];
    
    UILongPressGestureRecognizer * longG = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [self addGestureRecognizer:longG];
}

-(void)tapClicked
{
    self.delBtn.hidden = YES;
    
    //
    if( [_clickDelegate respondsToSelector:@selector(tapClicked:)] )
    {
        [_clickDelegate tapClicked:self.tag];
    }
}

-(void)longPress:(UILongPressGestureRecognizer*)g
{
    if( ([_clickDelegate respondsToSelector:@selector(longPress)])  && (g.state == UIGestureRecognizerStateBegan))
    {
        //[_clickDelegate longPress];
        
        self.delBtn.hidden = NO;
    }
}


#pragma Actions
-(void)delClicked
{
    if( [_clickDelegate respondsToSelector:@selector(delClicked:)] )
    {
        [_clickDelegate delClicked:self.tag];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
