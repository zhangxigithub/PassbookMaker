//
//  Store.m
//  PassMaker
//
//  Created by 张 玺 on 13-11-21.
//  Copyright (c) 2013年 zhangxi. All rights reserved.
//

#import "Store.h"

@implementation Store
//- (id)init
//{
//    self = [super init];
//    if (self) {
//
//    }
//    return self;
//}
-(id)initWithJSON:(NSDictionary *)json
{
    self = [self init];
    if(self)
    {
        _custom      = NO;
        _storeID     = [NSString stringWithFormat:@"%d",[json[@"id"] intValue]];
        _type        = json[@"type"];
        _name        = json[@"name"];
        _description = json[@"description"];
        _logo        = [NSURL URLWithString:json[@"logo"]];
        
    }
    NSLog(@"%@",_storeID);
    return self;
}
-(id)initWithCustomStore
{
    self = [self init];
    if(self)
    {
        _custom      =  YES;
        _storeID     = @"-1";
        _type        = @"BCGcode128";
        _name        = @"通用";
        _description = @"通用会员卡模版";
        _logo        = [NSURL URLWithString:@"http://zxapi.sinaapp.com/passbook/logo/logo@2x.jpg"];
        
    }
    NSLog(@"%@",_storeID);
    return self;
}
@end
