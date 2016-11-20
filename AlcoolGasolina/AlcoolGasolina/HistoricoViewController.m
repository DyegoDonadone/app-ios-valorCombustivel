//
//  HistoricoViewController.m
//  AlcoolGasolina
//
//  Created by Faculdade Alfa on 05/11/16.
//  Copyright (c) 2016 Faculdade Alfa. All rights reserved.
//

#import "HistoricoViewController.h"
#import "DetalhesViewController.h"

@interface HistoricoViewController ()

@end

@implementation HistoricoViewController

@synthesize dados, tabela;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/dados.plist"];
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        dados = [NSMutableArray arrayWithContentsOfFile:filePath];
    }
    
    [tabela reloadData];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    /* Nº de sessoes da tabela */
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section{
    
    /* Nº de linha dentro da tabela */
    return dados.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /* Criação de celula apartir do prototipo */
    UITableViewCell *celula = [tableView
          dequeueReusableCellWithIdentifier:@"Celula"];
    if(celula == nil){
        celula = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Celula"];
    }
    
    @try {
        // verifica se existe linha da tabela
        if ([dados objectAtIndex:indexPath.row] != nil) {
            
            //carrega de acordo com a insercão do primeiro ao ultimo.
            //NSDictionary *item = [dados objectAtIndex:indexPath.row];
            
            //carregando o dicionario da posicao atual do array, mais atual para antigo.
            NSDictionary *item = [dados objectAtIndex:(dados.count - indexPath.row -1)];
            
            //carrega resultado no Titulo da tabela.
            celula.textLabel.text = [self resultado:item];
            
            // carregando o valor dos combustiveis no subtitulo
            celula.detailTextLabel.text = [NSString
                    stringWithFormat:@"Gasolina: %@. Alcool: %@",
                        [item objectForKey:@"Gasolina"],
                        [item objectForKey:@"Alcool"]];
        }
    }
    @catch (NSException *exception) { }
    @finally {
        return celula;
    }
}

-(NSString *)resultado:(NSDictionary *)item {
    
    float alcool = [[item objectForKey:@"Alcool"] floatValue];
    float gasolina = [[item objectForKey:@"Gasolina"] floatValue];
    
    if (alcool == (gasolina * 0.7)) {
        return @"Tanto faz";
    } else if (alcool < (gasolina * 0.7)) {
        return @"Alcool é melhor";
    } else {
        return @"Gasolina é melhor";
    }
}

/*
 usado para menu
//click capturar o indice
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //busca o dicionario dentro do array, pelo indice da celula clicada.
    NSDictionary *item = [dados objectAtIndex:indexPath.row];
    
    //DetalhesViewController *detalhes =
    
    [self performSegueWithIdentifier:@"telaDetalhe" sender:self];

}
 */

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:self{
    
    if ([segue.identifier isEqualToString:@"telaDetalhe"]) {
        
        //buscando pello indice da linha selecionada
        NSInteger row = [tabela.indexPathForSelectedRow row];
        
        //carregando o dicionario pelo indice selecionado.
        //NSDictionary *item = [dados objectAtIndex:row];
        
        //carregando o dicionario pelo indice
         NSDictionary *item = [dados objectAtIndex:(dados.count - row -1)];
        
        //instanciando o Detalhes, carregendo o destino da segue
        DetalhesViewController *detalhes = segue.destinationViewController;
 
        //carregando o item local, no item da tela de detalhes
        detalhes.item = item;
        
        //desmarcando a selecao da celula da tabela 
        [tabela deselectRowAtIndexPath:tabela.indexPathForSelectedRow animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)voltar:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
