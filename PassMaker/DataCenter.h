//
//  DataCenter.h
//  PassMaker
//
//  Created by 张 玺 on 13-11-21.
//  Copyright (c) 2013年 zhangxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Store.h"

@interface DataCenter : NSObject

@property (nonatomic,strong) NSArray *stores;


+(DataCenter *)sharedDataCenter;

-(void)update;



@end
