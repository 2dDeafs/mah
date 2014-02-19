//
//  JESGradeViewController.m
//  TesteFisica
//
//  Created by Jessica Reinheimer de Lima on 2/18/14.
//  Copyright (c) 2014 Nothing. All rights reserved.
//

#import "JESGradeViewController.h"

@interface JESGradeViewController ()
{
    NSMutableArray *cadados;
    NSMutableArray *cores;
    UIDynamicAnimator *animator;
    UIGravityBehavior *gravity;
    NSMutableArray *collisions;
}

@end

@implementation JESGradeViewController

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
    
    // Objetos
    cadados = [[NSMutableArray alloc] init];
    cores = [[NSMutableArray alloc] init];
    
    CGFloat umaLargura = 60, umaAltura = 60;
    
    for (int i = 70; i < self.view.frame.size.height - 65; i += 65) {
        for (int j = 30; j < self.view.frame.size.width - 65; j += 65) {
            CGFloat umX, umY;
            umX = j;
            umY = i;
            
            UIImageView *img;
            CGRect rect;
            rect = CGRectMake(umX, umY, umaLargura, umaAltura);
            img = [[UIImageView alloc] initWithFrame:rect];
            [cadados addObject:img];
            [img setBackgroundColor:[UIColor colorWithRed:((sqrt(i) * sqrt(j) + 2)/255.0f) green:((i + j + 2)/255.0f) blue:((2 * j - i)/255.0f) alpha:1]];
            [self.view addSubview:img];
        }
    }
    
    // Controlador
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    
    // Gravidade
    gravity = [[UIGravityBehavior alloc] init];
    
    // Colisão
    int quantas = ((int)(self.view.frame.size.height - 65) / umaAltura);
    collisions = [[NSMutableArray alloc] initWithCapacity:quantas];
    for (int k = 1; k <= quantas; k++) {
        
        UICollisionBehavior *auxCollision = [[UICollisionBehavior alloc] init];
        
        CGFloat outroY = 70 + k * 65;
        [auxCollision addBoundaryWithIdentifier:[NSString stringWithFormat:@"linha%d", k] fromPoint:CGPointMake(0, outroY) toPoint:CGPointMake(self.view.frame.size.width, outroY)];
        for (int l = 0; l < self.view.frame.size.width - 65) / umaLargura; l++) {
            [auxCollision addItem:cadados[l + k * ]];
        }
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
