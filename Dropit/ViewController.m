//
//  ViewController.m
//  Dropit
//
//  Created by Stepan Paholyk on 10/6/16.
//  Copyright © 2016 Stepan Paholyk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIGravityBehavior *gravity;

@end


@implementation ViewController

static const CGSize RECT_SIZE = {40, 40};

#pragma mark - Lazy instatiation

- (UIDynamicAnimator*) animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gameView];
    }
    return _animator;
}

- (UIGravityBehavior*) gravity {
    if (!_gravity) {
        _gravity = [[UIGravityBehavior alloc] init];
        _gravity.magnitude = 0.8f;
        [self.animator addBehavior:_gravity];
    }
    return _gravity;
}

#pragma mark - Gestures

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    [self drop];
}

- (void) drop {
    // create drooped rectangle
    CGRect dropFrame;
    dropFrame.origin = CGPointZero;
    dropFrame.size = RECT_SIZE;
    
    // generate random x.origin for rect
    int x = (arc4random()%(int)(CGRectGetWidth(self.gameView.bounds))) / RECT_SIZE.width;
    dropFrame.origin.x = x*RECT_SIZE.width;
    
    UIView *dropView = [[UIView alloc] initWithFrame:dropFrame];
    [dropView setBackgroundColor:[self randomColor]];
    [self.gameView addSubview:dropView];
    
    [self.gravity addItem:dropView];
}

- (UIColor*) randomColor {
    switch (arc4random()%5) {
        case 1: return [UIColor cyanColor];
        case 2: return [UIColor yellowColor];
        case 3: return [UIColor redColor];
        case 4: return [UIColor purpleColor];
        case 5: return [UIColor magentaColor];
    }
    return [UIColor blackColor];
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
