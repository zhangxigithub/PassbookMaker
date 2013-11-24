//
//  EditViewController.m
//  PassMaker
//
//  Created by 张 玺 on 13-11-20.
//  Copyright (c) 2013年 zhangxi. All rights reserved.
//
#define kTagShowPassbook  1989



#import "EditViewController.h"
#import <UIImageView+WebCache.h>
//#import <UIImageView+AFNetworking.h>
#import "ScanViewController.h"
#import <AFNetworking.h>
#import <PassKit/PassKit.h>
#import <MBProgressHUD.h>

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
    input = NO;
    type = @"BCGcode128";
    [self setStore:_store];
    
    
    
   NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserverForName:UIKeyboardDidChangeFrameNotification
                        object:nil
                         queue:[NSOperationQueue mainQueue]
                    usingBlock:^(NSNotification *note) {
                       
                        
                        NSLog(@"%@",note.userInfo);
                        
                        
                        
                    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 2 && indexPath.row == 0)
    {
        [self creat:nil];
    }
}
-(void)setStore:(Store *)store
{
    _store = store;
    self.title = store.name;
    //[self.logoImageView setImageWithURL:store.logo];
    
    if(store.custom == NO)
    {
        [self.nameTextFeild setText:store.name];
    }
    [self.tableView reloadData];
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    NSLog(@"%@",segue);
//    if([segue.identifier isEqualToString:@"push.scan"])
//    {
//        
//        if([code isEqualToString:@""] == NO)
//        {
//        [self creatPassbook:self.store.storeID
//                       name:self.store.name
//                       code:code
//                       type:type];
//        }
//        //ScanViewController *scanViewController = segue.destinationViewController;
//        //scanViewController.delegate = self;
//    }
//}
-(void)didGetCode:(NSString *)theCode type:(NSString *)theType
{
    NSLog(@"%@\n%@",theCode,theType);
    
    code = theCode;
    type = theType;
    
    self.codeTextFeild.text = theCode;
    
    
    
    if([self.nameTextFeild.text isEqualToString:@""]==NO)
    {
    [self creatPassbook:self.store.storeID
                   name:self.nameTextFeild.text
                   code:theCode
                   type:theType];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.codeTextFeild.delegate = nil;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.codeTextFeild.delegate = self;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField == _codeTextFeild && input == NO)
    {
        [self.nameTextFeild resignFirstResponder];
        action = [[UIActionSheet alloc] initWithTitle:@"输入二维码"
                                             delegate:self
                                    cancelButtonTitle:@"取消"
                               destructiveButtonTitle:nil
                                    otherButtonTitles:@"扫描",@"手动输入", nil];
        [action showInView:self.view];
        
        return NO;
    }
    if(textField == _codeTextFeild && input == YES)
    {
//        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]
//                              atScrollPosition:UITableViewScrollPositionTop
//                                      animated:YES];
    }
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == _codeTextFeild)
    {
        code = textField.text;
        input = NO;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            ScanViewController *scanViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"scan"];
            scanViewController.delegate = self;
            [self.navigationController pushViewController:scanViewController animated:YES];
            
            [self.codeTextFeild resignFirstResponder];
             break;
        }
        case 1:
            input = YES;
            [self.codeTextFeild becomeFirstResponder];
            break;
            
        default:
            break;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)creatPassbook:(NSString *)storeID name:(NSString *)name code:(NSString *)theCode type:(NSString *)theType
{
    NSLog(@"%@",storeID);
    NSLog(@"%@",name);
    NSLog(@"%@",theCode);
    NSLog(@"%@",theType);
    
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"生成中 ... ";
    
    
    NSDictionary *params = @{@"code":theCode,
                             @"id":storeID,
                             @"name":name,
                             @"type":theType};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://zxapi.sinaapp.com/passbook/generate.php"
      parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             [hud hide:YES];
             NSError *error;
             
             
             PKPass *pass = [[PKPass alloc] initWithData:operation.responseData error:&error];
             if(pass!= nil)
             {
                 PKAddPassesViewController *addVC = [[PKAddPassesViewController alloc] initWithPass:pass];
                 addVC.delegate = self;
                 [self presentViewController:addVC animated:YES completion:^{
                     
                 }];
             }
             
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [hud hide:YES];
             NSLog(@"Error: %@", error);
         }];

}
-(void)addPassesViewControllerDidFinish:(PKAddPassesViewController *)controller
{

    [controller dismissViewControllerAnimated:YES completion:^{
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"添加成功"
//                                                        message:@"是否打开passbook查看?"
//                                                       delegate:self
//                                              cancelButtonTitle:@"不了" otherButtonTitles:@"去看看", nil];
//        alert.tag = kTagShowPassbook;
//        [alert show];
        
    }];
    

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == kTagShowPassbook)
    {
        switch (buttonIndex) {
            case 0:
                
                break;
            case 1:
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"shoebox://"]];
                break;
                
            default:
                break;
        }
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (IBAction)creat:(id)sender {
    
    if(code != nil && [code isEqualToString:@""] == NO)
    {
        [self creatPassbook:self.store.storeID
                       name:self.nameTextFeild.text
                       code:self.codeTextFeild.text
                       type:type];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"生成失败"
                                                        message:@"请输入正确的卡片名称和编号."
                                                       delegate:nil
                                              cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];
    }
}
@end
