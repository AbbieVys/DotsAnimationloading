//
//  Dots.m
//  DotsAnimation
//
//  Created by Abbie on 3/24/15.
//  Copyright (c) 2015 Abbie. All rights reserved.
//

#import "Dots.h"

#define kShowHideAnimateDuration 0.2


static Dots *_sharedInstance = nil;

@implementation Dots {
    NSMutableArray *hudRects;
    
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
        self.userInteractionEnabled = NO;
        self.alpha = 0;
    }
    return self;
}

#pragma mark - config UI

- (void)configUI {
    self.backgroundColor = [UIColor clearColor];
    
    UIView *rect1 = [self drawRectAtPosition:CGPointMake(0, 0)];
    UIView *rect2 = [self drawRectAtPosition:CGPointMake(40, 0)];
    UIView *rect3 = [self drawRectAtPosition:CGPointMake(80, 0)];
    
    [self addSubview:rect1];
    [self addSubview:rect2];
    [self addSubview:rect3];
    
    [self doAnimateCycleWithRects:@[rect1, rect2, rect3]];
}

#pragma mark - animation

- (void)doAnimateCycleWithRects:(NSArray *)rects {
    __weak typeof(self) wSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.25 * 0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wSelf animateRect:rects[0] withDuration:0.25];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.50 * 0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [wSelf animateRect:rects[1] withDuration:0.50];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.80 * 0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [wSelf animateRect:rects[2] withDuration:0.75];
            });
        });
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wSelf doAnimateCycleWithRects:rects];
    });
}

- (void)animateRect:(UIView *)rect withDuration:(NSTimeInterval)duration {
    //  [rect setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    
    //    [UIView animateWithDuration:duration
    //                     animations:^{
    //                         rect.alpha = 1;
    //                         rect.transform = CGAffineTransformMakeScale(1, 1.3);
    //                     } completion:^(BOOL finished) {
    //        [UIView animateWithDuration:duration
    //                         animations:^{
    //                             rect.alpha = 0.5;
    //                             rect.transform = CGAffineTransformMakeScale(1, 1);
    //                         } completion:^(BOOL f) {
    //        }];
    //    }];
    int i = 0;
    CGFloat delay = 0.1*(i);
    [UIView animateWithDuration:1 delay:delay options:UIViewAnimationCurveEaseInOut | UIViewAnimationOptionRepeat |  UIViewAnimationOptionAutoreverse animations:^(void){
        rect.transform = CGAffineTransformMakeScale(0.1, 0.1);
        rect.alpha = 1;
    }completion:nil];
}

#pragma mark - drawing

- (UIView *)drawRectAtPosition:(CGPoint)positionPoint {
    UIView *rect = [[UIView alloc] init];
    CGRect rectFrame;
    rectFrame.size.width = 20;
    rectFrame.size.height = 20;
    rectFrame.origin.x = positionPoint.x;
    rectFrame.origin.y = 0;
    rect.frame = rectFrame;
    rect.backgroundColor = [UIColor redColor];
    rect.alpha = 0.5;
    rect.layer.cornerRadius = 10;
    
    if (hudRects == nil) {
        hudRects = [[NSMutableArray alloc] init];
    }
    [hudRects addObject:rect];
    
    return rect;
}

#pragma mark - Setters

- (void)setHudColor:(UIColor *)hudColor {
    for (UIView *rect in hudRects) {
        rect.backgroundColor = hudColor;
    }
}


#pragma mark - show Animation



- (void)showAnimated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:kShowHideAnimateDuration animations:^{
            self.alpha = 1;
        }];
    } else {
        self.alpha = 1;
    }
}

- (void)dealloc {
    hudRects = nil;
}
@end
