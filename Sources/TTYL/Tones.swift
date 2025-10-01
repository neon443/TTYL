//
//  Tones.swift
//  TTYL
//
//  Created by neon443 on 30/09/2025.
//

enum NumberTones {
	static let arr: [[[Int]]] = [
		[[1], [2], [3]],
		[[4], [5], [6]],
		[[7], [8], [9]],
		[[0], [0], [0]]
	]
	static func tone(number: Int, x: Double) -> Double {
		var hi: Int = 0
		var low: Int = 0
		if number == 0 { hi = 1; low = 3 }
		if number < 4 {
			low = 0
			hi = number - 1
		}
		
		if number < 7 {
			low = 1
			hi = number - 4
		}
		if number < 10 {
			low = 2
			hi = number - 7
		}
		
		let highTone = HighTone(rawValue: hi)?.freq.wave(x: x) ?? HighTone.`0`.freq.wave(x: x)
		let lowTone = LowTone(rawValue: hi)?.freq.wave(x: x) ?? LowTone.`0`.freq.wave(x: x)
		
		return highTone + lowTone
	}
}

enum HighTone: Int {
	case `0` = 1209
	case `1` = 1336
	case `2` = 1477
	case `3` = 1633
	
	var freq: Frequency {
		return Frequency(rawValue: self.rawValue)
	}
}

enum LowTone: Int {
	case `0` = 697
	case `1` = 770
	case `2` = 852
	case `3` = 941
	
	var freq: Frequency {
		return Frequency(rawValue: self.rawValue)
	}
}
