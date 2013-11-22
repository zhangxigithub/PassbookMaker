//
//  EditViewController.h
//  PassMaker
//
//  Created by 张 玺 on 13-11-20.
//  Copyright (c) 2013年 zhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Store.h"
#import <MBProgressHUD.h>
#import "ScanViewController.h"
#import <PassKit/PassKit.h>

@interface EditViewController : UIViewController<ScanViewControllerDelegate,UITextFieldDelegate,UIActionSheetDelegate,PKAddPassesViewControllerDelegate,UIAlertViewDelegate>
{
    MBProgressHUD *hud;
    UIActionSheet *action;
    BOOL input;
    
    
    NSString *code;
    NSString *type;
}
@property(nonatomic,strong) Store *store;


@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *codeTextFeild;


- (IBAction)creat:(id)sender;

@end
