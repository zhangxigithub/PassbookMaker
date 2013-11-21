//
//  EditViewController.h
//  PassMaker
//
//  Created by 张 玺 on 13-11-20.
//  Copyright (c) 2013年 zhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Store.h"

@interface EditViewController : UIViewController

@property(nonatomic,strong) Store *store;


@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextFeild;



@end
