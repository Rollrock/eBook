//
//  BookListTableViewCell.h
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/8.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommData.h"
#import "StructInfo.h"
@interface BookListTableViewCell : UITableViewCell

-(void)refreshCell:(BookSimpleInfo*)info cate:(NSString*)cateName;
@end
