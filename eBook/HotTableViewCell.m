//
//  HotTableViewCell.m
//  eBook
//
//  Created by zhuang chaoxiao on 15/11/6.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "HotTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "CommData.h"


@interface HotTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *faceImgView;

@property (weak, nonatomic) IBOutlet UILabel *book2Lab;

@property (weak, nonatomic) IBOutlet UILabel *book3Lab;
@property (weak, nonatomic) IBOutlet UILabel *book4Lab;

@end

@implementation HotTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)refreshCell:(HotInfo*)hotInfo
{
    _book2Lab.text = ((BookInfo*)(hotInfo.bookArray[1])).name;
    _book3Lab.text = ((BookInfo*)(hotInfo.bookArray[2])).name;
    _book4Lab.text = ((BookInfo*)(hotInfo.bookArray[3])).name;
    
    NSString * url = [NSString stringWithFormat:@"%@hot/%@",BASE_URL,hotInfo.face];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [_faceImgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"book"]];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * t = [touches anyObject];
    CGPoint pt = [t locationInView:self.contentView];
    CGFloat y = pt.y-8;
    
    UIView * sp0 = [self.contentView viewWithTag:1000];
    UIView * sp1 = [self.contentView viewWithTag:1001];
    UIView * sp2 = [self.contentView viewWithTag:1002];
    UIView * sp3 = [self.contentView viewWithTag:1003];
    

    int index = 0;
    
    if( (y > sp0.frame.origin.y) && (y < sp1.frame.origin.y))
    {
        NSLog(@"最热");
        
        index = 0;
    }
    else if( (y > sp1.frame.origin.y) && (y < sp2.frame.origin.y))
    {
        NSLog(@"热1");
        index = 1;
    }
    else if( (y > sp2.frame.origin.y) && (y < sp3.frame.origin.y))
    {
        NSLog(@"热2");
        index = 2;
    }
    else if( (y > sp3.frame.origin.y) )
    {
        NSLog(@"热3");
        index = 3;
    }
    
    //
    if( [_cellDelegate respondsToSelector:@selector(hotCellClicked:)] )
    {
        [_cellDelegate hotCellClicked:index];
    }
    
}

@end
