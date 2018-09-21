//
//  UpContentCell.h
//  UpPageListView
//
//  Created by tsuf on 2018/9/19.
//  Copyright © 2018年 tsuf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Category.h"

NS_ASSUME_NONNULL_BEGIN

@interface UpContentCell : UICollectionViewCell

@property (nonatomic, weak) NSArray<Item *> *items;

@end

NS_ASSUME_NONNULL_END
