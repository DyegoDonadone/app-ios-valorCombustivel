//
//  DetalhesViewController.h
//  AlcoolGasolina
//
//  Created by Faculdade Alfa on 19/11/16.
//  Copyright (c) 2016 Faculdade Alfa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetalhesViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *lblGasolina;
@property (strong, nonatomic) IBOutlet UILabel *lblAlcool;

@property (strong, nonatomic) NSDictionary *item;

-(IBAction)voltar:(id)sender;

@end