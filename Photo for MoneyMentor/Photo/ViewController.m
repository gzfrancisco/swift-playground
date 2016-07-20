//
//  ViewController.m
//  Photo
//
//  Created by Francisco Granados on 29/12/14.
//  Copyright (c) 2014 gzfrancisco. All rights reserved.
//

#import "ViewController.h"
#import "GalleryCollectionViewController.h"

@interface ViewController ()

@property (strong, nonatomic) ImageService *service;

@end

@implementation ViewController

@synthesize service;
@synthesize columnsField;

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"ShowGallery"]) {
    service = [[ImageService alloc] init];
    service.delegate = self;
    [service requestPhotos];
    GalleryCollectionViewController *gallery = (GalleryCollectionViewController *)[segue destinationViewController];
    
    NSInteger cols = [columnsField.text integerValue];
    
    [gallery setColumns:cols];
  }
}

- (void)imageService:(ImageService *)imageService didReceivePhotos:(NSArray *)photos {
  NSLog(@"%@", [photos firstObject]);
}

@end
