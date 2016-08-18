//
//  NSString+Validation.h
//  NeoSTORE
//
//  Created by neosoft on 04/05/16.
//  Copyright (c) 2016 NeoSOFT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validation)

- (BOOL)validateEmail;
- (BOOL)validateMobileNumber;
- (BOOL)validateZipNumber;
- (BOOL)validateTextForAlphabatesOnly;
- (BOOL)validateTextForAlphaNumerics;
- (BOOL)isEmpty;
- (BOOL)validateNumbers;
@end
