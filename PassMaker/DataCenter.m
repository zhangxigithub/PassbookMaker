//
//  DataCenter.m
//  PassMaker
//
//  Created by 张 玺 on 13-11-21.
//  Copyright (c) 2013年 zhangxi. All rights reserved.
//

#define kStoreKey @"kStoreKey"


#import "DataCenter.h"
#import <AFNetworking.h>
#import <MobClick.h>

@implementation DataCenter

static DataCenter *dataCenter;
+(DataCenter *)sharedDataCenter
{
    if(dataCenter == nil)
    {
        dataCenter = [[DataCenter alloc] init];
    }
    
    return dataCenter;
}

-(void)update
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://zxapi.sinaapp.com/passbook/update.php"
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"JSON: %@", responseObject);
             
             [[NSUserDefaults standardUserDefaults] setObject:responseObject forKey:kStoreKey];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
}
-(NSArray *)defaultStores
{
    return  [[NSUserDefaults standardUserDefaults] objectForKey:kStoreKey];
}

-(NSArray *)localStores
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Stores" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    
    return [NSJSONSerialization JSONObjectWithData:data
                                           options:NSJSONReadingAllowFragments error:nil];
}
-(NSArray *)storesWithArray:(NSArray *)array
{
    NSMutableArray *result = [NSMutableArray array];
    for(NSDictionary *item in array)
    {
        Store *store = [[Store alloc] initWithJSON:item];
        [result addObject:store];
    }
    
    
    //NSString *custom = [MobClick getConfigParams:@"PM_CUSTOM"];
    //if(custom)
    //{
    //    BOOL needCustom = [[NSNumber numberWithInt:[custom intValue]] boolValue];
    //    if(needCustom)
    //    {
            [result addObject:[[Store alloc] initWithCustomStore]];
    //    }
    //}
    return result;
}
-(NSArray *)stores
{
    if(_stores == nil)
    {
        NSArray *defaultStores = [self defaultStores];
        if(defaultStores == nil)
        {
            
            NSArray *data = [self localStores];
            _stores = [self storesWithArray:data];
            
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:kStoreKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else
        {
            _stores = [self storesWithArray:defaultStores];
        }
    }
    return _stores;
}


@end
