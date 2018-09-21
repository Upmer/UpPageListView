//
//  UpContentCell.m
//  UpPageListView
//
//  Created by tsuf on 2018/9/19.
//  Copyright © 2018年 tsuf. All rights reserved.
//

#import "UpContentCell.h"
#import "UpContentItemCell.h"

@interface UpContentCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation UpContentCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCollectionView];
    }
    return self;
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 55);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView = collectionView;
    collectionView.backgroundColor = UIColor.whiteColor;
    [collectionView registerClass:[UpContentItemCell class] forCellWithReuseIdentifier:@"UpContentItemCell"];
    collectionView.contentInset = UIEdgeInsetsMake(60, 0, 5, 0);
    collectionView.alwaysBounceVertical = YES;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self addSubview:collectionView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

- (void)setItems:(NSArray<Item *> *)items {
    _items = items;
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UpContentItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UpContentItemCell" forIndexPath:indexPath];
    cell.title = self.items[indexPath.item].name;
    return cell;
}

@end
