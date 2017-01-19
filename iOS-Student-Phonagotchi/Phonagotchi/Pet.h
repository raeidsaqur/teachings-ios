//
//  Pet.h
//  Phonagotchi
//
//  Created by Ivan Cheung on 2016-11-10.
//  Copyright © 2016 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum PetState {
    PetState_Happy,
    PetState_Grumpy,
    PetState_Sleeping
} PetState;

@protocol PetDelegate <NSObject>

-(void) onPetStateChanged:(PetState) petState;

@end

@interface Pet : NSObject
    //Tells whether pet is grumpy or not
    @property (readonly, nonatomic) PetState state;
    @property (nonatomic) float restfulness;
    @property (weak) id<PetDelegate> delegate;
    //@property (readonly, nonatomic) BOOL isGrumpy;

    -(void) petWithVelocity:(CGPoint) velocity;
    -(void) feed;
@end
