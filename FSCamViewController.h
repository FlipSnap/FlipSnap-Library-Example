//
//  FSViewController.h
//  FlipSnapLibrary
//
//  Created by Rob Newport on 7/25/17.
//  Copyright © 2017 Whisteo. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface FSCamViewController : UIViewController

@property(nonatomic, strong) IBOutlet UISlider *toleranceSlider;
@property(nonatomic, strong) IBOutlet UIView *swatch;
@property(assign) BOOL recording;

-(IBAction)toggleRecording:(id)sender;
-(IBAction)sliderTolerance:(id)sender;
-(IBAction)depthOn:(UISwitch *)depthSwitch;
-(IBAction)resetColors:(id)sender;
-(IBAction)switchCamera:(id)sender;

-(void)updateAlgorithmTop:(NSString *)top bottom:(NSString *)bottom;
-(void)extractVideoURL:(NSURL *)url;
-(void)clearTempDirectory;
-(void)recordingStoppedForMovieAtURL:(NSURL *)url;

@end
