//
//  AppDelegate.m
//  Recipies
//
//  Created by Brendan Kenny on 12/2/14.
//  Copyright (c) 2014 Brendan Kenny. All rights reserved.
//

#import "AppDelegate.h"
#import "Recipe.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize _tasks;
@synthesize _favorites;
@synthesize _Urls;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Gets any previous data from NSUserDefaults
    NSUserDefaults *userDefaults  = [NSUserDefaults standardUserDefaults];
    NSMutableArray *list = [userDefaults objectForKey:@"List"];
    if (list) {
        self._tasks = [[NSMutableArray alloc] init];
        self._tasks = list;
    }else{
        self._tasks = [[NSMutableArray alloc] init];
    }
    
    NSMutableArray *favs = [userDefaults objectForKey:@"Favorites"];
    if (favs) {
        self._favorites = [[NSMutableArray alloc] init];
        self._favorites = favs;
    }else{
        self._favorites = [[NSMutableArray alloc] init];
    }
    
    NSMutableArray *urls = [userDefaults objectForKey:@"Urls"];
    if (urls) {
        self._Urls = [[NSMutableArray alloc] init];
        self._Urls = urls;
    }else{
        self._Urls = [[NSMutableArray alloc] init];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    //Saves data to NSUserDefaults when app is about to close.
     NSUserDefaults *userDefaults  = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *list = self._tasks;
    [userDefaults setObject:list forKey:@"List"];
    NSMutableArray *favs = self._favorites;
    [userDefaults setObject:favs forKey:@"Favorites"];
    NSMutableArray *urls = self._Urls;
    [userDefaults setObject:urls forKey:@"Urls"];

    [userDefaults synchronize];

}




- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //if there is no data, it initializes the variables
    if (!_tasks) {
        self._tasks = [[NSMutableArray alloc] init];
    }
     if (!_favorites) {
         self._favorites = [[NSMutableArray alloc] init];
     }
    if (!_Urls) {
        self._Urls = [[NSMutableArray alloc] init];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
