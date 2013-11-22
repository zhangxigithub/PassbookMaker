//
//  ViewController.m
//  PassMaker
//
//  Created by zhangxi on 13-11-20.
//  Copyright (c) 2013年 zhangxi. All rights reserved.
//

#import "ScanViewController.h"
#import <AFNetworking.h>
#import <PassKit/PassKit.h>
#import <ZBarReaderViewController.h>

@implementation ScanViewController

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
    self.view.clipsToBounds = YES;
    self.readView.readerDelegate = self;
    [self.readView start];
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

    zbar_symbol_type_t type =zbar_symbol_get_type(symbol);
    
    
    NSString *codeType;

    switch (type) {
        case ZBAR_EAN2:
            codeType = nil;
            
            break;
            
        case ZBAR_EAN5:
            codeType = nil;
            
            break;
            
        case ZBAR_EAN8:
            codeType = @"BCGean8";
            
            break;
            
        case ZBAR_UPCE:
            codeType = nil;
            
            break;
            
        case ZBAR_ISBN10:
            codeType = @"BCGisbn";
            
            break;
            
        case ZBAR_UPCA:
            codeType = nil;
            
            break;
            
        case ZBAR_EAN13:
            codeType = @"BCGean13";
            
            break;
            
        case ZBAR_ISBN13:
            codeType = @"BCGisbn";
            
            break;
            
        case ZBAR_COMPOSITE:
            codeType = nil;
            
            break;
            
        case ZBAR_I25:
            codeType = @"BCGi25";
            
            break;
            
        case ZBAR_DATABAR:
            codeType = nil;
            
            break;
            
        case ZBAR_DATABAR_EXP:
            codeType = nil;
            
            break;
            
        case ZBAR_CODABAR:
            codeType = nil;
            
            break;
            
        case ZBAR_CODE39:
            codeType = @"BCGcode39";
            
            break;
            
        case ZBAR_PDF417:
            codeType = nil;
            
            break;
            
        case ZBAR_QRCODE:
            codeType = nil;
            
            break;
            
        case ZBAR_CODE93:
            codeType = @"BCGcode93";
            
            break;
            
        case ZBAR_CODE128:
            codeType = @"BCGcode128";
            
            break;

        default:
            break;
    }
    if(codeType == nil)
    {
        
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate didGetCode:symbolStr type:codeType];
    

}


@end


