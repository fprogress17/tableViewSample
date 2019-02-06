//
//  CharacterDetailViewModel.swift
//  sample
//
//  Created by ᗧ•• Lee on 2/6/19.
//  Copyright © 2019 ᗧ•• Lee. All rights reserved.
//

import Foundation
import UIKit
import SwiftRichString

// viewModel for sat detailViewController

class SchoolSATDetailViewModel{
    
   // school info for selected school from schoolList
    var schoolInfo : NYCSchoolInfo
    
   // sat info that selected school from schoolList
    var satScoreData : SATScoreData
    
    init(schoolInfo : NYCSchoolInfo, satScoreData : SATScoreData ){
        
        self.schoolInfo = schoolInfo;
        self.satScoreData = satScoreData
    }
    
 
 
    // sat score, school info to be displayed in the textView
    // infomation to be displayed can be expanded here
    
      var description : NSMutableAttributedString {
        
        
        // SwiftRichString (3rd party lib for attributed string) is used here
        let styleForSchoolName = Style {
         
            $0.font = SystemFonts.CourierNewPS_BoldItalicMT.font(size: 20)
            $0.color = UIColor.black
        }
        
        let styleForSat = Style {
            $0.font = SystemFonts.CourierNewPSMT.font(size: 18)
          $0.color = UIColor.black
        }
        
        let styleForWebsite = Style {
            $0.font = SystemFonts.CourierNewPS_ItalicMT.font(size: 14)
            $0.color = UIColor.black
            
        }
        
        
        let schoolName = (schoolInfo.schoolName + "\n\n").set(style: styleForSchoolName)
        let math = ("math score : " + satScoreData.math + "\n").set(style: styleForSat)
        let writing = ("writing score : " + satScoreData.writing + "\n").set(style: styleForSat)
        let reading = ("reading score : " + satScoreData.reading + "\n\n").set(style: styleForSat)
        
        let website = ("website : \n" + schoolInfo.schoolWebsite + "\n\n").set(style: styleForWebsite)
        let email = ("email : \n" + schoolInfo.schoolEmail  ).set(style: styleForWebsite)
        
        return schoolName +
               math +
               writing +
               reading +
               website +
               email
       
    }

    
}
