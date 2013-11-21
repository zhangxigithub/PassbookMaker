//
//  ViewController.m
//  PassMaker
//
//  Created by zhangxi on 13-11-20.
//  Copyright (c) 2013年 zhangxi. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import <PassKit/PassKit.h>
#import <ZBarReaderViewController.h>

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    [manager GET:@"http://zxapi.sinaapp.com/passbook/example.php"
//      parameters:nil
//         success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//             
//             NSError *error;
//             
//
//             PKPass *pass = [[PKPass alloc] initWithData:operation.responseData error:&error];
//             PKAddPassesViewController *addVC = [[PKAddPassesViewController alloc] initWithPass:pass];
//             [self presentViewController:addVC animated:YES completion:^{
//                 
//             }];
//             
//             
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)generate:(id)sender {
    self.readView.readerDelegate = self;
    [self.readView start];
}
- (void) readerView: (ZBarReaderView*) readerView
     didReadSymbols: (ZBarSymbolSet*) symbols
          fromImage: (UIImage*) image
{
    [readerView stop];
    
    const zbar_symbol_t *symbol = zbar_symbol_set_first_symbol(symbols.zbarSymbolSet);
    NSString *symbolStr = [NSString stringWithUTF8String: zbar_symbol_get_data(symbol)];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    
    NSString *string = [NSString stringWithFormat:@"http://zxapi.sinaapp.com/passbook/generate.php?code=%@&style=0",symbolStr];
    
    [manager GET:string
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {


             NSError *error;


             PKPass *pass = [[PKPass alloc] initWithData:operation.responseData error:&error];
             if(pass!= nil)
             {
             PKAddPassesViewController *addVC = [[PKAddPassesViewController alloc] initWithPass:pass];
             [self presentViewController:addVC animated:YES completion:^{

             }];
             }


    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


@end


