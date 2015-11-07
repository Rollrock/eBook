//
//  BookView.h
//  TestApp
//
//  Created by zhuang chaoxiao on 15/11/6.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>


//typedef void(^TapClickedBlock)(NSInteger index);


@protocol ClickDelegate <NSObject>

-(void)tapClicked;
-(void)longPress;
-(void)delClicked:(NSInteger)tag;

@end


@interface BookView : UIView

-(id)initWithFrame:(CGRect)frame imgName:(NSString*)name;

@property( weak,nonatomic) id<ClickDelegate> clickDelegate;

@end
