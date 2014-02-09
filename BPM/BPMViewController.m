//
//  BPMViewController.m
//  BPM
//
//  Created by Joshua Ellington on 2/8/14.
//  Copyright (c) 2014 Joshua Ellington. All rights reserved.
//

#import "BPMViewController.h"

@interface BPMViewController ()

@end

@implementation BPMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                          initWithTarget:self
                                                          action:@selector(handleSingleTap:)];
    [singleTapGestureRecognizer setNumberOfTapsRequired:1];
    // Wait for failed doubleTapGestureRecognizer
    [self.view addGestureRecognizer:singleTapGestureRecognizer];
    
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(handleSwipe:)];
    [swipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:swipeGestureRecognizer];
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"Swiped!");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info"
                                                    message:@"BPM = beats per minute. Built by Josh Ellington."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    // Houston, we have a tap
    NSLog(@"Single tap");
    
    // Check to see if there's been a tap in the last 5 seconds, if not, reset
    NSTimeInterval testDifference = [[NSDate date] timeIntervalSinceDate:self.firstTime];
    if (testDifference - (self.tapDifference / 1000) > 5) {
        NSLog(@"Reset because of delay.");
        [self resetAll];
    }
    
    if (self.tapCount == 0) {
        // First tap
        self.firstTime = [NSDate date];
        self.bpmLabel.text = @"BPM";
        self.numberOfTaps.textColor = [UIColor whiteColor];
        self.fingerprint.alpha = 0;
        self.resetButton.hidden = FALSE;
        [UIView animateWithDuration:0.2 animations:^{
            self.view.backgroundColor = accentColor;
        }];
    }
    
    if (self.tapCount >= 0) {
        // In action
        NSDate *current = [NSDate date];
        NSTimeInterval difference = [current timeIntervalSinceDate:self.firstTime];
        self.tapDifference = difference * 1000;
        
        // Calculate new BPM using overall tap count and time difference
        int newBpm = 60000 * self.tapCount / self.tapDifference;
        self.averageBpm = newBpm;
        NSString* newCount = [@(self.averageBpm) description];
        
        CATransition *animation = [CATransition animation];
        animation.duration = 0.2;
        animation.type = kCATransitionFade;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        if (self.tapCount > 0) {
            [self.numberOfTaps.layer addAnimation:animation forKey:@"changeTextTransition"];
        }
        self.numberOfTaps.text = newCount;
        self.tapCount = self.tapCount + 1;
        
        // Slightly animate view to give tap feedback
        self.view.alpha = 0.95;
        [UIView animateWithDuration:0.2 animations:^{
            self.view.alpha = 1;
        }];
    }

    // Update time for last tap
    self.lastTap = [NSDate date];
}

- (void)resetAll {
    // Reset function to set back to original view
    self.tapCount = 0;
    self.numberOfTaps.text = @"Start tapping";
    self.numberOfTaps.textColor = accentColor;
//    self.view.backgroundColor = [UIColor whiteColor];
    [UIView animateWithDuration:0.5 animations:^{
        self.view.backgroundColor = [UIColor whiteColor];
    }];
    self.bpmLabel.text = @"";
    self.fingerprint.alpha = 1;
    self.resetButton.hidden = TRUE;
    NSLog(@"Reset manually.");
}

- (IBAction)resetButton:(id)sender {
    // Bind reset button
    [self resetAll];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
