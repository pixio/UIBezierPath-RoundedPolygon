//
//  PXViewController.m
//  UIBezierPath-RoundedPolygon
//
//  Created by Daniel Blakemore on 04/13/2015.
//  Copyright (c) 2014 Daniel Blakemore. All rights reserved.
//

#import "PXViewController.h"

#import "PXView.h"

@interface PXViewController ()

@end

@implementation PXViewController
{
    PXView * _triangleView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _triangleView = [[PXView alloc] init];
    [_triangleView setTranslatesAutoresizingMaskIntoConstraints:FALSE];
    [[self view] addSubview:_triangleView];
    
    [[self view] addConstraint:[NSLayoutConstraint constraintWithItem:_triangleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0f constant:200.0f]];
    [[self view] addConstraint:[NSLayoutConstraint constraintWithItem:_triangleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0f constant:200.0f]];
    [[self view] addConstraint:[NSLayoutConstraint constraintWithItem:_triangleView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:[self view] attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [[self view] addConstraint:[NSLayoutConstraint constraintWithItem:_triangleView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:[self view] attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self spin];
}

- (void)spin
{
    static CGFloat angle = 0;
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        angle += M_PI / 3;
        [_triangleView setTransform:CGAffineTransformMakeRotation(angle)];
    } completion:^(BOOL finished) {
        [self spin];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
