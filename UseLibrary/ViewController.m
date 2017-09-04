
/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information

 Abstract:
 View controller for camera interface
 */

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController () {
    IBOutlet UILabel *label;
}

@end

@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [self clearTempDirectory];
    [self loadAlgorithm];
    [self showVersion];
    [super viewDidLoad];
}

- (void)showVersion {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    NSString *buildNumber = [infoDict objectForKey:@"CFBundleVersion"];
    [label setText:[NSString stringWithFormat:@"beta %@ %@", appVersion, buildNumber]];
}

// Load the external algoritmn
-(void)loadAlgorithm {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *top = [documentPath stringByAppendingPathComponent:@"algorithm.top"];
    NSString *bottom = [documentPath stringByAppendingPathComponent:@"algorithm.bottom"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:top] == YES) {
        if([fileManager fileExistsAtPath:bottom] == YES) {
            NSString *algorithm = [NSString stringWithContentsOfFile:top encoding:NSUTF8StringEncoding error:NULL];
            NSString *conditional = [NSString stringWithContentsOfFile:bottom encoding:NSUTF8StringEncoding error:NULL];
            [self updateAlgorithmTop:algorithm bottom:conditional];
        }
    }
}

// this method loads a background movie
-(void)loadMovieBackground {
    NSBundle *myBundle = [NSBundle mainBundle];
    NSString *myImage = [myBundle pathForResource:@"test" ofType:@"mov"];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:myImage];
    [self extractVideoURL:url];
}

// this method override determines the saved recorded movie location in the temp directory
-(void)recordingStoppedForMovieAtURL:(NSURL *)url {
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeVideoAtPathToSavedPhotosAlbum:url completionBlock:^(NSURL *assetURL, NSError *error) {
        [[NSFileManager defaultManager] removeItemAtURL:url error:NULL];
        NSLog(@"url: %@", url);
    }];
    [super recordingStoppedForMovieAtURL:url];
}

@end

