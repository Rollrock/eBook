//
//  BookListTableViewCell.m
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/8.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "BookListTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface BookListTableViewCell()
{
    
}

@property (weak, nonatomic) IBOutlet UIImageView *faceImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *descLab;

@end

@implementation BookListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)refreshCell:(BookSimpleInfo*)info cate:(NSString *)cateName
{
    _nameLab.text = info.name;
    _descLab.text = info.desc;
    
    
    NSString * url = [NSString stringWithFormat:@"%@%@/封面/%@.png",BASE_URL,cateName,info.name];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [_faceImgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"book"]];
    
    
}

@end
