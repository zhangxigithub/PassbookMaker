//
//  Store.h
//  PassMaker
//
//  Created by 张 玺 on 13-11-21.
//  Copyright (c) 2013年 zhangxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Store : NSObject

@property (nonatomic,copy)   NSString *storeID;
@property (nonatomic,copy)   NSString *type;
@property (nonatomic,copy)   NSString *name;
@property (nonatomic,copy)   NSString *description;
@property (nonatomic,strong) NSURL    *logo;

@property (nonatomic,assign) BOOL      custom;


-(id)initWithJSON:(NSDictionary *)json;
-(id)initWithCustomStore;
@end
