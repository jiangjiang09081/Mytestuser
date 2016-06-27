//
//  DBActivityModule.h
//  DBShopping
//
//  Created by jiang on 16/4/20.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DBBaseModule.h"

@interface DBActivityModule : DBBaseModule

+ (DBActivityModule *)ShareModule;

- (void)getRegimentListWithType:(NSString *)type
                        success:(void(^)(id responseObject, NSError *error))finished;




@end
