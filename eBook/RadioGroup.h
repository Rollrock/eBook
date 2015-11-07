//
//  RadioGroup.h
//  freeAlarm
//
//  Created by zhuang chaoxiao on 15/10/28.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void(^RadioBlock)(NSInteger index);

@interface RadioGroup : NSObject


//+(id)share;
-(void)setGroup:(NSArray*)viewArray selectedIndex:(NSInteger)selectIndex block:(RadioBlock)b;

@end
