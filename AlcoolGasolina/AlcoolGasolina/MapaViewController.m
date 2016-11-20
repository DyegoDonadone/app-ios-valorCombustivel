//
//  MapaViewController.m
//  AlcoolGasolina
//
//  Created by Faculdade Alfa on 19/11/16.
//  Copyright (c) 2016 Faculdade Alfa. All rights reserved.
//

#import "MapaViewController.h"

@interface MapaViewController ()

@end

@implementation MapaViewController

@synthesize mapa, locManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)limparPinos {
    //removendo todos os pinos do mapa
    [mapa removeAnnotations:mapa.annotations];
}

-(IBAction)alfa:(id)sender{
    [self limparPinos];
    
    //criando um pino para depois adicionar no mapa
    MKPointAnnotation *pino = [[MKPointAnnotation alloc] init];
    
    //adicionando a coordenada do alfa, por latitude e longitude
    pino.coordinate = CLLocationCoordinate2DMake(-23.759554, -53.313904);
    
    pino.title = @"Faculdade Alfa Umuarama";
    
    //adicionando o pino no mapa
    [mapa addAnnotation:pino];
    
    
    //criando uma taxa de zoom para o mapa
    MKCoordinateSpan zoom = MKCoordinateSpanMake(0.01, 0.01);
    
    //criando a regiao que recebera o zoom no mapa
    MKCoordinateRegion regiao = MKCoordinateRegionMake(pino.coordinate, zoom);
    
    // adicionado a regiao com zoom no mapa de forma animada.
    [mapa setRegion:regiao animated:YES];
}


// altera os mapas entre satélite, hibrido e padrão
-(IBAction)mudarTipo:(id)sender{
    switch (mapa.mapType) {
        case MKMapTypeStandard:
            [mapa setMapType: MKMapTypeSatellite];
            break;
        
        case MKMapTypeSatellite:
            [mapa setMapType:MKMapTypeHybrid];
            break;
            
        default:
            [mapa setMapType:MKMapTypeStandard];
            break;
    }
}

-(IBAction)ondeEstou:(id)sender{
    [self limparPinos];
    
    //verifica se o servico de GPS está ativo
    if ([CLLocationManager locationServicesEnabled]) {
        
        if (!locManager) {
            // instanciando o servico de GPS
            locManager = [[CLLocationManager alloc] init];
            locManager.delegate = self;
        }
        
        // inicia a atualização de minha localizacao
        [locManager startUpdatingLocation];
    }
}

//metodo que recebe a posicao do gps
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    // ultima localização do GPS
    CLLocation *minhaLocalizacao = [locations lastObject];
    
    //cria ponto no mapa
    MKPointAnnotation *pino = [[MKPointAnnotation alloc] init];
    
    pino.coordinate = minhaLocalizacao.coordinate;
    
    
    // add titulo e subtitulo
    pino.title = @"Estou Aqui!!!";
    pino.subtitle = [NSString stringWithFormat:@"Lat: %f. Long: %f. Alt: %f", minhaLocalizacao.coordinate.latitude,
                     minhaLocalizacao.coordinate.longitude, minhaLocalizacao.altitude];
    
    // adiciona no mapa
    [mapa addAnnotation:pino];
    
    //criando uma taxa de zoom para o mapa
    MKCoordinateSpan zoom = MKCoordinateSpanMake(0.01, 0.01);
    
    //criando a regiao que recebera o zoom no mapa
    MKCoordinateRegion regiao = MKCoordinateRegionMake(pino.coordinate, zoom);
    
    // adicionado a regiao com zoom no mapa de forma animada.
    [mapa setRegion:regiao animated:YES];
    
    // para de fazer a busca no GPS
    [locManager stopUpdatingLocation];
}

-(IBAction)voltar:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
