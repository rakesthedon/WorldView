//
//  Country+Extensions.swift
//  WorldView
//
//  Created by Yannick Jacques on 2024-05-28.
//

import Foundation
import WorldViewCoreKit


extension Country: @retroactive Identifiable {

    public var id: String { name }
}
