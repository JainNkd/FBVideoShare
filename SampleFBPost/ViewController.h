//
//  ViewController.h
//  SampleFBPost
//
//  Created by Naveen Kumar on 11/25/15.
//  Copyright (c) 2015 Naveen Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <AssetsLibrary/ALAsset.h>

@interface ViewController : UIViewController<FBSDKSharingDelegate>

- (IBAction)shareButtonAction:(UIButton *)sender;

@end

