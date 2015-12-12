//
//  WebPageViewController.h
//  Recipies
//
//  Created by Brendan Kenny on 12/13/14.
//  Copyright (c) 2014 Brendan Kenny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebPageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *recipeWebView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UINavigationBar *NavBar;

@property (strong, nonatomic) NSURL *url;
@end
