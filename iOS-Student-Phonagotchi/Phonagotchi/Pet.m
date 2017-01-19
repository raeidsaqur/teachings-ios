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
    float const magnitudeMax = 10000.0;
    float const awakeTime = 5.0;

    -(id) init
    {
        self = [super init];
        
        if (self)
        {
            self.sleepTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
                _timeRemaining--;
                
                if (_timeRemaining <= 0)
                {
                    self.state = PetState_Sleeping;
                }
            }];
        }
        
        return self;
    }

    -(void) setState:(PetState)state
    {
        _state = state;
        
        if ([self.delegate respondsToSelector:@selector(onPetStateChanged:)])
        {
            [self.delegate onPetStateChanged:self.state];
        }
        
        if (state != PetState_Sleeping)
        {
            self.timeRemaining = awakeTime;
        }
    }

    -(void) petWithVelocity:(CGPoint) velocity
    {
        //Get magnitude
        float magnitude = sqrtf(powf(velocity.x, 2) + powf(velocity.x, 2));
        
        if (magnitude > magnitudeMax)
        {
            self.state = PetState_Grumpy;
        }
    }

    -(void) feed
    {
        self.state = PetState_Happy;
    }
@end
