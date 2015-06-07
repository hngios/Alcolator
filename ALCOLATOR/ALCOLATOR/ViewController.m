//
//  ViewController.m
//  ALCOLATOR
//
//  Created by HILDA NG on 5/20/15.
//  Copyright (c) 2015 hng,inc. All rights reserved.
//

#import "ViewController.h"


//@interface ViewController ()
@interface ViewController () <UITextFieldDelegate>

//@property (weak, nonatomic) UITextField *beerPercentTextField;

//@property (weak, nonatomic) UISlider *beerCountSlider;

//@property (weak, nonatomic) UILabel *resultLabel;

@property (weak, nonatomic) UIButton *calculateButton;

@property (strong, nonatomic) UILabel *numberOfBeersLabel;

@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];  //calls the superclass's implementation
    
    // Set our primary view's background color to lightGrayColor
    self.view.backgroundColor = [UIColor redColor];
    
    // Tells the text field that `self`, this instance of `BLCViewController` should be treated as the text field's delegate
    self.beerPercentTextField.delegate = self;
    
    // Set the placeholder text
    self.beerPercentTextField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percent placeholder text");
    
    // Tells `self.beerCountSlider` that when its value changes, it should call `[self -sliderValueDidChange:]`.
    // This is equivalent to connecting the IBAction in our previous checkpoint
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
                                                                                                  
    //Set the minimum and maximum number of beers
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
                                                                                                  
    // Tells `self.calculateButton` that when a finger is lifted from the button while still inside its bounds, to call `[self -buttonPressed:]`
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
   
    // Set the title of the button
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate!",@"Calculate comand") forState:UIControlStateNormal];

    // Tells the tap gesture recognizer to call `[self -tapGestureDidFire:]` when it detects a tap.
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
  
    // Get rid of the maximum number of lines on the label
    self.resultLabel.numberOfLines = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadView {
    self.view = [[UIView alloc] init]; //alloc and init all-encompassing view

     //allocate and initialize each of our views and the gesture recognizer
     UITextField *textField = [[UITextField alloc] init];
     UISlider *slider = [[UISlider alloc] init];
     UILabel *label = [[UILabel alloc] init];
     UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
     
     //Add each view and gesture recognizer as the view's subview
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:button];
    self.numberOfBeersLabel = [[UILabel alloc] init];
    [self.view addSubview:self.numberOfBeersLabel];
    [self.view addGestureRecognizer:tap];
     
     //Assign the views and gesture recognizer to our properties
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultLabel = label;
  //  self.numberOfBeersLabel = [[UILabel alloc] init];
    self.calculateButton = button;
    self.calculateButton.tintColor = [UIColor redColor];
    self.hideKeyboardTapGestureRecognizer = tap;
    self.numberOfBeersLabel.text = @"5";
    self.resultLabel.text = @"Result Here";
    self.resultLabel.textColor = [UIColor blueColor];
}
     -(void)viewWillLayoutSubviews {
         [super viewWillLayoutSubviews];
         
         CGFloat viewWidth = 736;
         CGFloat padding = 20;
         CGFloat itemWidth = viewWidth - padding - padding;
         CGFloat itemHeight = 44;
         
         self.beerPercentTextField.frame = CGRectMake(padding, padding, itemWidth, itemHeight);
         self.beerPercentTextField.backgroundColor = [UIColor whiteColor];
         
         CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
         self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
         
         CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
         self.resultLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight * 4);
         
         CGFloat bottomNumberOfBeersLabel = CGRectGetMaxY(self.beerCountSlider.frame);
         self.numberOfBeersLabel.frame = CGRectMake(padding, bottomNumberOfBeersLabel + padding, itemWidth, itemHeight);
         self.numberOfBeersLabel.backgroundColor = [UIColor whiteColor];
         self.numberOfBeersLabel.textColor = [UIColor lightGrayColor];
         
         CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
         self.calculateButton.frame = CGRectMake(padding, bottomOfLabel + padding, itemWidth, itemHeight);
         self.calculateButton.backgroundColor = [UIColor whiteColor];
     }
     
- (void)textFieldDidChange:(UITextField *)sender {
    
    // Make sure the text is a number
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0) {
        // The user typed 0, or something that's not a number, so clear the field
        sender.text = nil;
    }
}


- (void) sliderValueDidChange:(UISlider *)sender {
    NSString *resultText = [NSString stringWithFormat:@"%ld beers", (long)sender.value];
    self.numberOfBeersLabel.text = resultText;
    [self.beerPercentTextField resignFirstResponder];
    
}


- (void) buttonPressed:(UIButton *)sender {
          [self.beerPercentTextField resignFirstResponder];
    
    // first, calculate how much alcohol is in all those beers...
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;  //assume they are 12oz beer bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    // now, calculate the equivalent amount of wine...
    
    float ouncesInOneWineGlass = 5;  // wine glasses are usually 5oz
    float alcoholPercentageOfWine = 0.13;  // 13% is average
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    // decide whether to use "beer"/"beers" and "glass"/"glasses"
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    // generate the result text, and display it on the label
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
}


- (void) tapGestureDidFire:(UITapGestureRecognizer *)sender {
          [self.beerPercentTextField resignFirstResponder];
}


@end






