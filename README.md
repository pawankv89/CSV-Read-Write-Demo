
CSV_ReadWriteDemo
=========

## CSV_ReadWriteDemo .
------------
 Added Some screens here.
 
[![](https://github.com/pawankv89/CSV_ReadWriteDemo/blob/master/images/screen_0.png)]

## Usage
------------
 You can add this method in your `UICollectionView`.


```objective-c

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

```

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).

## Change-log

A brief summary of each this release can be found in the [CHANGELOG](CHANGELOG.mdown). 
