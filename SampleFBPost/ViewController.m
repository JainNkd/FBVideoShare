//
//  ViewController.m
//  SampleFBPost
//
//  Created by Naveen Kumar on 11/25/15.
//  Copyright (c) 2015 Naveen Kumar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareButtonAction:(UIButton *)sender {
    NSLog(@"shareButtonAction");
    
    //Share Video
    
    NSString *myUrlSTR = [[NSBundle mainBundle] pathForResource:@"67364859_47658038_1429027280" ofType:@"mp4"];
    
    NSURL *videoURL=[NSURL fileURLWithPath:myUrlSTR];
    [self saveToCameraRoll:videoURL];
}

- (void)saveToCameraRoll:(NSURL *)srcURL
{
    NSLog(@"srcURL: %@", srcURL);
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    ALAssetsLibraryWriteVideoCompletionBlock videoWriteCompletionBlock =
    ^(NSURL *newURL, NSError *error) {
        if (error) {
            NSLog( @"Error writing image with metadata to Photo Library: %@", error );
        } else {
            NSLog( @"Wrote image with metadata to Photo Library %@", newURL.absoluteString);
            
            FBSDKShareVideo *video = [[FBSDKShareVideo alloc] init];
            video.videoURL = newURL;
            FBSDKShareVideoContent *content = [[FBSDKShareVideoContent alloc] init];
            content.video = video;
            [FBSDKShareDialog showFromViewController:self
                                         withContent:content
                                            delegate:self];
            FBSDKShareDialog *shareDialog = [[FBSDKShareDialog alloc] init];
            if([shareDialog canShow])
                NSLog(@"YEs...");
            
        }
    };
    
    if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:srcURL])
    {
        [library writeVideoAtPathToSavedPhotosAlbum:srcURL
                                    completionBlock:videoWriteCompletionBlock];
    }
}

- (void)video:(NSString *)videoPath finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save video"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        
    } else {
        //set '@selector(video:finishedSavingWithError:contextInfo:)' if you want a success message
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Video Saved" message:nil  delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        FBSDKShareVideo *video = [[FBSDKShareVideo alloc] init];
        video.videoURL = [NSURL fileURLWithPath:videoPath];
        FBSDKShareVideoContent *content = [[FBSDKShareVideoContent alloc] init];
        content.video = video;
        [FBSDKShareDialog showFromViewController:self
                                     withContent:content
                                        delegate:self];
        FBSDKShareDialog *shareDialog = [[FBSDKShareDialog alloc] init];
        if([shareDialog canShow])
            NSLog(@"YEs...");
        
        
        
    }
}

#pragma mark - FBSDKSharingDelegate

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results
{
    NSLog(@"completed share:%@", results);
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error
{
    NSLog(@"sharing error:%@", error);
    NSString *message = error.userInfo[FBSDKErrorLocalizedDescriptionKey] ?:
    @"There was a problem sharing, please try again later.";
    NSString *title = error.userInfo[FBSDKErrorLocalizedTitleKey] ?: @"Oops!";
    
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer
{
    NSLog(@"share cancelled");
}


@end
