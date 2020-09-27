//
//  ZGViewController.m
//  ZGCommonComponent
//
//  Created by 437001178@qq.com on 09/25/2020.
//  Copyright (c) 2020 437001178@qq.com. All rights reserved.
//

#import "ZGViewController.h"
#import <ZGCommonComponent/ZGCMNetworkStatusUtil.h>
@interface ZGViewController ()

@end

@implementation ZGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[ZGCMNetworkStatusUtil shareInstance] isNetworkReach];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
