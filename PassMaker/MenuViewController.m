//
//  MenuViewController.m
//  PassMaker
//
//  Created by 张 玺 on 13-11-20.
//  Copyright (c) 2013年 zhangxi. All rights reserved.
//

#import "MenuViewController.h"
#import <MobClick.h>

@implementation MenuViewController

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
    [MobClick event:@"enter_home"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
