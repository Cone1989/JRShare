//
//  JRViewController.m
//  JRShare
//
//  Created by liqiang on 09/16/2019.
//  Copyright (c) 2019 liqiang. All rights reserved.
//

#import "JRViewController.h"
#import <IQShare.h>
@interface JRViewController ()

@end

@implementation JRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[IQShare defaultShare] registerAppId:@"xx" platform:IQSharePlatformWechat];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
