//
//  HistoricoViewController.m
//  NutriApp
//
//  Created by Bruno Omella Mainieri on 3/30/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "HistoricoViewController.h"
#import "../Business/HojeSingleton.h"
#import "../Entidades/Alimento.h"
#import "../Entidades/Refeicoes.h"
#import "../Entidades/RefeicoesAlimento.h"

@interface HistoricoViewController ()

@end

NSMutableArray *historicoDia;

@implementation HistoricoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];

    HojeSingleton *hs = [HojeSingleton sharedInstance];
    historicoDia = [hs historicoDoDia];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return historicoDia.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[historicoDia objectAtIndex:section] count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, -20, tableView.frame.size.width, 18)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 2, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    if (section == 0){
        [label setText:NSLocalizedString(@"Café da manha", nil)];
    }
    if (section == 1){
        [label setText:NSLocalizedString(@"Almoço", nil)];
    }
    if (section == 2){
        [label setText:NSLocalizedString(@"Lanche", nil)];
    }
    if (section == 3){
        [label setText:NSLocalizedString(@"Jantar", nil)];
    }
    [header addSubview:label];
    [header setBackgroundColor:[UIColor grayColor]];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseIdentifier"];

    Refeicoes *r = [[historicoDia objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", [r caloria]];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end