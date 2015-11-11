//
//  RadioGroup.m
//  freeAlarm
//
//  Created by zhuang chaoxiao on 15/10/28.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "RadioGroup.h"
#import "CommData.h"


#define  UNSELECT_COLOR  [UIColor clearColor].CGColor
#define  SELECTED_COLOR (COMMON_BG_COLOR.CGColor)   //[UIColor lightGrayColor]


@interface RadioGroup()
{
    RadioBlock rBlock;
}

@property(nonatomic,copy)NSMutableArray * viewArray;

@end


@implementation RadioGroup


-(NSMutableArray*)viewArray
{
    if( !_viewArray )
    {
        _viewArray = [NSMutableArray new];
    }
    
    return _viewArray;
}

-(void)setGroup:(NSArray*)viewArray selectedIndex:(NSInteger)selectIndex block:(RadioBlock)b
{
    self.viewArray = [viewArray mutableCopy];
    
    for( NSInteger index = 0; index < self.viewArray.count; ++ index  )
    {
        UIView * view = self.viewArray[index];
        view.tag = index;
        
        view.layer.borderColor = (index == selectIndex)? SELECTED_COLOR:UNSELECT_COLOR;
        view.layer.borderWidth = 2;
        
        
        UITapGestureRecognizer * g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClicked:)];
        [view addGestureRecognizer:g];
    }
    
    rBlock = [b copy];
}


-(void)viewClicked:(UITapGestureRecognizer*)g
{
    for( NSInteger index = 0; index < self.viewArray.count; ++ index )
    {
        UIView * view = self.viewArray[index];
        view.layer.borderColor = UNSELECT_COLOR;
        
        if( g.view.tag == index )
        {
            view.layer.borderColor = SELECTED_COLOR;
        }
    }
    
    if( rBlock )
    {
        rBlock(g.view.tag);
    }
}

@end
