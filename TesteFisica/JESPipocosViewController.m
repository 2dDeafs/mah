//
//  JESPipocosViewController.m
//  TesteFisica
//
//  Created by Jessica Reinheimer de Lima on 2/18/14.
//  Copyright (c) 2014 Nothing. All rights reserved.
//

#import "JESPipocosViewController.h"

@interface JESPipocosViewController () <UICollisionBehaviorDelegate>

@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) UIGravityBehavior *gravity;
@property (nonatomic) NSMutableArray *particles;
@property (nonatomic) NSTimer *timer;

@end

@implementation JESPipocosViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    // animations
    
    self.particles = [[NSMutableArray alloc] initWithCapacity:100];
    
    int i;
    for (i = 0; i < 50; i++)
    {
        UIImageView *lala = [[UIImageView alloc] initWithFrame: CGRectMake(i * self.view.frame.size.width / 50, 0, 15, 15)];
        [lala setBackgroundColor:[UIColor colorWithRed:(i+3/255.0f) green:i*2/255.0f blue:(i % 2)*25.0/255.0f alpha:1]];
        [self.particles addObject:lala];
        [self.view addSubview:self.particles[i]];
    }
    
    
    // Gravidade
    self.gravity = [[UIGravityBehavior alloc] init];
    //gravity.gravityDirection = CGVectorMake(0, 0);
    
    // Colisão
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:self.particles];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    // Elasticidade
    UIDynamicItemBehavior *elasticity = [[UIDynamicItemBehavior alloc] initWithItems:self.particles];
    elasticity.elasticity = 0.6;
    //elasticity.resistance = -1;
    
    
    // Controlador
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    [animator addBehavior:self.gravity];
    [animator addBehavior:collision];
    [animator addBehavior:elasticity];
    
    self.animator = animator;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(vaiAdicionandoGravidade) userInfo:Nil repeats:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.timer invalidate];
}

-(void) vaiAdicionandoGravidade
{
    if (self.gravity.items.count < self.particles.count)
        [self.gravity addItem:self.particles[self.gravity.items.count]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
