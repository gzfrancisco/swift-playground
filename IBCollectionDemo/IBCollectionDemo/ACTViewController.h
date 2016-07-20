//
//  ACTViewController.h
//  IBCollectionDemo
//
//  Created by Francisco Granados on 27/7/14.
//  Copyright (c) 2014 Activ Developing Experiences. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACTViewController : UIViewController

@property (nonatomic, strong) IBOutletCollection(UILabel) NSArray *labels;
@property (nonatomic, strong) IBOutletCollection(UITextField) NSArray *fields;

@end
