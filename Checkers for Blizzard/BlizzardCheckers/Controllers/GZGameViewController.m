//
//  ViewController.m
//  BlizzardCheckers
//
//
//  This view controller can have any ui component and its decopled from the board and the rules
//  
//
//  Created by Francisco Granados on 19/12/14.
//  Copyright (c) 2014 gzfrancisco. All rights reserved.
//

#import "GZGameViewController.h"
#import "GZBoardViewController.h"

@interface GZGameViewController ()

@property (nonatomic, strong) GZBoardViewController *boardController;

@end

@implementation GZGameViewController

@synthesize boardController;

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup afterboardControllerloading the view, typically from a nib.
  boardController = [[GZBoardViewController alloc] initWithNibName:nil bundle:nil];
  [self.view addSubview: boardController.view];
}

//- (void)didReceiveMemoryWarning {
//  [super didReceiveMemoryWarning];
//  // Dispose of any resources that can be recreated.
//}

@end
