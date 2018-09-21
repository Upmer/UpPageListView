//
//  Category.h
//  UpPageListView
//
//  Created by tsuf on 2018/9/19.
//  Copyright © 2018年 tsuf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic, copy) NSString *name;

@end

@interface Category : NSObject

@property (nonatomic, copy) NSString *category;
@property (nonatomic, strong) NSArray<Item *> *items;

@end
