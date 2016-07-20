//
//  ViewController.h
//  Photo
//
//  Created by Francisco Granados on 29/12/14.
//  Copyright (c) 2014 gzfrancisco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageService.h"

@interface ViewController : UIViewController<ImageServiceDelegate>

@property (weak, nonatomic) IBOutlet UITextField *columnsField;

@end

