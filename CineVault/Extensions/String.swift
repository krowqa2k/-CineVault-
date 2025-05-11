//
//  String.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 15/11/2024.
//

import Foundation

extension String {
    func extractYearFromDate() -> String? {
        if self.count >= 4 {
            return String(self.prefix(4))
        }
        return nil
    }
}
