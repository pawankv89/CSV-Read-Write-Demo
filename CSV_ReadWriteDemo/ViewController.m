//
//  ViewController.m
//  CSV_ReadWriteDemo
//
//  Created by Pawan kumar on 9/18/17.
//  Copyright © 2017 Pawan Kumar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong) NSMutableArray *arrayCSV;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _arrayCSV = [[NSMutableArray alloc] init];
    
    //Create CSV File
    [self createCSV_FilebyHelpOfEmployeeJsonFile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
#pragma mark - Get All Eemployee Records by JSON File
- (NSArray *)employeeRecordsJSON {

    /*
     Note:- First Add your Json File in Build Bundle Resources I have attached screen shots.
     */
        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"EmployeeRecords" ofType:@"json"]];

         if(data ==nil){
             return [NSArray new];
         }
        NSError *localError = nil;
        NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
        return (NSArray *)[parsedObject objectForKey:@"employee"];
}

-(void)createCSV_FilebyHelpOfEmployeeJsonFile{
    
    //Get All Employee Records List by Json file
    NSArray *employeeRecords = [self employeeRecordsJSON];
    
    //Create CSV File
    NSMutableString *csvString = [[NSMutableString alloc]initWithCapacity:0];
    [csvString appendString:@"ID, NAME, DEPARTMENT"];
    
    for (int index = 0; index <[employeeRecords count]; index++) {
        
        NSDictionary *employee = [employeeRecords objectAtIndex:index];
        
        [csvString appendString:[NSString stringWithFormat:@"\n%@, %@, %@",[employee valueForKey:@"id"],[employee valueForKey:@"name"],[employee valueForKey:@"department"]]];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"EmployeeRecords.csv"];
    [csvString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"EmployeeRecords.csv path -->%@",filePath);
    
    //Read CSV File from Bundle
    [self readCSV_FilebyHelpOfEmployeeJsonFile];
}
    

-(void)readCSV_FilebyHelpOfEmployeeJsonFile{
    
    NSString *file = [[NSBundle mainBundle] pathForResource:@"EmployeeRecords" ofType:@"csv"];
    
    NSString *content = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    if (!content) return;
    NSArray *rows = [content componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    NSString *trimStr = @"\n\r ";
    NSString *character = @",";
    NSArray *keys = [self trimComponents:[[rows objectAtIndex:0] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:character]] withCharacters:trimStr];
    
    for (int i = 1; i < rows.count-1; i++) {
        NSArray *objects = [self trimComponents:[[rows objectAtIndex:i] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:character]]
                                 withCharacters:trimStr];
        [self.arrayCSV addObject:[NSDictionary dictionaryWithObjects:objects forKeys:keys]];
    }
    
    NSLog(@"EmployeeRecords arrayCSV -->%@",self.arrayCSV);
    
    NSLog(@"Name : %@, Id : %@, Department : %@",self.arrayCSV[0][@"NAME"],self.arrayCSV[0][@"ID"], self.arrayCSV[0][@"DEPARTMENT"] );
    
}
- (NSArray *)trimComponents:(NSArray *)array withCharacters:(NSString *)characters{
        
        NSMutableArray *marray = [[NSMutableArray alloc] initWithCapacity:array.count];
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [marray addObject:[obj stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:characters]]];
        }];
        return marray;
}
    
@end
