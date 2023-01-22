//
//  Dateformatter + Extension.swift
//  Movve
//
//  Created by Aleksey Kosov on 22.01.2023.
//

import Foundation

extension String {

    func convertDateString() -> String {

      //  let inputDateString = "2022-12-07"
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd"

        let inputDate = inputDateFormatter.date(from: self)

        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "MMM dd, yyyy"

        let outputDateString = outputDateFormatter.string(from: inputDate!)

        return outputDateString

    }// "Dec 07, 2022"

}
