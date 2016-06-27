//
//  DbCoreDataManager.m
//  DBShopping
//
//  Created by jiang on 16/4/22.
//  Copyright © 2016年 jiang. All rights reserved.
//

#import "DbCoreDataManager.h"
#import "CartViewController.h"
@interface DbCoreDataManager ()

@property (nonatomic, strong) NSManagedObjectContext *managerdObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managerObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistenstoreCoodinate;

@property (nonatomic, assign) int time;

@end


@implementation DbCoreDataManager

+ (DbCoreDataManager *)shareModule{
    static DbCoreDataManager *shareMAnager = nil;
    if (!shareMAnager) {
        shareMAnager = [[DbCoreDataManager alloc] init];
    }
    return shareMAnager;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _time = 0;
        _userNoLogin = [NSMutableDictionary dictionaryWithCapacity:10];
        _userLogin = [NSMutableDictionary dictionaryWithCapacity:10];
        _userLoginToken = [NSMutableDictionary dictionaryWithCapacity:10];
        _good = [NSMutableDictionary dictionaryWithCapacity:10];
        [_good setObject:_userLogin forKey:@"userLogin"];
        [_good setObject:_userNoLogin forKey:@"userNoLogin"];
        
        [self createEnviroment];
    }
    return self;
}

- (void) createEnviroment{
    _time += 1;
    //从应用程序中加载模型文件
    self.managerObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    //添加持久化存储库,传入模型对象,初始化persistentstoreCoodinate
    self.persistenstoreCoodinate = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managerObjectModel];
    //构建SQlite数据库文件的路径
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"DBUserInformation.data"]];
    NSError *error = nil;
    if (![_persistenstoreCoodinate addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error]) {
        [[NSFileManager defaultManager] removeItemAtURL:url error:nil];
        if (_time <= 1) {
            [self createEnviroment];
        }
        return;
    }
    else{
        self.managerdObjectContext = [[NSManagedObjectContext alloc] init];
        self.managerdObjectContext.persistentStoreCoordinator = self.persistenstoreCoodinate;
    }
    
}

- (BOOL)saveDataToCoreData{

    BOOL isSuccess = NO;
    NSError *error = nil;
    [_managerdObjectContext save:&error];
    if (!error) {
        isSuccess = YES;
       DBShoppingCart *shoppingCart = [_HTSET.managerModule getShoppingCartGoods];

        int count = 0;
        
        if (_HTSET.loginModule.isUserLogin) {
            
            NSString *str  = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
            
            NSDictionary *goods = [shoppingCart.goods objectForKey:@"userLogin"];
            
            for (NSDictionary *dic in [[goods objectForKey:str] objectForKey:@"loginsaveArray"]) {
               
                NSString *number = [dic objectForKey:@"number"];
                count += [number intValue];
            }
            
        _HTUI.shoppingCartNVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", count];

            
        }else{
            
        NSDictionary *goods = shoppingCart.goods;
            
        for (NSDictionary *dic  in [[goods objectForKey:@"userNoLogin"] objectForKey:@"saveArr"]) {
                    
                    NSString *number = [dic objectForKey:@"number"];
                    count += [number intValue];
            
        }
        _HTUI.shoppingCartNVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", count];
    }
       
    }
     return isSuccess;
}


- (DBShoppingCart *)getShoppingCartGoods{

//    NSString *email = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
//    
//    if (_HTSET.loginModule.isUserLogin) {
//        
//        NSFetchRequest *request = [[NSFetchRequest alloc] init];
//        request.entity = [NSEntityDescription entityForName:[NSString stringWithFormat:@"%@",email] inManagedObjectContext:_managerdObjectContext];
//        NSError *error = nil;
//        NSArray *arr = [_managerdObjectContext executeFetchRequest:request error:&error];
//        DBShoppingCart *shoppingCart = nil;
//        if ([arr count] > 0) {
//            shoppingCart = [arr lastObject];
//        }
//        if (!shoppingCart) {
//            shoppingCart = [NSEntityDescription insertNewObjectForEntityForName:email inManagedObjectContext:_managerdObjectContext];
//        }
//        return  shoppingCart;
//        
//    }else{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"DBShoppingCart" inManagedObjectContext:_managerdObjectContext];
    NSError *error = nil;
    NSArray *arr = [_managerdObjectContext executeFetchRequest:request error:&error];
    DBShoppingCart *shoppingCart = nil;
    if ([arr count] > 0) {
        
        shoppingCart = [arr lastObject];
    }
    if (!shoppingCart) {
        
        shoppingCart = [NSEntityDescription insertNewObjectForEntityForName:@"DBShoppingCart" inManagedObjectContext:_managerdObjectContext];
    }
        return shoppingCart;
        
//    }
    
    
}













@end
