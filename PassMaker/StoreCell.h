//
//  StoreCell.h
//  PassMaker
//
//  Created by 张 玺 on 13-11-21.
//  Copyright (c) 2013年 zhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Store.h"

@interface StoreCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;



@property(nonatomic,strong) Store *store;








@end
