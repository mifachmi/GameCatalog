//
//  String+Ext.swift
//  GameCatalogApp
//
//  Created by Fachmi Dimas Ardhana on 26/01/25.
//

import UIKit

extension String {
    func formattedDate(formFormat inputFormat: String, toFormat outputFormat: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = inputFormat
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = formatter.date(from: self) {
            formatter.dateFormat = outputFormat
            return formatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func htmlAttributedString(fontSize: UIFont)
    -> NSAttributedString? {
        let fontSize = UIFontMetrics.default.scaledFont(for: fontSize)
        let htmlContent = String(
            format: """
                <html>
                <head>
                <style>
                body {
                    font-family: '-apple-system';
                    font-size: %fpx;
                    line-height: 1.4;
                }
                p {
                    margin: 0;
                    padding: 0;
                }
                </style>
                </head>
                <body>
                %@
                </body>
                </html>
                """, fontSize.pointSize, self)
        
        guard let data = htmlContent.data(using: .utf8) else { return nil }
        
        do {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            
            let attributedString = try NSAttributedString(
                data: data,
                options: options,
                documentAttributes: nil
            )
            
            return attributedString
        } catch {
            print("Error converting HTML to attributed string: \(error)")
            return nil
        }
        
    }
}
