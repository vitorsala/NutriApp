//
//  EntityManager.m
//  NutriApp
//
//  Created by Vitor Kawai Sala on 25/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "EntityManager.h"

@implementation EntityManager

static EntityManager *instance;

+(instancetype)sharedInstance{
    static dispatch_once_t dispatcher;
    dispatch_once(&dispatcher,^{
        instance = [[self alloc]init];
    });
    return instance;
}

/**
 *
 *
 *  @param dataBaseName nome do database @"databasename" (sem sufixo .db)
 */
-(void)loadDatabase:(NSString *)dataBaseName{

    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];

    _path = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:dataBaseName]];

    NSFileManager *fm = [NSFileManager defaultManager];

    NSLog(@"%@\n",_path);
    if([fm fileExistsAtPath:_path] == NO){

        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"alimento" ofType:@"db"];

        [fm copyItemAtPath:bundlePath toPath:_path error:nil];

    }

}

-(BOOL)saveData:(NSString *)query{
    sqlite3_stmt *stmt;
    const char *dbpath = [_path UTF8String];
    BOOL success = false;

    if(sqlite3_open(dbpath, &_sqlite) == SQLITE_OK){

        const char *saveStmt = [query UTF8String];
        sqlite3_prepare_v2(_sqlite, saveStmt, -1, &stmt, nil);

        if(sqlite3_step(stmt) == SQLITE_DONE){
            success = true;
        }
        sqlite3_finalize(stmt);
        sqlite3_close(_sqlite);
    }
    return success;
}

-(NSArray *)getData:(NSString *)query andBlk:(id (^)(sqlite3_stmt*))blk{

    sqlite3_stmt *stmt;
    const char *dbpath = [_path UTF8String];
    NSMutableArray *resultSet = [[NSMutableArray alloc] init];
    if(sqlite3_open(dbpath, &_sqlite) == SQLITE_OK){
        const char *query_stmt = [query UTF8String];

        if (sqlite3_prepare_v2(_sqlite, query_stmt, -1, &stmt, NULL) == SQLITE_OK){
            while(sqlite3_step(stmt) == SQLITE_ROW){
                [resultSet addObject:blk(stmt)];
            }
            sqlite3_finalize(stmt);
        }
        sqlite3_close(_sqlite);
    }
    return resultSet;
}

@end
