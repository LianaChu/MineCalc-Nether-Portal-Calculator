//
//  PortalCalculatorViewController.m
//  Minecraft Portal Calculator
//
//  Created by Liana Chu on 1/26/15.
//  Copyright (c) 2015 Liana Chu. All rights reserved.
//

#import "PortalCalculatorViewController.h"
#import "PortalCalculator.h"
#import <GPUImage.h>
#import "ModifiedTextView.h"

@interface PortalCalculatorViewController ()
<
    UITextViewDelegate
>

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (strong) UITextField *overworldXTextField;
@property (strong) UITextField *overworldYTextField;
@property (strong) UITextField *overworldZTextField;

@property (strong) UITextField *netherXTextField;
@property (strong) UITextField *netherYTextField;
@property (strong) UITextField *netherZTextField;

@property (strong) UILabel *overworldHeaderLabel;
@property (strong) UILabel *overworldXLabel;
@property (strong) UILabel *overworldYLabel;
@property (strong) UILabel *overworldZLabel;
@property (strong) UILabel *netherHeaderLabel;
@property (strong) UILabel *netherXLabel;
@property (strong) UILabel *netherYLabel;
@property (strong) UILabel *netherZLabel;

@property (strong) ModifiedTextView *instructionsTextView;

@property (strong) UISegmentedControl *worldSelectorSegmentedControl;

@property (nonatomic) BOOL revealed;

@end

@implementation PortalCalculatorViewController

-(id) init
{
    self = [super init];
    if (self)
    {
        [self setup];
    }
    return self;
}

-(void)setup
{
    [self setupViews];
}

-(void)setupViews
{
    [self setupBackgroundImageView];
    
    [self setupTitleLabel];
    [self setupSegmentedControl];
    [self setupOverworldHeaderAndLabels];
    [self setupNetherHeaderAndLabels];
    [self setupInstructionsTextView];
    [self setupCreditToMojang];
    
    [self setupViewsInitialVisibility];
    [self setupViewsInteractions];
}

- (void)setupBackgroundImageView
{
    UIImageView *view = [[UIImageView alloc] initWithFrame:self.view.frame];
    view.image = [self blurredBackgroundImageWithBlurRadius:0];
    self.backgroundImageView = view;
    [self.view addSubview:view];
}

- (void)setupViewsInitialVisibility
{
    
    {
        self.worldSelectorSegmentedControl.alpha = 0;

        self.overworldHeaderLabel.alpha = 0;
        self.overworldXTextField.alpha = 0;
        self.overworldYTextField.alpha = 0;
        self.overworldZTextField.alpha = 0;
        self.overworldXLabel.alpha = 0;
        self.overworldYLabel.alpha = 0;
        self.overworldZLabel.alpha = 0;
        
        self.netherHeaderLabel.alpha = 0;
        self.netherXTextField.alpha = 0;
        self.netherYTextField.alpha = 0;
        self.netherZTextField.alpha = 0;
        self.netherXLabel.alpha = 0;
        self.netherYLabel.alpha = 0;
        self.netherZLabel.alpha = 0;
        self.instructionsTextView.alpha = 0;
    }
}

- (void)setupViewsInteractions
{
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
        [self.view addGestureRecognizer:tap];
    }
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
        [self.instructionsTextView addGestureRecognizer:tap];
    }
}

-(void)setupTitleLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Minecalc: Nether Portal Calculator";
    label.frame = CGRectMake(0, 25, self.view.frame.size.width, 30);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.numberOfLines = 1;
    [self.view addSubview:label];
}

