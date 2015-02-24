//
//  Characteristic.h
//  Chachachat
//
//  Created by Adrian Holzer on 12.07.13.
//
//

#import <Foundation/Foundation.h>

@interface Characteristic : NSObject

- (id)initWithDictionary:(NSDictionary*) dict;

- (NSMutableDictionary*)dictionaryRepresentation;

- (NSMutableDictionary*)shortDictionaryRepresentation;

@property (nonatomic) float currentIndex;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* value;
@property (strong, nonatomic) NSArray* values;
@property (nonatomic) float sliderPosition;


@end
