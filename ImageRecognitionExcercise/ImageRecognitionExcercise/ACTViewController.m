//
//  ACTViewController.m
//  ImageRecognitionExcercise
//
//  Created by Francisco Granados on 1/9/14.
//  Copyright (c) 2014 Activ Developing Experiences. All rights reserved.
//

#import "ACTViewController.h"
#import "ACTRecognitionViewController.h"

@interface ACTViewController ()

@end

@implementation ACTViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)pushTakenImageToNextView:(UIImage *)aImage {
  ACTRecognitionViewController *recognitionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Recognition"];
  recognitionVC.templateImage = aImage;
  [self.navigationController pushViewController:recognitionVC animated:YES];
}

#pragma mark IBActions

-(IBAction)didTapOnTakePictureButton:(id)sender
{
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    [cameraUI setSourceType:UIImagePickerControllerSourceTypeCamera];
    [cameraUI setMediaTypes:[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera]];
//    [cameraUI setMediaTypes:@[kUTTypeImage]];
    [cameraUI setAllowsEditing:NO];
    [cameraUI setDelegate:self];
    
    [self presentViewController:cameraUI animated:YES completion:nil];
  }
}

# pragma mark UIImagePickerControllerDelegate

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//  NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
//  UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
  UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
  [picker dismissViewControllerAnimated:YES completion:nil];
  [self pushTakenImageToNextView:originalImage];
}

# pragma mark UINavigationControllerDelegate


@end
