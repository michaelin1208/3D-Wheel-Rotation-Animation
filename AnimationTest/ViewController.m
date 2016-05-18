//
//  ViewController.m
//  AnimationTest
//
//  Created by Michaelin on 16/5/17.
//  Copyright © 2016年 Michaelin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    UIImageView *imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // create wheel imageview
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"luntai-069.jpg"]];
    imageView.frame = CGRectMake(50, 50, 200, 200);
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    
    [self.view addSubview:imageView];
    
    // setup the anchor point of wheel image view and rotate it according to the 3D view.
    [imageView.layer setAnchorPoint:CGPointMake(0.5, 0.5)];
    [imageView.layer setTransform: CATransform3DMakeRotation(50 * (M_PI / 180.0f), 0, 1, 0)];
    
    // start animation infinitely
    [self keepRotationInDirection:-1 duration:1];
    
}

-(void)keepRotationInDirection:(int)direction duration:(NSTimeInterval)duration{
    float durationStep = duration/4;
    [UIView animateWithDuration:durationStep delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        // the calculation about the rotation degree for animation to imitate the runing wheel.
        // CATransform3DRotate is better which calculates depends on the current rotation status.
        [imageView.layer setTransform:CATransform3DRotate(imageView.layer.transform, M_PI * 0.5f, 0, 0, direction)];
        
        // CATransform3DMakeRotation will only set the final rotation status as its attributes.
//        [imageView.layer setTransform:CATransform3DMakeRotation(M_PI * 0.5f, 0, 0, direction)];
    } completion:^(BOOL finished) {
        [self keepRotationInDirection:direction duration:duration];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
