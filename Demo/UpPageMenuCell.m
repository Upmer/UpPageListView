//
//  UpPageMenuCell.m
//  UpPageListView
//
//  Created by tsuf on 2018/9/18.
//  Copyright © 2018年 tsuf. All rights reserved.
//

#import "UpPageMenuCell.h"

@interface UpPageMenuCell ()

@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation UpPageMenuCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UILabel *titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.titleLabel.textColor = UIColor.redColor;
    } else {
        self.titleLabel.textColor = UIColor.blackColor;
    }
}

@end
