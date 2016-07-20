//
//  ACTViewController.m
//  IBCollectionDemo
//
//  Created by Francisco Granados on 27/7/14.
//  Copyright (c) 2014 Activ Developing Experiences. All rights reserved.
//

#import "ACTViewController.h"

@interface ACTViewController ()

@end

@implementation ACTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self customizeLabels];
    [self customizeFields];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customizeLabels
{
    [self.labels enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL *stop) {
        obj.font = [UIFont fontWithName:@"Optima" size:14];
    }];
}

- (void)customizeFields
{
    for (UITextField *field in self.fields) {
        field.backgroundColor = [UIColor colorWithRed:255 green:255 blue:0 alpha:0.8];
    }
}

@end
