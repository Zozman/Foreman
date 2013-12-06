//
//  UIImage+QRCodeGenerator.h
//
//  Created by Oscar Sanderson on 3/8/13.
//  Copyright (c) 2013 Oscar Sanderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QRCodeGenerator)

/******************************************************************************/

+ (UIImage*)QRCodeGenerator:(NSString*)iData
             andLightColour:(UIColor*)iLightColour
              andDarkColour:(UIColor*)iDarkColour
               andQuietZone:(NSInteger)iQuietZone
                    andSize:(NSInteger)iSize;

/******************************************************************************/

@end
