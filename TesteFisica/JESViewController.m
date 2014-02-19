//
//  JESViewController.m
//  TesteFisica
//
//  Created by Jessica Reinheimer de Lima on 2/17/14.
//  Copyright (c) 2014 Nothing. All rights reserved.
//

#import "JESViewController.h"

@interface JESViewController () <UICollisionBehaviorDelegate>

@property (nonatomic) UIImageView *umQuadrado;
@property (nonatomic) UIImageView *outroQuadrado;

@property (strong, nonatomic) UIDynamicAnimator *animator;

@end

@implementation JESViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

// colocar animações aqui
-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];

    self.umQuadrado = [[UIImageView alloc] initWithFrame:CGRectMake(200, 0, 100, 50)];
    [self.umQuadrado setBackgroundColor:[UIColor blackColor]];
    self.outroQuadrado = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 20, 50)];
    [self.outroQuadrado setBackgroundColor:[UIColor colorWithRed:(100.0f/255.0f) green:190.0f/255.0f blue:72.0f/255.0f alpha:1]];
    
    [self.view addSubview:self.outroQuadrado];
    [self.view addSubview:self.umQuadrado];
    
    // UIDynamics
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.umQuadrado, self.outroQuadrado]];
    [animator addBehavior:gravity];

    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.umQuadrado, self.outroQuadrado]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [collision addBoundaryWithIdentifier:@"escorregador" fromPoint:CGPointMake(0, 0) toPoint:CGPointMake(50, 200)];
    [collision addBoundaryWithIdentifier:@"funil" fromPoint:CGPointMake(self.view.frame.size.width, 0) toPoint:CGPointMake(self.view.frame.size.width - 50, 200)];
    collision.collisionDelegate = self;
    [animator addBehavior:collision];
    
    
    self.animator = animator;

}

#pragma mark - Collision Delegate

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
