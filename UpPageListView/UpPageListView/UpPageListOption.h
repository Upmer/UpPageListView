//
//  UpPageListOption.h
//  UpPageListView
//
//  Created by tsuf on 2018/9/19.
//  Copyright © 2018年 tsuf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UpPageListOption : NSObject

@property (nonatomic, assign) CGFloat menuWidth;
@property (nonatomic, assign) CGFloat menuHeight;
@property (nonatomic, assign) Class menuCellClass;
@property (nonatomic, copy) NSString *menuCellIdentifier;
@property (nonatomic, assign) Class contentCellClass;
@property (nonatomic, copy) NSString *contentCellIdentifier;

@end

NS_ASSUME_NONNULL_END
