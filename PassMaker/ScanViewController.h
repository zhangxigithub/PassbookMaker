//
//  ViewController.h
//  PassMaker
//
//  Created by zhangxi on 13-11-20.
//  Copyright (c) 2013年 zhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZBarSDK.h>

@protocol ScanViewControllerDelegate <NSObject>

-(void)didGetCode:(NSString *)code type:(NSString *)type;

@end


@interface ScanViewController : UIViewController<ZBarReaderViewDelegate>



@property (weak, nonatomic) IBOutlet id<ScanViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet ZBarReaderView *readView;
@end
