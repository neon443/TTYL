//
//  Frequency.swift
//  TTYL
//
//  Created by neon443 on 30/09/2025.
//

import Foundation

struct Frequency: RawRepresentable {
	internal var rawValue: Int
	typealias RawValue = Int
	
	var hz: Int {
		get {
			return rawValue
		}
		set {
			rawValue = newValue
		}
	}
	
	init(rawValue: Int) {
		self.rawValue = rawValue
	}
	
	func wave(x: Double) -> Double {
		return sin(2 * Double.pi * x * Double(hz))
	}
}
