//
//  MenuViewController.m
//  PassMaker
//
//  Created by 张 玺 on 13-11-20.
//  Copyright (c) 2013年 zhangxi. All rights reserved.
//

#import "MenuViewController.h"
#import <MobClick.h>
#import "UMSocial.h"

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
- (IBAction)share:(id)sender {
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"528e351256240bb52e06899a"
                                      shareText:@"我在使用会员卡+存储会员卡 http://pgyer.com/passbook"
                                     shareImage:[UIImage imageNamed:@"AppIcon"]
                                shareToSnsNames:nil
                                       delegate:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
