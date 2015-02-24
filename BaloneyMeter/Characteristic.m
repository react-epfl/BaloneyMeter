//
//  Characteristic.m
//  Chachachat
//
//  Created by Adrian Holzer on 12.07.13.
//
//

#import "Characteristic.h"

@implementation Characteristic



@synthesize currentIndex, values, value, sliderPosition;

- (id)init{
    self = [super init];
    if(self){
        values=[NSArray array];
        self.sliderPosition=0;
    }
    return self;
}



- (id)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        [self setName: [dict objectForKey:@"name"]];
        [self setValue: [dict objectForKey:@"selected"]];
        [self setValues: [dict objectForKey:@"values"]];
        
        int i=0;
        if ([self.value isEqual:@""]) {
            [self setCurrentIndex:-1];
        }else{
            for(NSString* v in values){
                if( [v isEqual:value]){
                    [self setCurrentIndex:i];
                }
                i++;
            }
        }
    }
    return self;
}

- (NSMutableDictionary*)dictionaryRepresentation{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setObject:self.name forKey:@"name"];
    [dict setObject:self.value forKey:@"selected"];
    return dict;
}

- (NSMutableDictionary*)shortDictionaryRepresentation{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    NSString* shortName =self.name;
    NSString* shortValue =self.value;
   shortName = [shortName stringByReplacingOccurrencesOfString:@"Any " withString:@""];
    shortName = shortName.lowercaseString;
    shortValue = shortValue.lowercaseString;
    [dict setObject:shortName forKey:@"name"];
    [dict setObject:shortValue forKey:@"selected"];
    return dict;
}

@end
