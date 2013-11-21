//
//  Store.m
//  PassMaker
//
//  Created by 张 玺 on 13-11-21.
//  Copyright (c) 2013年 zhangxi. All rights reserved.
//

#import "Store.h"

@implementation Store
- (id)init
{
    self = [super init];
    if (self) {
        /*
         @property (nonatomic,copy)   NSString *type;
         @property (nonatomic,copy)   NSString *name;
         @property (nonatomic,copy)   NSString *description;
         @property (nonatomic,strong) NSURL    *logo;
         */
        
        
        _type        = @"storeCard";
        _name        = @"乐购超市";
        _description = @"乐购超市会员卡";
        _logo        = [NSURL URLWithString:@"http://zxapi.sinaapp.com/passbook/logo/legou@2x.png"];
        
        
        
    }
    return self;
}
-(id)initWithJSON:(NSDictionary *)json
{
    self = [self init];
    if(self)
    {
    }
    return self;
}
@end
