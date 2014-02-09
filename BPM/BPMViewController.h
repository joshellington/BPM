//
//  BPMViewController.h
//  BPM
//
//  Created by Joshua Ellington on 2/8/14.
//  Copyright (c) 2014 Joshua Ellington. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPMViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *numberOfTaps;
@property (weak, nonatomic) IBOutlet UILabel *bpmLabel;
@property NSDate *lastTap;
@property NSDate *firstTime;
@property double tapDifference;
@property (nonatomic, assign) int tapCount;
@property (nonatomic, assign) int averageBpm;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
- (IBAction)resetButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *fingerprint;
#define accentColor [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:64.0/255.0 alpha:1.0];

@end
