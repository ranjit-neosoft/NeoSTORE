
#import "NSString+StringValidation.h"

@implementation NSString (StringValidation)

- (NSString *)removeWhiteSpaces{
   return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString*)removeHyphen{
    return [self stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
