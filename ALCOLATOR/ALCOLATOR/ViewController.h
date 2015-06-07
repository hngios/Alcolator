//
//  ViewController.h
//  ALCOLATOR
//
//  Created by HILDA NG on 5/20/15.
//  Copyright (c) 2015 hng,inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UISlider *beerCountSlider;
@property (weak, nonatomic) UILabel *resultLabel;
//@property (weak, nonatomic) UIButton *calculateButton;
//@property (strong, nonatomic) UILabel *numberOfBeersLabel;
//@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;

- (void) buttonPressed:(UIButton *)sender;

@end


