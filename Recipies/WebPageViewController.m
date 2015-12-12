//
//  WebPageViewController.m
//  Recipies
//
//  Created by Brendan Kenny on 12/13/14.
//  Copyright (c) 2014 Brendan Kenny. All rights reserved.
//

#import "WebPageViewController.h"

@interface WebPageViewController ()

@end

@implementation WebPageViewController
//Displays URL
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *pageURL = self.url;
    
    
    NSURLRequest *pageURLRequest = [[NSURLRequest alloc] initWithURL:pageURL];
    [self.recipeWebView loadRequest:pageURLRequest];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
