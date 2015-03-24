//
//  ViewController.m
//  DotsAnimation
//
//  Created by Abbie on 3/23/15.
//  Copyright (c) 2015 Abbie. All rights reserved.
//

#import "ViewController.h"
#import "Dots.h"

@interface ViewController ()

@property (nonatomic, strong) Dots *dotsInsatnce;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    Dots *dotsHUD = [[Dots alloc] initWithFrame:CGRectMake((CGFloat) ((self.view.frame.size.width - 55) * 0.5),
                                                                           (CGFloat) ((self.view.frame.size.height - 20) * 0.5), 55, 20)];
    dotsHUD.hudColor = [UIColor redColor];
    [self.view addSubview:dotsHUD];
    
    [dotsHUD showAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
