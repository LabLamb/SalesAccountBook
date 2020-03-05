//
//  Copyright © 2020 LabLambWorks. All rights reserved.
//

import UIKit

class Constants {
    
    static let System = (
        DateFormat: "yyyy-MM-dd",
        SupportedMiniumScreenHeight: CGFloat(667.0),
        SupportedMiniumScreenWidth: CGFloat(375.0)
    )
    
    static let UI = (
        TabBarHeight: 49,
        
        Spacing: (
            Height: (
                ExSmall: CGFloat(Constants.System.SupportedMiniumScreenHeight * 0.005),
                Small: CGFloat(Constants.System.SupportedMiniumScreenHeight * 0.01),
                Medium: CGFloat(Constants.System.SupportedMiniumScreenHeight * 0.025),
                Large: CGFloat(Constants.System.SupportedMiniumScreenHeight * 0.05),
                ExLarge: CGFloat(Constants.System.SupportedMiniumScreenHeight * 0.075)
            ),
            
            Width: (
                ExSmall: CGFloat(Constants.System.SupportedMiniumScreenWidth * 0.005),
                Small: CGFloat(Constants.System.SupportedMiniumScreenWidth * 0.01),
                Medium: CGFloat(Constants.System.SupportedMiniumScreenWidth * 0.025),
                Large: CGFloat(Constants.System.SupportedMiniumScreenWidth * 0.05),
                ExLarge: CGFloat(Constants.System.SupportedMiniumScreenWidth * 0.075)
            )
        ),
        
        Font: (
            Bold: (
                ExSmall: UIFont.boldSystemFont(ofSize: 10),
                Small: UIFont.boldSystemFont(ofSize: 12.5),
                Medium: UIFont.boldSystemFont(ofSize: 15),
                Large: UIFont.boldSystemFont(ofSize: 17.5),
                ExLarge: UIFont.boldSystemFont(ofSize: 20)
            ),
            
            Italic: (
                ExSmall: UIFont.italicSystemFont(ofSize: 10),
                Small: UIFont.italicSystemFont(ofSize: 12.5),
                Medium: UIFont.italicSystemFont(ofSize: 15),
                Large: UIFont.italicSystemFont(ofSize: 17.5),
                ExLarge: UIFont.italicSystemFont(ofSize: 20)
            ),
            
            Plain: (
                ExSmall: UIFont.systemFont(ofSize: 10),
                Small: UIFont.systemFont(ofSize: 12.5),
                Medium: UIFont.systemFont(ofSize: 15),
                Large: UIFont.systemFont(ofSize: 17.5),
                ExLarge: UIFont.systemFont(ofSize: 20)
            )
        ),
        
        Sizing: (
            Height: (ExSmall: CGFloat(Constants.System.SupportedMiniumScreenHeight * 0.05),
                     Small: CGFloat(Constants.System.SupportedMiniumScreenHeight * 0.1),
                     Medium: CGFloat(Constants.System.SupportedMiniumScreenHeight * 0.25),
                     Large: CGFloat(Constants.System.SupportedMiniumScreenHeight * 0.5),
                     ExLarge: CGFloat(Constants.System.SupportedMiniumScreenHeight * 0.75),
                     TextFieldDefault: CGFloat(Constants.System.SupportedMiniumScreenHeight * 0.05 * 1.25)
            ),
            
            Width: (
                ExSmall: CGFloat(Constants.System.SupportedMiniumScreenWidth * 0.05),
                Small: CGFloat(Constants.System.SupportedMiniumScreenWidth * 0.1),
                Medium: CGFloat(Constants.System.SupportedMiniumScreenWidth * 0.25),
                Large: CGFloat(Constants.System.SupportedMiniumScreenWidth * 0.5),
                ExLarge: CGFloat(Constants.System.SupportedMiniumScreenWidth * 0.75)
            )
        )
    )
    
}