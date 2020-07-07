//
//  AppDelegate.m
//  Carmen-Instagram
//
//  Created by Carmen Gutierrez on 7/6/20.
//  Copyright © 2020 Carmen Gutierrez. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    ParseClientConfiguration *config = [ParseClientConfiguration   configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
             
             configuration.applicationId = @"carmen-instagram";
             configuration.server = @"http://carmen-instagram.herokuapp.com/parse";
         }];
         
         [Parse initializeWithConfiguration:config];
         PFObject *gameScore = [PFObject objectWithClassName:@"GameScore"];
         gameScore[@"score"] = @1337;
         gameScore[@"playerName"] = @"Sean Plott";
         gameScore[@"cheatMode"] = @NO;
         [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
           if (succeeded) {
              NSLog(@"Object saved!");
           } else {
              NSLog(@"Error: %@", error.description);
           }
         }];

    
    
         
         return YES;
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
