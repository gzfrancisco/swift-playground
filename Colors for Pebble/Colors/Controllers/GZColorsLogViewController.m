//
//  GZColorsLogViewController.m
//  Colors
//
//  Created by Francisco Granados on 8/1/15.
//  Copyright (c) 2015 gzfrancisco. All rights reserved.
//

#import "GZColorsLogViewController.h"

@interface GZColorsLogViewController ()

@property(strong, nonatomic) NSMutableArray *colors;

@end

@implementation GZColorsLogViewController

static NSString *const cellIdentifier = @"ColorCell";

@synthesize colorsTableView;
@synthesize colors;

- (id)initWithDefaultNib {
  self = [super initWithNibName:@"GZColorsLogView" bundle:nil];
  
  if (self) {
    UITabBarItem *item = [self tabBarItem];
    item.title = @"Log";
    
    colors = [NSMutableArray array];
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
  BOOL reset = [(NSNumber *)notification.userInfo[@"reset"] boolValue];
  UIColor *color = (UIColor *)notification.userInfo[@"color"];

//  I like when the new color is at the top.
  [colors insertObject:color atIndex:0];
  
  [colorsTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:YES];
  if (reset) {
    [self deselectAllRows];
  } else {
    [colorsTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                 animated:YES
                           scrollPosition:UITableViewScrollPositionTop];
  }
  
}

- (void)deselectAllRows {
  for (NSUInteger i = 1; i < [colors count]; i++) {
    [colorsTableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:YES];
  }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [colors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
  cell.textLabel.text = [self colorDescriptionFrom:colors[indexPath.row]];
  cell.backgroundColor = colors[indexPath.row];

  return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)colorDescriptionFrom:(UIColor *)color {
  const CGFloat *components = CGColorGetComponents([color CGColor]);
  return [NSString stringWithFormat:@"R: %0.0f, %0.0f, %0.0f", components[0]*255, components[1]*255, components[2]*255];
}

@end
