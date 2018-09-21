//
//  UpPageListView.m
//  UpPageListView
//
//  Created by tsuf on 2018/9/19.
//  Copyright © 2018年 tsuf. All rights reserved.
//

#import "UpPageListView.h"

@interface UpPageListView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UpPageListOption *option;

@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) UpPageListMenu *menu;
@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation UpPageListView {
    CGFloat MenuHeight;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithOption:(UpPageListOption *)option {
    if (self = [super initWithFrame:CGRectZero]) {
        self.option = option;
        [self setupUI];
    }
    return self;
}

- (instancetype)init {
    UpPageListOption *option = [[UpPageListOption alloc] init];
    option.menuHeight = 60;
    if (self  = [self initWithOption:option]) {
        self.option = option;
    }
    return self;
}

- (void)setInsets:(UIEdgeInsets)insets {
    _insets = insets;
    [self layoutSubviews];
}

- (void)setupUI {
    self.selectedIndex = 0;
    UIView *contentView = [[UIView alloc] init];
    self.contentView = contentView;
    [self addSubview:self.contentView];
    [self setupCollectionView];
    [self setupMenu];
}

- (void)setupMenu {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UpPageListMenu *menu = [[UpPageListMenu alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.menu = menu;
    menu.backgroundColor = UIColor.whiteColor;
    menu.showsHorizontalScrollIndicator = NO;
    menu.dataSource = self;
    menu.delegate = self;
    [self.contentView addSubview:menu];
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView = collectionView;
    collectionView.backgroundColor = UIColor.whiteColor;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.alwaysBounceVertical = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.contentView addSubview:collectionView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = CGRectMake(self.insets.left, self.insets.top, self.bounds.size.width - (self.insets.left + self.insets.right), self.bounds.size.height - (self.insets.top + self.insets.bottom));
    self.menu.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.option.menuHeight);
    self.collectionView.frame = self.contentView.bounds;
}

- (void)registerMenuClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier {
    self.option.menuCellClass = cellClass;
    self.option.menuCellIdentifier = identifier;
    [self.menu registerClass:cellClass forCellWithReuseIdentifier:identifier];
}

- (void)registerContentClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier {
    self.option.contentCellClass = cellClass;
    self.option.contentCellIdentifier = identifier;
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}

- (BOOL)isMenu:(UICollectionView *)collectionView {
    return collectionView == self.menu;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (_selectedIndex == selectedIndex) { return; }
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForItem:_selectedIndex inSection:0];
    _selectedIndex = selectedIndex;
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForItem:selectedIndex inSection:0];
    [self.menu scrollToItemAtIndexPath:selectedIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    [self.menu reloadItemsAtIndexPaths:@[oldIndexPath, selectedIndexPath]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource numberOfItemsInMenu:self.menu];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isMenu:collectionView]) {
        CGFloat width = [self.dataSource pageListMenu:self.menu widthForItemAtIndex:indexPath.row];
        return CGSizeMake(width, self.option.menuHeight);
    } else {
        return collectionView.bounds.size;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isMenu:collectionView]) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.option.menuCellIdentifier forIndexPath:indexPath];
        cell.selected = (indexPath.item == self.selectedIndex);
        return cell;
    } else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.option.contentCellIdentifier forIndexPath:indexPath];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    if ([self isMenu:collectionView]) {
        [self.delegate pageListMenu:self.menu willDisplayCell:cell forItemAtIndex:index];
    } else {
        [self.delegate pageListView:self willDisplayCell:cell forItemAtIndex:index];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isMenu:collectionView]) {
        NSInteger index = indexPath.row;
        CGFloat offsetX = self.bounds.size.width * index;
        [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        self.selectedIndex = index;
    } else {
        
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (scrollView == self.collectionView) {
        CGFloat offsetX = targetContentOffset -> x;
        NSInteger page = offsetX / self.bounds.size.width;
        self.selectedIndex = page;
    }
}

@end
