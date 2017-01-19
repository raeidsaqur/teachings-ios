//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"
#import "UIView+Extensions.h"

@interface LPGViewController ()

    //Model Object
    @property (strong, nonatomic) Pet* pet;

    @property (weak, nonatomic) IBOutlet UIImageView *appleImageView;
    @property (nonatomic) UIImageView *petImageView;

    @property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *longTouchGestureRecognizer;
    @property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGestureRecognizer;
    @property (strong, nonatomic) IBOutlet UIPinchGestureRecognizer *pinchGestureRecognizer;


    @property (strong, nonatomic) IBOutlet UILabel *labelState;

    @property (strong, nonatomic) UIImageView* extraAppleImageView;    
@end

@implementation LPGViewController

#pragma mark - Life Cycle Methods
- (void)viewDidLoad
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];
    
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.petImageView.image = [UIImage imageNamed:@"default"];
    
    [self.view addSubview:self.petImageView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.petImageView addGestureRecognizer:self.panGestureRecognizer];
    [self.petImageView setUserInteractionEnabled:YES];
    
    [self.appleImageView addGestureRecognizer:self.longTouchGestureRecognizer];
    [self.appleImageView setUserInteractionEnabled:YES];
    
    self.pet = [Pet new];
    self.pet.delegate = self;
}

#pragma mark - PetDelegate Methods

-(void) onPetStateChanged:(PetState)petState {
    //NSLog(@"%s", __PRETTY_FUNCTION__);
    
    switch (petState) {
        case PetState_Happy:
            self.petImageView.image = [UIImage imageNamed:@"default"];
            [UIView shakeItAnimation:self.petImageView];
            self.labelState.text = @"HAPPY";
            //self.petImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
        case PetState_Sleeping:
            self.petImageView.image = [UIImage imageNamed:@"sleeping"];
            //self.petImageView.transform = CGAffineTransformIdentity;
            self.labelState.text = @"SLEEPY";
            break;
        case PetState_Grumpy:
            self.petImageView.image = [UIImage imageNamed:@"grumpy"];
            //self.petImageView.transform = CGAffineTransformIdentity;
            self.labelState.text = @"GRUMPY";
            break;
        default:
            break;
    }
}


#pragma mark - Gesture Recognizer methods

- (IBAction)onPanned:(UIPanGestureRecognizer*)sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self.pet petWithVelocity:[sender velocityInView:self.view]];
}

- (IBAction)onPinched:(UIPinchGestureRecognizer*)sender {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    CGPoint point = [sender locationOfTouch:0 inView:self.view];
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            //Make new apple
            self.extraAppleImageView = [UIImageView new];
            self.extraAppleImageView.frame = self.appleImageView.frame;
            self.extraAppleImageView.center = point;
            self.extraAppleImageView.image = [UIImage imageNamed:@"apple"];
            
            [self.view addSubview:self.extraAppleImageView];
            break;
        case UIGestureRecognizerStateChanged:
            //Move the apple
            self.extraAppleImageView.center = point;
            
            break;
        case UIGestureRecognizerStateEnded:
            //Check if it is over the pet
            if (CGRectContainsPoint(self.petImageView.frame, point))
            {
                //Feed the pet
                [self.pet feed];
                
                //Destroy apple
                [self.extraAppleImageView removeFromSuperview];
                self.extraAppleImageView = nil;
            }
            else
            {
                //Falls off the screen
                [UIView animateWithDuration:1
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseIn
                                 animations:^{
                                     self.extraAppleImageView.center = CGPointMake(self.extraAppleImageView.center.x, self.view.bounds.size.height + self.extraAppleImageView.bounds.size.height);
                                 }
                                 completion:^(BOOL finished) {
                                     [self.extraAppleImageView removeFromSuperview];
                                     self.extraAppleImageView = nil;
                                 }];
            }
            break;
        default:
            break;
    }
}

- (IBAction)onLongTouchChanged:(UILongPressGestureRecognizer*)sender {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    //Get coordinate
    CGPoint point = [sender locationOfTouch:0 inView:self.view];
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            //Make new apple
            self.extraAppleImageView = [UIImageView new];
            self.extraAppleImageView.frame = self.appleImageView.frame;
            self.extraAppleImageView.center = point;
            self.extraAppleImageView.image = [UIImage imageNamed:@"apple"];
            
            [self.view addSubview:self.extraAppleImageView];
            break;
        case UIGestureRecognizerStateChanged:
            //Move the apple
            self.extraAppleImageView.center = point;
            
            break;
        case UIGestureRecognizerStateEnded:
            //Check if it is over the pet
            if (CGRectContainsPoint(self.petImageView.frame, point))
            {
                //Feed the pet
                [self.pet feed];
                
                //Destroy apple
                [self.extraAppleImageView removeFromSuperview];
                self.extraAppleImageView = nil;
            }
            else
            {
                //Falls off the screen
                
                [UIView animateWithDuration:1
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseIn
                                 animations:^{
                                     self.extraAppleImageView.center = CGPointMake(self.extraAppleImageView.center.x, self.view.bounds.size.height + self.extraAppleImageView.bounds.size.height);
                                 }
                                 completion:^(BOOL finished) {
                                     [self.extraAppleImageView removeFromSuperview];
                                     self.extraAppleImageView = nil;
                                 }];
                
            }
            break;
        default:
            break;
    }
}


@end