-(void)setupSegmentedControl
{
    NSArray *items = @[@"PC", @"Console"];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
    segmentedControl.layer.masksToBounds = YES;
    segmentedControl.layer.cornerRadius = 3;
    
    float segmentedControlWidth = 200 ;
    float x = (self.view.frame.size.width - segmentedControlWidth)/2;
    segmentedControl.frame = CGRectMake(x, 55, segmentedControlWidth, 30);
    segmentedControl.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
    segmentedControl.tintColor = [UIColor colorWithRed:0.27f green:0.42f blue:1.000f alpha:1.00f];
    [segmentedControl addTarget:self action:@selector(segmentedControlWasSelected:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 0;
    self.worldSelectorSegmentedControl = segmentedControl;
    [self.view addSubview:segmentedControl];
}

-(void)segmentedControlWasSelected:(UISegmentedControl *)segment
{
    if(segment.selectedSegmentIndex == 0)
    {
        NSLog(@"PC selected");
        self.netherXTextField.text = @"";
        self.netherYTextField.text = @"";
        self.netherZTextField.text = @"";
        self.overworldXTextField.text = @"";
        self.overworldYTextField.text = @"";
        self.overworldZTextField.text = @"";
    }
    else if (segment.selectedSegmentIndex == 1)
    {
        NSLog(@"Console selected");
        self.netherXTextField.text = @"";
        self.netherYTextField.text = @"";
        self.netherZTextField.text = @"";
        self.overworldXTextField.text = @"";
        self.overworldYTextField.text = @"";
        self.overworldZTextField.text = @"";
    }
}

-(void)setupOverworldHeaderAndLabels
{
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.text = @"Overworld";
    headerLabel.frame = CGRectMake(0, 83, (self.view.frame.size.width / 2), 30);
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.font = [UIFont systemFontOfSize:15];
    self.overworldHeaderLabel = headerLabel;
    [self.view addSubview:headerLabel];
    
    CGFloat widthOfLabel = 20;
    
    UILabel *xLabel = [[UILabel alloc] init];
    xLabel.text = @"X:";
    xLabel.font = [UIFont systemFontOfSize:15];
    xLabel.frame = CGRectMake(25, 120, 20, 30);
    self.overworldXLabel = xLabel;
    [self.view addSubview:xLabel];
    
    
    UILabel *yLabel = [[UILabel alloc] init];
    yLabel.text = @"Y:";
    yLabel.font = [UIFont systemFontOfSize:15];
    yLabel.frame = CGRectMake(25, 155, widthOfLabel, 30);
    self.overworldYLabel =  yLabel;
    [self.view addSubview:yLabel];
    
    UILabel *zLabel = [[UILabel alloc] init];
    zLabel.text = @"Z:";
    zLabel.font = [UIFont systemFontOfSize:15];
    zLabel.frame = CGRectMake(25, 190, widthOfLabel, 30);
    self.overworldZLabel = zLabel;
    [self.view addSubview:zLabel];
    
    {
        UITextField *textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(45, 120, 85, 30);
        textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        textField.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [self.view addSubview:textField];
        self.overworldXTextField = textField;
        [textField addTarget:self action:@selector(overworldXTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
    }
    {
        UITextField *textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(45, 155, 85, 30);
        textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        textField.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [self.view addSubview:textField];
        self.overworldYTextField = textField;
        [textField addTarget:self action:@selector(overworldYTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
    }
    {
        UITextField *textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(45, 190, 85, 30);
        textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        textField.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [self.view addSubview:textField];
        self.overworldZTextField = textField;
        [textField addTarget:self action:@selector(overworldZTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
    }
}

- (BOOL)isPCSelected
{
    return (self.worldSelectorSegmentedControl.selectedSegmentIndex == 0);
}

-(void)overworldXTextFieldChanged
{
    NSString *textFieldText = self.overworldXTextField.text;
    if ((textFieldText.length > 0) && self.isPCSelected) {
        int intValue = textFieldText.intValue;
        int convertedValue = [PortalCalculator PCNetherXCoordIntFromOverworldXCoordInt:intValue];
        self.netherXTextField.text = [NSString stringWithFormat:@"%d",convertedValue];
    }
    else {
        int intValue = textFieldText.intValue;
        int convertedValue = [PortalCalculator ConsoleNetherXCoordIntFromOverworldXCoordInt:intValue];
        self.netherXTextField.text = [NSString stringWithFormat:@"%d",convertedValue];
    }
}

-(void)overworldYTextFieldChanged
{
    self.netherYTextField.text = self.overworldYTextField.text;
}

-(void)overworldZTextFieldChanged
{
    NSString *textFieldText = self.overworldZTextField.text;
    if ((textFieldText.length > 0) && self.isPCSelected) {
    int intValue = textFieldText.intValue;
    int convertedValue = [PortalCalculator PCNetherZCoordIntFromOverworldZCoordInt:intValue];
    self.netherZTextField.text = [NSString stringWithFormat:@"%d",convertedValue];
    }
    else {
        int intValue = textFieldText.intValue;
        int convertedValue = [PortalCalculator ConsoleNetherZCoordIntFromOverworldZCoordInt:intValue];
        self.netherZTextField.text = [NSString stringWithFormat:@"%d",convertedValue];
    }
}

-(void)setupNetherHeaderAndLabels
{
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.text = @"Nether";
    headerLabel.frame = CGRectMake((self.view.frame.size.width/2), 83, (self.view.frame.size.width/2), 30);
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.font = [UIFont systemFontOfSize:15];
    self.netherHeaderLabel = headerLabel;
    [self.view addSubview:headerLabel];
    
    CGFloat widthOfLabel = 20;
    CGFloat widthOfTextField = 85;
    CGFloat combinedWidthOfLabelAndTextField = widthOfLabel + widthOfTextField;
    CGFloat xCoordForLabels = ((self.view.frame.size.width * 0.75) - (combinedWidthOfLabelAndTextField * 0.5));
    CGFloat xCoordForTextFields = xCoordForLabels + widthOfLabel;
    
    UILabel *xLabel = [[UILabel alloc] init];
    xLabel.text = @"X:";
    xLabel.font = [UIFont systemFontOfSize:15];
    xLabel.frame = CGRectMake(xCoordForLabels, 120, widthOfLabel, 30);
    self.netherXLabel = xLabel;
    [self.view addSubview:xLabel];
    
    UILabel *yLabel = [[UILabel alloc] init];
    yLabel.text = @"Y:";
    yLabel.font = [UIFont systemFontOfSize:15];
    yLabel.frame = CGRectMake(xCoordForLabels, 155, widthOfLabel, 30);
    self.netherYLabel = yLabel;
    [self.view addSubview:yLabel];
    
    UILabel *zLabel = [[UILabel alloc] init];
    zLabel.text = @"Z:";
    zLabel.font = [UIFont systemFontOfSize:15];
    zLabel.frame = CGRectMake(xCoordForLabels, 190, widthOfLabel, 30);
    self.netherZLabel = zLabel;
    [self.view addSubview:zLabel];
    
    UITextField *netherXTextField = [[UITextField alloc] init];
    netherXTextField.frame = CGRectMake(xCoordForTextFields, 120, widthOfTextField, 30);
    netherXTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    netherXTextField.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [self.view addSubview:netherXTextField];
    self.netherXTextField = netherXTextField;
    [netherXTextField addTarget:self action:@selector(netherXTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
    
    UITextField *netherYTextField = [[UITextField alloc] init];
    netherYTextField.frame = CGRectMake(xCoordForTextFields, 155, widthOfTextField, 30);
    netherYTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    netherYTextField.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [self.view addSubview:netherYTextField];
    self.netherYTextField = netherYTextField;
    [netherYTextField addTarget:self action:@selector(netherYTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
    
    UITextField *netherZTextField = [[UITextField alloc] init];
    netherZTextField.frame = CGRectMake(xCoordForTextFields, 190, widthOfTextField, 30);
    netherZTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    netherZTextField.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [self.view addSubview:netherZTextField];
    self.netherZTextField = netherZTextField;
    [netherZTextField addTarget:self action:@selector(netherZTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
}

-(void)netherXTextFieldChanged
{
    NSString *textFieldText = self.netherXTextField.text;
    if ((textFieldText.length > 0) && (!self.isPCSelected)) {
        int intValue = textFieldText.intValue;
        int convertedValue = [PortalCalculator PCOverworldXCoordIntFromNetherXCoordInt:intValue];
        self.overworldXTextField.text = [NSString stringWithFormat:@"%d",convertedValue];
    }
    else {
        int intValue = textFieldText.intValue;
        int convertedValue = [PortalCalculator ConsoleOverworldXCoordIntFromNetherXCoordInt:intValue];
        self.overworldXTextField.text = [NSString stringWithFormat:@"%d",convertedValue];
    }
}

-(void)netherYTextFieldChanged
{
    self.overworldYTextField.text = self.netherYTextField.text;
}

-(void)netherZTextFieldChanged
{
    NSString *textFieldText = self.netherZTextField.text;
    if ((textFieldText.length > 0) && (!self.isPCSelected)) {
        int intValue = textFieldText.intValue;
        int convertedValue = [PortalCalculator PCOverworldZCoordIntFromNetherZCoordInt:intValue];
        self.overworldZTextField.text = [NSString stringWithFormat:@"%d",convertedValue];
    }
    else {
        int intValue = textFieldText.intValue;
        int convertedValue = [PortalCalculator ConsoleOverworldZCoordIntFromNetherZCoordInt:intValue];
        self.overworldZTextField.text = [NSString stringWithFormat:@"%d",convertedValue];
    }
}

-(void)setupInstructionsTextView
{
    ModifiedTextView *instructionsTextView = [[ModifiedTextView alloc] init];
    self.instructionsTextView = instructionsTextView;
    instructionsTextView.text = @"To create two linked portals:\n\n"
    "1. Select whether you are playing on PC or Console.\n\n"
    
    "2. Choose a location for your portal in the Overword. Build the portal frame without lighting it.\n\n"
        
    "3. Stand in the portal as if you were using it, and press F3 to find your X, Y, and Z coordinates. Type these into the calculator, ignoring their decimal parts. Be sure to include whether the numbers are positive or negative. Double check that you put in the right numbers.\n\n"
            
    "4. Light the portal, and go through to the nether. Go to the calculated coordinates shown for the Nether, and build a nether portal one block down, so that when you stand in the portal, your coordinates will exactly match the calculated coordinates.\n\n"
                
    "5. Light the portal! If you did everything right, this portal should now link to your Overworld portal.\n\n"
                
    "Additional tips:\n\n"
                
    "If the game spawned another portal for you when you entered the nether, you may disable or destroy that one.\n\n"
                    
    "This method also works in reverse! You can type in Nether coordinates to find out where to build a portal in the Overworld that will link to it.\n\n"
    
    "Try to build your portals as close to the calculated coordinates if you can. Even though your portals may still be linked if your coordinates are slightly off, they may no longer be linked in the future if another portal is built nearby in either dimension. Placing your portals precisely at the calculated coordinates will ensure that they will always be linked.\n";
    
    instructionsTextView.backgroundColor = [UIColor clearColor];
    instructionsTextView.textColor = [UIColor whiteColor];
    CGFloat textViewYCoord = 240;
    CGFloat paddingBetweenInstructionsAndCreditLabels = 5;
    CGFloat paddingOnLeftAndRightOfInstructionsTextView = 25;
    instructionsTextView.frame = CGRectMake(paddingOnLeftAndRightOfInstructionsTextView, textViewYCoord, (self.view.frame.size.width - (2*paddingOnLeftAndRightOfInstructionsTextView)), (self.view.frame.size.height - textViewYCoord - 20 - paddingBetweenInstructionsAndCreditLabels));
     [instructionsTextView setFont:[UIFont systemFontOfSize:15]];
    instructionsTextView.delegate = self;
    [self.view addSubview:instructionsTextView];
}

-(void)setupCreditToMojang
{
    UILabel *creditLabel = [[UILabel alloc] init];
    creditLabel.text = @"Copyright © 2015 Liana Chu.\nMinecraft ®/™ & © 2009-2013 Mojang/Notch.";
    creditLabel.numberOfLines = 2;
    creditLabel.textColor = [UIColor colorWithWhite:1 alpha:0.6];
    creditLabel.textAlignment = NSTextAlignmentCenter;
    [creditLabel setFont:[UIFont systemFontOfSize:8]];
    [creditLabel sizeToFit];
    CGFloat y = self.view.frame.size.height - creditLabel.frame.size.height - 2;
    CGRect yOffsetFrame = CGRectMake(0, y, self.view.frame.size.width, creditLabel.frame.size.height);
    creditLabel.frame = yOffsetFrame;
    [self.view addSubview:creditLabel];
}

- (UIImage *)imageWithGaussianBlur:(UIImage *)image withBlurRadius:(CGFloat)blurRadius
{
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
    GPUImageGaussianBlurFilter *blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
    blurFilter.blurRadiusInPixels = blurRadius;
    blurFilter.blurPasses = 1;
    [stillImageSource addTarget:blurFilter];
    [blurFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    UIImage *imageOut = [blurFilter imageFromCurrentFramebuffer];
    
    return imageOut;
}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self reveal];
}

- (void)reveal
{
    if (self.revealed) {
        return;
    }
    self.revealed = YES;
    
    UIImage * toImage = [self blurredBackgroundImageWithBlurRadius:2];
    [UIView transitionWithView:self.backgroundImageView duration:0.6f options:UIViewAnimationOptionTransitionCrossDissolve animations:^
    {
        self.backgroundImageView.image = toImage;
    } completion:^(BOOL finished)
    {
    }];
    

    typeof(self) __weak weakSelf = self;
    [UIView animateWithDuration:0.6 animations:^
    {
        weakSelf.overworldHeaderLabel.alpha = 1;
        weakSelf.overworldXTextField.alpha = 1;
        weakSelf.overworldYTextField.alpha = 1;
        weakSelf.overworldZTextField.alpha = 1;
        weakSelf.overworldXLabel.alpha = 1;
        weakSelf.overworldYLabel.alpha = 1;
        weakSelf.overworldZLabel.alpha = 1;
        
        weakSelf.netherHeaderLabel.alpha = 1;
        weakSelf.netherXTextField.alpha = 1;
        weakSelf.netherYTextField.alpha = 1;
        weakSelf.netherZTextField.alpha = 1;
        weakSelf.netherXLabel.alpha = 1;
        weakSelf.netherYLabel.alpha = 1;
        weakSelf.netherZLabel.alpha = 1;
    
        weakSelf.instructionsTextView.alpha = 1;
        
        weakSelf.worldSelectorSegmentedControl.alpha = 1;
    }];
}

- (UIImage *)blurredBackgroundImageWithBlurRadius:(CGFloat)blurRadius
{
    UIImage *image = [UIImage imageNamed:@"background8.png"];
    UIImage *blurredImage = [self imageWithGaussianBlur:image withBlurRadius:blurRadius];
    
    return blurredImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Delegation - UITextViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self dismissKeyboard];
}

@end
