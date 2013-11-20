//
//  ViewController.h
//  PassMaker
//
//  Created by zhangxi on 13-11-20.
//  Copyright (c) 2013年 zhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZBarSDK.h>

@interface ViewController : UIViewController<ZBarReaderViewDelegate>
- (IBAction)generate:(id)sender;

@property (weak, nonatomic) IBOutlet ZBarReaderView *readView;
@end
