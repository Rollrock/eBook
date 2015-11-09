//
//  BookPageViewController.h
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/7.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookPageViewController : UIViewController
@property(copy,nonatomic) NSString * bookName;//
@property(copy,nonatomic) NSString * bookDir;//
@property(copy,nonatomic) NSArray * listArray;//存放目录
@property(assign,nonatomic) NSInteger curUint;//当前章节
@end
