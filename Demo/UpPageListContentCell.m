//
//  UpPageListContentCell.m
//  UpPageListView
//
//  Created by tsuf on 2018/9/19.
//  Copyright © 2018年 tsuf. All rights reserved.
//

#import "UpPageListContentCell.h"

@interface UpPageListContentCell ()

@property (nonatomic, weak) UIView *mainView;

@end

@implementation UpPageListContentCell

- (void)bindContentView:(UIView *)contentView {
    if (self.mainView) { return; }
    _mainView = contentView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.mainView.frame = self.bounds;
}

@end
