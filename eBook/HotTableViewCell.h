//
//  HotTableViewCell.h
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/6.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StructInfo.h"

@protocol HotCellDelegate <NSObject>

-(void)hotCellClicked:(int)index;

@end


@interface HotTableViewCell : UITableViewCell

@property(weak,nonatomic) id<HotCellDelegate> cellDelegate;

-(void)refreshCell:(HotInfo*)hotInfo;

@end
