//
//  TypeViewController.h
//  PassMaker
//
//  Created by 张 玺 on 13-11-20.
//  Copyright (c) 2013年 zhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataCenter.h"
#import "StoreCell.h"


@interface StoreViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *localData;
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@end
