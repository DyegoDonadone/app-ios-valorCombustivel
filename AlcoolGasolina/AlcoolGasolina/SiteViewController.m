//
//  SiteViewController.m
//  AlcoolGasolina
//
//  Created by Faculdade Alfa on 19/11/16.
//  Copyright (c) 2016 Faculdade Alfa. All rights reserved.
//

#import "SiteViewController.h"

@interface SiteViewController ()

@end

@implementation SiteViewController

@synthesize webSite;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *urlString = @"http://www.alfaumuarama.com.br";
    
    //cria url da string
    NSURL *url = [NSURL URLWithString:urlString];
    
    // cria requisicao da url
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //enquadra a pagina dentro do navegador
    webSite.scalesPageToFit = YES;
    
    //carrega o request da url no navegador
    [webSite loadRequest:request];
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [self.spinner startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.spinner startAnimating];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.spinner stopAnimating];
}

-(IBAction)voltar:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
