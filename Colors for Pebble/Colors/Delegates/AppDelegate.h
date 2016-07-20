//
//  AppDelegate.h
//  Colors
//
//  Created by Francisco Granados on 8/1/15.
//  Copyright (c) 2015 gzfrancisco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GZColorsService.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) GZColorsService *service;

@end

