//
//  EditViewController.m
//  PassMaker
//
//  Created by 张 玺 on 13-11-20.
//  Copyright (c) 2013年 zhangxi. All rights reserved.
//

#import "EditViewController.h"
#import <UIImageView+AFNetworking.h>


@implementation EditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setStore:_store];
}
-(void)setStore:(Store *)store
{
    _store = store;
    
    [self.logoImageView setImageWithURL:store.logo];
    [self.nameTextFeild setText:store.name];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
