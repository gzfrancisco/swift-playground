//
//  GZColorsLogViewController.h
//  Colors
//
//  Created by Francisco Granados on 8/1/15.
//  Copyright (c) 2015 gzfrancisco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GZColorsLogViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *colorsTableView;

- (id)initWithDefaultNib;

@end
