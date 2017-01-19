//
//  Pet.m
//  Phonagotchi
//
//  Created by Ivan Cheung on 2016-11-10.
//  Copyright © 2016 Lighthouse Labs. All rights reserved.
//

#import "Pet.h"

@interface Pet()
    @property (strong, nonatomic) NSTimer* sleepTimer;
    @property (nonatomic) float timeRemaining;
@end

@implementation Pet

    float const magnitudeMax = 1000.0;
    float const awakeTime = 5.0;

    -(id) init {
        self = [super init];
        if (self) {
            self.sleepTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                              repeats:YES
                                                                block:^(NSTimer * _Nonnull timer) {
                _timeRemaining--;
                
                if (_timeRemaining <= 0) {
                    self.state = PetState_Sleeping;
                }
            }];
        }
        
        return self;
    }

#pragma mark - Property Setters


    -(void) setState:(PetState)state {
        //NSLog(@"%s", __PRETTY_FUNCTION__);
        _state = state;
        
        if ([self.delegate respondsToSelector:@selector(onPetStateChanged:)]) {
            [self.delegate onPetStateChanged:self.state];
        }
        
        if (state != PetState_Sleeping) {
            self.timeRemaining = awakeTime;
        }
    }

#pragma mark - Actions

    -(void) petWithVelocity:(CGPoint) velocity {
        NSLog(@"%s", __PRETTY_FUNCTION__);
        //Get magnitude
        float magnitude = sqrtf(powf(velocity.x, 2) + powf(velocity.y, 2));
        NSLog(@"Petting magnitude = %f", magnitude);
        if (magnitude > magnitudeMax) {
            self.state = PetState_Grumpy;
            
        }
        
        if (self.state != PetState_Grumpy) {
            self.state = PetState_Happy;
        }
    }

    -(void) feed {
        NSLog(@"%s", __PRETTY_FUNCTION__);
        self.state = PetState_Happy;
    }
@end
