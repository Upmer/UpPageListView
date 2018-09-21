//
//  UpPageListView.h
//  UpPageListView
//
//  Created by tsuf on 2018/9/19.
//  Copyright © 2018年 tsuf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpPageListMenu.h"
#import "UpPageListOption.h"
@class UpPageListView;

NS_ASSUME_NONNULL_BEGIN

@protocol UpPageListViewDataSource <NSObject>

@required
- (NSInteger)numberOfItemsInMenu:(UpPageListMenu *)menu;
- (CGFloat)pageListMenu:(UpPageListMenu *)menu widthForItemAtIndex:(NSInteger)index;

@end

@protocol UpPageListViewDelegate <NSObject>

- (void)pageListMenu:(UpPageListMenu *)menu willDisplayCell:(UICollectionViewCell *)cell forItemAtIndex:(NSInteger)index;
- (void)pageListView:(UpPageListView *)listView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndex:(NSInteger)index;

@end

@interface UpPageListView : UIView

- (instancetype)initWithOption:(UpPageListOption *)option;

@property (nonatomic, weak) id<UpPageListViewDataSource> dataSource;
@property (nonatomic, weak) id<UpPageListViewDelegate> delegate;

@property (nonatomic, assign) UIEdgeInsets insets;

- (void)registerMenuClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
- (void)registerContentClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
