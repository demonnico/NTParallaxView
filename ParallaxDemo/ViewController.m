//
//  ViewController.m
//  ParallaxDemo
//
//  Created by demon on 9/12/13.
//  Copyright (c) 2013 demonNico. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationController.title = @"ParallaxEffectDemo";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showTableView:(id)sender
{
    DemoViewController * viewController = [DemoViewController new];
    [self.navigationController pushViewController:viewController
                                         animated:YES];
    [viewController showTableViewParallax];
}

- (IBAction)showScrollView:(id)sender
{
    DemoViewController * viewController = [DemoViewController new];
    [self.navigationController pushViewController:viewController
                                         animated:YES];
    [viewController showScollViewParallax];
}
@end
