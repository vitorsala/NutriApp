//
//  Refeicoes.h
//  NutriApp
//
//  Created by Vitor Kawai Sala on 31/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define REFEICAO_CAFEMANHA 0
#define REFEICAO_ALMOCO 1
#define REFEICAO_LANCHE 2
#define REFEICAO_JANTAR 3

@class RefeicoesAlimento;

@interface Refeicoes : NSManagedObject

@property (nonatomic, retain) NSDate * data;
@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSNumber * saved;
@property (nonatomic, retain) NSNumber * tipoRefeicao;
/**
 *  NSSet de RefeicoesAlimento na qual estão presente nesta refeição.
 */
@property (nonatomic, retain) NSSet *refeicoesAlimentos;
@end

@interface Refeicoes (CoreDataGeneratedAccessors)

- (void)addRefeicoesAlimentosObject:(RefeicoesAlimento *)value;
- (void)removeRefeicoesAlimentosObject:(RefeicoesAlimento *)value;
- (void)addRefeicoesAlimentos:(NSSet *)values;
- (void)removeRefeicoesAlimentos:(NSSet *)values;

-(double)caloria;
-(double)carboidrado;
-(double)lipidio;

@end
