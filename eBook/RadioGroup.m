//
//  RadioGroup.m
//  freeAlarm
//
//  Created by zhuang chaoxiao on 15/10/28.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "RadioGroup.h"


#define  UNSELECT_COLOR  [UIColor clearColor]
#define  SELECTED_COLOR [UIColor colorWithRed:164/255.0 green:61/255.0 blue:75/255.0 alpha:1]//[UIColor lightGrayColor]


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

/*
+(id)share
{
    static RadioGroup * group = nil;
    static dispatch_once_t once;

    dispatch_once(&once,^(void){
        group = [RadioGroup new];
    });
    
    return group;
}
 */

-(void)setGroup:(NSArray*)viewArray selectedIndex:(NSInteger)selectIndex block:(RadioBlock)b
{
    self.viewArray = [viewArray mutableCopy];
    
    for( NSInteger index = 0; index < self.viewArray.count; ++ index  )
    {
        UIView * view = self.viewArray[index];
        view.tag = index;
        view.userInteractionEnabled = YES;
        
        view.backgroundColor = (index == selectIndex)? SELECTED_COLOR:UNSELECT_COLOR;
        
        
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
        view.backgroundColor = UNSELECT_COLOR;
        
        if( g.view.tag == index )
        {
            view.backgroundColor = SELECTED_COLOR;
        }
    }
    
    if( rBlock )
    {
        rBlock(g.view.tag);
    }
}

@end
