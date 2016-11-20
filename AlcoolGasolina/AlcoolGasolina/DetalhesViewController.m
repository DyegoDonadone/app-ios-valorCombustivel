//
//  DetalhesViewController.m
//  AlcoolGasolina
//
//  Created by Faculdade Alfa on 19/11/16.
//  Copyright (c) 2016 Faculdade Alfa. All rights reserved.
//

#import "DetalhesViewController.h"

@interface DetalhesViewController ()

@end

@implementation DetalhesViewController

@synthesize item, lblAlcool, lblGasolina;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (item) {
        lblGasolina.text = [NSString stringWithFormat:@"Gasolina: R$ %@", [item objectForKey:@"Gasolina"]];
        lblAlcool.text = [NSString stringWithFormat:@"Alcool: R$ %@",[item objectForKey:@"Alcool"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)voltar:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
