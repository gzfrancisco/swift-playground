//
//  ACTViewController.h
//  ImageRecognitionExcercise
//
//  Created by Francisco Granados on 1/9/14.
//  Copyright (c) 2014 Activ Developing Experiences. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACTViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

-(IBAction)didTapOnTakePictureButton:(id)sender;

@end
