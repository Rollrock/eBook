//
//  BookBriefViewController.h
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/6.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BookBriefViewController : BaseViewController
@property(copy,nonatomic) NSString * bookName;
@property(copy,nonatomic) NSString * bookDesc;
@property(copy,nonatomic) NSString * dir;
@end
