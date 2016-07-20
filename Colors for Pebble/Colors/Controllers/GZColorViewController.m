//
//  GZColorViewController.m
//  Colors
//
//  Created by Francisco Granados on 8/1/15.
//  Copyright (c) 2015 gzfrancisco. All rights reserved.
//

#import "GZColorViewController.h"

@interface GZColorViewController ()

@end

@implementation GZColorViewController

@synthesize colorLabel;

- (id)initWithDefaultNib {
  self = [super initWithNibName:@"GZColorView" bundle:nil];
  
  if (self) {
    UITabBarItem *item = [self tabBarItem];
    item.title = @"Color";
  }
  
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self suscribe];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Handler and suscribers

- (void)suscribe {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(serverDidUpdateColor:) name:@"ColorUpdate" object:nil];
}

- (void)unsuscribe {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)serverDidUpdateColor:(NSNotification *)notification {
  UIColor *color = (UIColor *)notification.userInfo[@"color"];
  
  const CGFloat *components = CGColorGetComponents([color CGColor]);
  
  colorLabel.text = [NSString stringWithFormat:@"R: %0.0f, %0.0f, %0.0f", components[0]*255, components[1]*255, components[2]*255];
}

@end
