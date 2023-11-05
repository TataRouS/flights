//
//  BannerModel.swift
//  flights
//
//  Created by Nata Kuznetsova on 05.11.2023.
//

import Foundation

struct  BannerModel: Decodable  {
    let copyright: Copyright
}

struct Copyright: Decodable  {
    let text: String?
    let url: String?
}
