//
//  DBShoppingModule.h
//  DBShopping
//
//  Created by jiang on 16/4/6.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBBaseModule.h"

@interface DBShoppingModule : DBBaseModule

+ (DBShoppingModule *)shareModule;

//获取海外幻灯片
- (void)getMobileSlide:(void (^)(id responseObject,NSError *error))finished;

/**
 *  获取搜索结果
 */
- (void)getSearchResultWithKeyWords:(NSString *)keyword
                             finish:(void (^)(id responseObject, NSError *error))finished;

@end
