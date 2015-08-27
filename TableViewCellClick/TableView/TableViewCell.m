//
//  TableViewCell.m
//  TableView
//
//  Created by Craig Liao on 15/7/13.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell()

@property (nonatomic, strong) UILabel *nameLabel;


@property (nonatomic, strong) UIImageView *redImageView;


@end

@implementation TableViewCell

/**
 *  重写初始化方法
 *
 *  @param style           样式
 *  @param reuseIdentifier 标识符
 *
 *  @return self
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //cell名称标签
        self.nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.nameLabel];
        //红色图片视图
        self.redImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.redImageView];

    }
    return self;
}

/**
 *  布局
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    //如果高度为44 则隐藏imageView 如果为66 则显示
    if (self.frame.size.height == 44) {
        self.redImageView.hidden = YES;
    } else {
        self.redImageView.hidden = NO;
    }
    //nameLabel 布局
    self.nameLabel.frame = CGRectMake(0, 0, self.frame.size.width, 20);
    self.nameLabel.text = @"点击显示";
    //redImageView的布局
    self.redImageView.frame = CGRectMake(0, 20, self.frame.size.width, 40);
    self.redImageView.backgroundColor = [UIColor redColor];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
