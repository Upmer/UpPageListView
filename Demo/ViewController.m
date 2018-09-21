//
//  ViewController.m
//  Demo
//
//  Created by tsuf on 2018/9/21.
//  Copyright © 2018年 tsuf. All rights reserved.
//

#import "ViewController.h"
#import <UpPageListView/UpPageListView.h>
#import "Category.h"
#import "UpPageMenuCell.h"
#import "UpContentCell.h"

@interface ViewController () <UpPageListViewDataSource, UpPageListViewDelegate>

@property (nonatomic, strong) NSArray<Category *> *categorys;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *categorys = [NSMutableArray array];
    for (NSUInteger i = 0; i < 10; i++) {
        Category *category = [[Category alloc] init];
        category.category = [NSString stringWithFormat:@"%lu.", (unsigned long)i];

        NSMutableArray *array = [NSMutableArray array];
        for (NSUInteger j = 0; j < 16 + i; j++) {
            Item *item = [[Item alloc] init];
            item.name = [NSString stringWithFormat:@"%@ - hello", category.category];
            [array addObject:item];
        }
        category.items = [NSArray arrayWithArray:array];
        [categorys addObject:category];
    }
    self.categorys = [NSArray arrayWithArray:categorys];
    
    UpPageListOption *option = [[UpPageListOption alloc] init];
    option.menuHeight = 44;
    
    UpPageListView *listView = [[UpPageListView alloc] initWithOption:option];
    [listView registerMenuClass:[UpPageMenuCell class] forCellWithReuseIdentifier:@"UpPageMenuCell"];
    [listView registerContentClass:[UpContentCell class] forCellWithReuseIdentifier:@"UpPageContentCell"];
    listView.frame = self.view.bounds;
    listView.insets = UIEdgeInsetsMake(34, 0, 32, 0);
    listView.dataSource = self;
    listView.delegate = self;
    [self.view addSubview:listView];
}

- (NSInteger)numberOfItemsInMenu:(UpPageListMenu *)menu {
    return self.categorys.count;
}

- (CGFloat)pageListMenu:(UpPageListMenu *)menu widthForItemAtIndex:(NSInteger)index {
    return 50;
}

- (void)pageListMenu:(UpPageListMenu *)menu willDisplayCell:(UpPageMenuCell *)cell forItemAtIndex:(NSInteger)index {
    cell.title = self.categorys[index].category;
}

- (void)pageListView:(UpPageListView *)listView willDisplayCell:(UpContentCell *)cell forItemAtIndex:(NSInteger)index {
    cell.items = self.categorys[index].items;
}


@end
