//
//  UIView+Extensions.m
//  Finaeo
//
//  Created by Raeid Saqur on 2016-09-28.
//  Copyright © 2016 FINAEO Inc. All rights reserved.
//

#import "UIView+Extensions.h"

@implementation UIView (Extension)

+ (void)shakeItAnimation:(UIView *)view {
    const int reset = 5;
    const int maxShakes = 6;
    
    static int shakes = 0;
    static int translate = reset;
    
    [UIView animateWithDuration:0.09 - (shakes * .01)
                          delay:0.01f
                        options:(enum UIViewAnimationOptions)UIViewAnimationCurveEaseInOut
                     animations:^{
                         view.transform = CGAffineTransformMakeTranslation(translate, 0);
                     }
                     completion:^(BOOL finished) {
                         if (shakes < maxShakes) {
                             shakes++;
                             if (translate > 0) {
                                 translate--;
                             }
                             translate *= -1;
                             [UIView shakeItAnimation:view];
                         } else {
                             view.transform = CGAffineTransformIdentity;
                             shakes = 0;
                             translate = reset;
                             
                             return;
                         }
                     }];
}

- (void)circle {
    self.layer.cornerRadius = self.bounds.size.height / 2;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [UIColor purpleColor].CGColor;
}

@end
